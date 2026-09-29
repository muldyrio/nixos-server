# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define hostname
  networking.hostName = "muldyr";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone and internationalisation properties
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };
  console.keyMap = "dk-latin1";

  # Trust all in wheel group
  nix.settings.trusted-users = [
    "root" "@wheel"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    aht = {
      isNormalUser = true;
      description = "Asbjørn Holk Thomsen";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQAmVd2liqsJWR2qE7ZJh5SfOjNTueYuNE+pKbpn+md"
      ];
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

/*   # List services that you want to enable:
  programs.git = {
    enable = true;
  };

  # List installed packages
  environment.systemPackages = [
    pkgs.fastfetch
  ]; */

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Enable passwordless sudo for "wheel" group
  security.sudo.wheelNeedsPassword = false;

  # Do *not* change or delete!
  system.stateVersion = "26.05";

}
