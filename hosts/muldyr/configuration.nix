{ config, pkgs, ... } :

{
	imports =
		[
			./hardware-configuration.nix
			../common.nix
			./disks.nix
			./services.nix
		];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Define hostname
	networking.hostName = "muldyr";

	# Install generally important system packages
	environment.systemPackages = with pkgs; [
		fastfetch
		sqlite
		git
		wget
	];

	# Do *not* change or delete!
	system.stateVersion = "26.05";
}
