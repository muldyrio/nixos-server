{ config, pkgs, ... } :

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		../common.nix
		];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Define hostname
	networking.hostName = "muldyr";

	# Do *not* change or delete!
	system.stateVersion = "26.05";

}
