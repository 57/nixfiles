{ config, pkgs, lib, ... }:

{
  home.username = "fawn";
  home.homeDirectory = "/home/fawn";
  home.stateVersion = "25.05";

  # Externalized configurations
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/zsh.nix
  ];

  home.packages = with pkgs; [
    kitty
    hyprpaper
    waybar
    dunst
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
    grimblast
    lm_sensors

    ripgrep
    fd
    gnutls

    hyfetch

    vesktop
    # Catppuccin theme packages
    catppuccin-gtk
    bibata-cursors
    zsh
    starship
    bat
    eza
    zoxide
    wofi
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # Hyprpaper wallpaper configuration
  xdg.configFile."hyprpaper/hyprpaper.conf".text = ''
    splash = false
    preload = ${config.home.homeDirectory}/.nixfiles/assets/wall.jpg
    wallpaper = ,${config.home.homeDirectory}/.nixfiles/assets/wall.jpg
  '';

  xdg.configFile."doom".source =
   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/doom";

  home.activation = {
    doomSync = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -x "${config.xdg.configHome}/.config/emacs/bin/doom" ]; then
        "${config.xdg.configHome}/.config/emacs/bin/doom" sync
      fi
    '';
  };

  # Pointer/cursor theme: fix missing cursor bugs!
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # Ensure cursor theme is exported system-wide
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # GTK & icons theme for extra cute
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override { variant = "mocha"; };
      name = "Catppuccin-Mocha-Compact-Dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs.git = {
    enable = true;
    userName = "fawn";
    userEmail = "fawnvx@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.firefox = {
    enable = true;

    policies = {
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Proton Pass
        "protonpass@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    # Optionally, configure your default profile (tweaks, settings, etc)
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      # You can add further custom preferences here if you want!
      settings = {
        "browser.startup.homepage" = "https://google.com";
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
      };
    };
  };

  # Dunst: Simple notification daemon with a minimal theme!
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono 11";
        geometry = "400x50-15+49";
        frame_color = "#373b4f";
        separator_color = "frame";
      };
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    extraConfig = ''
      background_opacity 0.9
    '';
  };

  # Let Home Manager manage itself!
  programs.home-manager.enable = true;
}

