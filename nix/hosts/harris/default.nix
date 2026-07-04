{ pkgs, ... }:
{
  networking.hostName = "harris";

  system.primaryUser = "tom";

  # nix-darwin doesn't create users - the macOS user must already exist.
  users.users.tom = {
    home = "/Users/tom";
#    shell = pkgs.fish;
  };

  home-manager.users.tom = {
    imports = [ ../../home/common.nix ../../home/darwin.nix ];
  };

  system.stateVersion = 5;
}