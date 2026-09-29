{ config, lib, pkgs, modulesPath, ... }:

{
	# Ensure mergerfs is installed
	environment.systemPackages = with pkgs; [
		mergerfs
	];

	# Define disks
	fileSystems."/mnt/disk/data01" = {
		device = "/dev/disk/by-uuid/2713b2bd-c6af-4b87-a497-613f23fffdda";
		fsType = "ext4";
	};
	
	fileSystems."/mnt/disk/data02" = {
		device = "/dev/disk/by-uuid/77578c93-2e31-4ab9-9dfc-490cf63a3045";
		fsType = "ext4";
	};
	
	fileSystems."/mnt/storage" = {
		depends = [
			"/mnt/disk/data01"
			"/mnt/disk/data02"
		];
		device = "/mnt/disk/data*";
		fsType = "mergerfs";
		options = [
			"defaults" 
			"fsname=mergerfs-storage"
		];
	};

	fileSystems."/mnt/disk/parity01" = {
		depends = [ 
			"/mnt/storage" 
		];
		device = "/dev/disk/by-uuid/1c40e4dd-ac39-42ff-bd0e-0f28b20a725f";
		fsType = "ext4";
	};

	# SnapRAID
	services.snapraid = {
		enable = true;
		parityFiles = [ 
			"/mnt/disk/parity01/snapraid.parity" 
		];
		contentFiles = [
			"/var/snapraid.content"
			"/mnt/disk/parity01/.snapraid.content"
			"/mnt/disk/data01/.snapraid.content"
			"/mnt/disk/data02/.snapraid.content"
		];
		dataDisks = {
			disk01 = "/mnt/disk/data01/";
			disk02 = "/mnt/disk/data02/";
		};
		sync.interval = "03:00";
		scrub.interval = "weekly";
		exclude = [
			"*.unrecoverable"
			"/tmp/"
			"/lost+found/"
			"*.!sync"
		];
	};
}