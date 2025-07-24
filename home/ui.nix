{ config, pkgs, lib, ... }:
{
  # cursor
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE  = "24";
    # make electron apps use native Wayland so they render crisply when fractional-scaled
    NIXOS_OZONE_WL = "1";                     # legacy flag respected by many nix-packaged Electron builds
    ELECTRON_OZONE_PLATFORM_HINT = "auto";    # new upstream variable (Electron ≥ 28)
  };

  # gtk theme
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override { variant = "mocha"; };
      name    = "Catppuccin-Mocha-Compact-Dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name    = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  # wallpaper via hyprpaper
  xdg.configFile."hyprpaper/hyprpaper.conf".text = ''
    splash    = false
    preload   = ${config.home.homeDirectory}/.nixfiles/assets/wall.jpg
    wallpaper = ,${config.home.homeDirectory}/.nixfiles/assets/wall.jpg
  '';

  # doom emacs link + activation sync
  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixfiles/doom";

  home.activation.doomSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x "${config.xdg.configHome}/.config/emacs/bin/doom" ]; then
      "${config.xdg.configHome}/.config/emacs/bin/doom" sync
    fi
  '';

  # apps
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacs;

  programs.kitty = {
    enable = true;
    theme  = "Catppuccin-Mocha";
    extraConfig = "background_opacity 0.9";
  };

  # dunst notifications
  services.dunst = {
    enable = true;
    settings.global = {
      font            = "JetBrainsMono 11";
      geometry        = "400x50-15+49";
      frame_color     = "#373b4f";
      separator_color = "frame";
    };
  };

  # git config
  programs.git = {
    enable = true;
    userName  = "fawn";
    userEmail = "fawnvx@proton.me";
    extraConfig.init.defaultBranch = "main";
  };

  # firefox with pinned addons
  programs.firefox = {
    enable = true;
    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };
      "protonpass@proton.me" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
        installation_mode = "force_installed";
      };
    };
    profiles.default = {
      id        = 0;
      name      = "default";
      isDefault = true;
      settings = {
        "browser.startup.homepage"   = "https://google.com";
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes"     = 15;
      };
    };
  };

  # let home-manager manage itself
  programs.home-manager.enable = true;
} 