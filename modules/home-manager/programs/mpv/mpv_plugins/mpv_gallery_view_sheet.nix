{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ffmpeg,
}:
stdenvNoCC.mkDerivation {
  pname = "mpv-gallery-view-contact-sheet";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "occivink";
    repo = "mpv-gallery-view";
    rev = "master";
    sha256 = "u4PQtTKdE357G1X+Ag0Dexd/jhmZVsAXxdUgEp8bMPw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/mpv/scripts
    mkdir -p $out/share/mpv/script-modules
    cp $src/scripts/* $out/share/mpv/scripts
    cp $src/script-modules/gallery.lua $out/share/mpv/script-modules/gallery.lua
    runHook postInstall
  '';

  passthru.scriptName = "contact-sheet.lua";

  propagatedBuildInputs = [ ffmpeg ];

  meta = with lib; {
    description = "Playlist view and contact sheet scripts for mpv";
    homepage = "https://github.com/occivink/mpv-gallery-view";
    platforms = platforms.all;
    maintainers = with maintainers; [ FelipeMarcelino ];
  };
}
