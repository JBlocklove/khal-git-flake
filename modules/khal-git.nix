{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.khal-git
  ];
}

