{ pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      vim
      neovim
      curl
      fzf
      bat
      bottom
      nerd-fonts.jetbrains-mono
      cargo
      rustc
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx BAT_THEME GitHub
      set -gx EDITOR nvim
    '';
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "fzf-forgit"; src = pkgs.fishPlugins.forgit.src; }
    ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };

  programs.eza = {
    enable = true;
    colors = "always";
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    extraOptions =[
    ];
    icons = "always";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration= true;
    enableFishIntegration= true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Tom Malone";
        email = "tomjmalone@gmail.com";
      };
      push = { autoSetupRemote = true; };
      init.defaultBranch = "main";
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-style="medium";
      font-size = "13";
      theme = "GitHub Light Colorblind";
      font-thicken=true;
      macos-option-as-alt="right";
    };
  };
}