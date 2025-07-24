{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "memory" "temperature" "pulseaudio" "network" "battery" "tray" ];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format-icons = {
            "default" = ""; # nf-fa-circle-o thin dot
            "active"  = ""; # nf-fa-dot-circle-o filled
            "urgent"  = ""; # exclamation
          };
        };
        clock = { format = " {:%H:%M}"; tooltip-format = " {:%A %d %B %Y}"; };
        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ifname}";
          tooltip-format = "{ipaddr}/{cidr}";
        };
        battery = {
          format = "  {capacity}%";
          format-critical = "  {capacity}%";
          critical = 15;
        };
        pulseaudio = {
          format = "  {volume}%";
          format-muted = "  mute";
          scroll-step = 5;
        };
        cpu = { format = " {usage}%"; };
        memory = { format = " {used:0.1f}G"; };
        temperature = { critical-threshold = 80; format = " {temperatureC}°C"; };
      };
    };
    style = builtins.readFile (pkgs.writeText "waybar-catppuccin.css" ''
      /* Catppuccin Mocha Waybar */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color surface0 #313244;
      @define-color overlay0 #6c7086;
      @define-color text   #cdd6f4;
      @define-color blue   #89b4fa;
      @define-color green  #a6e3a1;
      @define-color peach  #fab387;
      @define-color red    #f38ba8;

      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 12px;
      }

      window#waybar {
        background: rgba(24, 24, 37, 0.85);
        border-bottom: 1px solid @surface0;
        padding: 4px 10px;
      }

      #workspaces {
        margin-right: 12px;
      }

      #workspaces button {
        padding: 0 6px;
        margin: 0 2px;
        background: transparent;
        color: @overlay0;
        border-bottom: 2px solid transparent;
        transition: color 0.2s ease, border-color 0.2s ease;
      }

      #workspaces button.focused {
        color: @text;
        border-color: @blue;
      }

      #workspaces button.active {
        color: @blue;
        border-color: @blue;
      }

      #workspaces button.urgent {
        color: @red;
        border-color: @red;
      }

      #clock, #battery, #network, #pulseaudio, #cpu, #memory, #temperature {
        padding: 0 8px;
      }

      #clock { color: @green; }
      #battery { color: @peach; }
      #network { color: @blue; }
      #pulseaudio { color: @red; }
      #cpu { color: @peach; }
      #memory { color: @overlay0; }
      #temperature { color: @red; }

      #tray > .item {
        padding: 0 6px;
      }
    '');
  };

  programs.wofi = {
    enable = true;
    style = ''
      window {
        background-color: #1e1e2e;
        border: 2px solid #313244;
        border-radius: 10px;
      }
      #input {
        margin: 5px;
        padding: 5px;
        background-color: #313244;
        color: #cdd6f4;
        border-radius: 6px;
      }
      #entry:selected {
        background-color: #313244;
        color: #89b4fa;
      }
      #scroll {
        margin: 5px;
      }
    '';
  };
} 