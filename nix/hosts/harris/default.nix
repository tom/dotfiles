{ pkgs, ... }:
{
  networking.hostName = "harris";

  system.primaryUser = "tom";

  # nix-darwin doesn't create users - the macOS user must already exist.
  programs.fish.enable = true;
  users.knownUsers = [ "tom" ];
  users.users.tom = {
    uid = 501;
    home = "/Users/tom";
    shell = pkgs.fish;
  };

  home-manager.users.tom = {
    imports = [ ../../home/common.nix ../../home/darwin.nix ];
  };

  system.stateVersion = 5;
}
