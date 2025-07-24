{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "sudo" ];
    };

    shellAliases = {
      ll = "eza -alh --icons";
      ls = "eza --icons";
      gs = "git status";
      emacs = "emacs -nw";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      prompt = "[❯](bold blue) " ;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Let Home Manager handle SHELL switching via programs.zsh
} 