{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.khal
  ];
}

