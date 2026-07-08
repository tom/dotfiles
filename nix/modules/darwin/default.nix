{ pkgs, lib, inputs, config, ... }:
{
  nix-homebrew = {
    enable = true;

    # Apple Silicon: also set up the Intel prefix under Rosetta 2.
    enableRosetta = true;

    # User owning the Homebrew prefix. Override per-host if a machine
    # uses a different primary user.
    user = lib.mkDefault "tom";

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    # false = taps are only what's declared above (no `brew tap` by hand).
    # Flip to true if you want to add taps imperatively too.
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    # Keep this in sync with nix-homebrew.taps so `brew` and Nix agree
    # on what's tapped.
    taps = builtins.attrNames config.nix-homebrew.taps;
    # casks / brews can go here, or be defined per-host if they differ
     brews = [
       "mas"
     ];
     casks = [
       "firefox"
     ];
     masApps = {
       "ReadKit" = 1615798039;
       "uBlock Origin Lite" = 6745342698;
     };
  };

  # bumping this changes nix-darwin's compatibility expectations - leave
  # at the version you first installed with, unless you know to bump it.
  system.stateVersion = lib.mkDefault 5;
}