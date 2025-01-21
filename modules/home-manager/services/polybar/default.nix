{
  config,
  customLibs,
  lib,
  pkgs,
  ...
}:

let

  openGithubScript = pkgs.writeShellScriptBin "open-github" ''
    ${pkgs.firefox-beta-bin}/bin/firefox-beta -new-tab https://github.com/notifications
  '';

  openCalendar = "${pkgs.xfce.orage}/bin/orage";

  mainBar = import ./bar.nix { inherit config; };

  openGithub = "${openGithubScript}/bin/open-github";

  mypolybar = pkgs.polybarFull.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  # theme adapted from: https://github.com/adi1090x/polybar-themes#-polybar-5
  bars = lib.readFile ./bars.ini;
  colors = lib.readFile ./colors.ini;
  mods1 = lib.readFile ./modules.ini;
  mods2 = lib.readFile ./user_modules.ini;

  bluetoothScript = pkgs.callPackage ./scripts/bluetooth.nix { };
  klsScript = pkgs.callPackage ./scripts/keyboard-layout-switch.nix { };
  monitorScript = pkgs.callPackage ./scripts/monitor.nix { };
  mprisScript = pkgs.callPackage ./scripts/mpris.nix { };
  networkScript = pkgs.callPackage ./scripts/network.nix { };

  bctl = ''
    [module/bctl]
    type = custom/script
    exec = ${bluetoothScript}/bin/bluetooth-ctl
    tail = true
    click-left = ${bluetoothScript}/bin/bluetooth-ctl --toggle &
  '';

  taskwarrior = ''
    [module/bctl]
    type = custom/script
    exec = ${pkgs.taskwarrior3}/bin/task +in +PENDING count
    tail = false
    interval = 600
    format = " ": <label>
  '';

  cal = ''
    [module/clickable-date]
    inherit = module/date
    label = %{A1:${openCalendar}:}%time%%{A}
  '';

  #FIXME: FIx github token
  github = ''
    [module/clickable-github]
    inherit = module/github
    token = ${"env:GITHUB_ACCESS_TOKEN"};
    empty-notifications = true
    user = FelipeMarcelino
    label = %{A1:${openGithub}:}  %notifications%%{A}
  '';

  keyboard = ''
    [module/clickable-keyboard]
    inherit = module/keyboard
    label-layout = %{A1:${klsScript}/bin/kls:}  %layout% %{A}
  '';

  mpris = ''
    [module/mpris]
    type = custom/script

    exec = ${mprisScript}/bin/mpris
    tail = true
    click-left = ${lib.getExe pkgs.spotify}

    label-maxlen = 60

    interval = 2
    format =   <label>
    format-padding = 2
  '';

  customMods = mainBar + bctl + cal + mpris + github + keyboard + taskwarior;

  cfg = config.home.services.polybar or { enable = false; };
in
{

  options.home.services.polybar = lib.mkOption {
    description = "Activating polybar service";
    type = lib.types.attrs;
    default = {
      enable = false;
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      font-awesome # awesome fonts
      material-design-icons # fonts with glyphs
      xfce.orage # lightweight calendar
      nerd-fonts.iosevka
      icomoon-feather
    ];

    programs.spotify-player.enable = true;
    services.mpd.enable = true;
    services.mpd-mpris.enable = true;

    services.polybar = {
      enable = true;
      package = mypolybar;
      config = ./config.ini;
      extraConfig = bars + colors + mods1 + mods2 + customMods;
      # polybar top -l trace (or info) for debugging purposes
      script = ''
        export MONITOR=$(${monitorScript}/bin/monitor)
        echo "Running polybar on $MONITOR"
        export ETH_INTERFACE=$(${networkScript}/bin/check-network eth)
        export WIFI_INTERFACE=$(${networkScript}/bin/check-network wifi)
        echo "Network interfaces $ETH_INTERFACE & $WIFI_INTERFACE"
        polybar top 2>${config.xdg.configHome}/polybar/logs/top.log & disown
        polybar bottom 2>${config.xdg.configHome}/polybar/logs/bottom.log & disown
      '';
    };
  };
}
