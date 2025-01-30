{
  stdenv,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "mpv-custom-fonts";
  version = "1.0.0";

  # Define the font directories
  fontDirs = [
    ../../fonts/verdana-font-family
    ../../fonts/netflix-sans
    ../../fonts/material-design
  ];

  # Disable unpacking (since we're not using a traditional source archive)
  unpackPhase = "true";

  # Install phase: Copy all font files to the target directory
  installPhase = ''
    # Create the target directory in the Nix store
    mkdir -p $out/share/fonts/truetype

    # Use find to copy all font files (TrueType and OpenType) to the target directory
    ${lib.concatMapStringsSep "\n" (dir: ''
      if [ -d "${dir}" ]; then
        find "${dir}" -type f \( -name '*.ttf' -o -name '*.otf' \) -exec cp --no-preserve=mode {} $out/share/fonts/truetype/ \;
      else
        echo "Warning: Directory ${dir} does not exist."
      fi
    '') fontDirs}

    # Ensure the output directory is not empty
    if [ -z "$(ls -A $out/share/fonts/truetype)" ]; then
      echo "Error: No font files were copied to $out/share/fonts/truetype"
      exit 1
    fi
  '';

  meta = with lib; {
    description = "Custom fonts for the system (Verdana, Netflix Sans, Material Design)";
    license = licenses.free; # Adjust the license as needed
    platforms = platforms.all;
  };
}
