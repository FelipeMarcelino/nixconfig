{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "pragmata-monolisa-nerd-fonts";
  version = "1.0.0";

  # Define the font directories
  fontDirs = [
    ../../fonts/Monolisa
    ../../fonts/PragmataPro
    ../../fonts/PragmataPro-Regular0.830
  ];

  # Disable unpacking (since we're not using a traditional source archive)
  unpackPhase = "true";

  # Install phase: Copy only Nerd Fonts to the target directory
  installPhase = ''
    # Create the target directory in the Nix store
    mkdir -p $out/share/fonts/truetype

    # Use find to copy only Nerd Fonts, including those in subdirectories
    ${lib.concatMapStringsSep "\n" (dir: ''
      if [ -d "${dir}" ]; then
        find "${dir}" -type f -name '*Nerd*.ttf' -exec cp --no-preserve=mode {} $out/share/fonts/truetype/ \;
      else
        echo "Warning: Directory ${dir} does not exist."
      fi
    '') fontDirs}

    # Ensure the output directory is not empty
    if [ -z "$(ls -A $out/share/fonts/truetype)" ]; then
      echo "Error: No Nerd Fonts were copied to $out/share/fonts/truetype"
      exit 1
    fi
  '';

  meta = with lib; {
    description = "Custom Nerd Fonts for the system";
    license = licenses.free; # Adjust the license as needed
    platforms = platforms.all;
  };
}
