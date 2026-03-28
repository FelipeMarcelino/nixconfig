# This function takes a font package and patches it with Nerd Fonts.
{ stdenv, nerdfonts, fontPackage }:

stdenv.mkDerivation {
  pname = "${fontPackage.pname}-nerd";
  version = fontPackage.version;

  src = fontPackage;

  nativeBuildInputs = [ nerdfonts ];

  # The main build step
  # We find all font files and patch them.
  buildPhase = ''
    set -x
    mkdir -p patched-fonts
    for font in $(find . -name "*.ttf" -o -name "*.otf"); do
      font-patcher --complete --careful --out ./patched-fonts $font
    done
  '';

  # The installation step
  # We install the newly patched fonts into the output directory.
  installPhase = ''
    install -Dm644 ./patched-fonts/* -t $out/share/fonts/truetype
  '';

  meta = {
    description = "Nerd Font patched version of ${fontPackage.pname}";
    homepage = "https://www.nerdfonts.com/";
    license = stdenv.lib.licenses.ofl; # Or appropriate license
  };
}
