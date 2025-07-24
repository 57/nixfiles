{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "${"$mod"}" = "SUPER";

      bind = [
        "$mod, Return, exec, kitty"
        "$mod, D, exec, wofi --show drun"
        "$mod, Q, killactive,"
        "$mod, E, exec, nautilus"
        "$mod, W, exec, firefox"
        "$mod SHIFT, W, exec, pkill waybar || true; waybar & disown"
        "$mod, F, togglefloating,"
        "$mod, S, exec, hyprctl dispatch togglefloating; hyprctl dispatch resizeactive exact 900 600; hyprctl dispatch movecurrentwindow center"

        ", Print, exec, grimblast copy area"
        "$mod SHIFT, S, exec, grimblast save area ~/Pictures/$(date +%F_%H-%M-%S).png"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      "exec-once" = [
        "hyprpaper"
        "waybar"
        "dunst"
        "hypridle"
        "hyprlock"
      ];

      # Catppuccin Mocha palette
      "$rosewater" = "rgba(f5e0dcff)";
      "$flamingo"  = "rgba(f2cdcdff)";
      "$pink"      = "rgba(f5c2e7ff)";
      "$mauve"     = "rgba(cba6f7ff)";
      "$red"       = "rgba(f38ba8ff)";
      "$maroon"    = "rgba(eba0acff)";
      "$peach"     = "rgba(fab387ff)";
      "$yellow"    = "rgba(f9e2afff)";
      "$green"     = "rgba(a6e3a1ff)";
      "$teal"      = "rgba(94e2d5ff)";
      "$sky"       = "rgba(89dcebff)";
      "$sapphire"  = "rgba(74c7ecff)";
      "$blue"      = "rgba(89b4faff)";
      "$lavender"  = "rgba(b4befeef)";
      "$text"      = "rgba(cdd6f4ff)";
      "$overlay0"  = "rgba(6c7086ff)";
      "$surface0"  = "rgba(313244ff)";
      "$base"      = "rgba(1e1e2eff)";
      "$crust"     = "rgba(11111bff)";

      "bezier" = "ease,0.25,0.1,0.25,1.0";

      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;
        "col.active_border" = "$blue $mauve 45deg";
        "col.inactive_border" = "$surface0";
      };

      decoration = {
        rounding = 10;
        shadow = {
          enabled = "yes";
          range = 20;
          render_power = 10;
          color = "$crust";
        };
      };

      animations = {
        enabled = true;
        animation = [
          "windows, 1, 6, ease, slide"
          "windowsIn, 1, 6, ease, slide"
          "windowsOut, 1, 6, ease, slide"
          "workspaces, 1, 6, ease, slide"
        ];
      };

      windowrulev2 = [
        "opacity 0.90 0.85,class:^(kitty)$"
      ];
    };

    systemd.variables = [ "--all" ];
  };
} 