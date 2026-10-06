{ config, pkgs, ... }:
let
	hosts = import ../../hosts.nix;
	ports = {
		homepage = 8082;
		jellyfin = 8096;
		immich = 2283;
	};
in
{
	# Jellyfin
	services.jellyfin = {
		enable = true;
		openFirewall = true;

		group = "users";
		user = "aht";

		configDir = "/home/aht/services/jellyfin/config";
		cacheDir = "/home/aht/services/jellyfin/cache";
		dataDir = "/home/aht/services/jellyfin/data";
	};

	# Immich
	services.postgresql = {
		enable = true;
		ensureDatabases = [
			"aht"
		];
		ensureUsers = [
			{
				name = "aht";
				ensureDBOwnership = true;
			}
		];
	};

	services.immich = {
		enable = true;
		port = ports.immich;
		openFirewall = true;
		host = "0.0.0.0";
		user = "aht";
		group = "users";
		mediaLocation = "/mnt/storage/Pictures";
		database = {
			createDB = false;
			name = "aht";
			user = "aht";
		};
	};

	# Homepage
	services.homepage-dashboard = {
		enable = true;
		listenPort = ports.homepage;
		openFirewall = true;
		allowedHosts = "${hosts.muldyr.ip}:${builtins.toString(ports.homepage)}";
		services = [
			{
				"Test group 1" = [
					{
						"Jellyfin" = {
							description = "Jellyfin";
							href = "${hosts.muldyr.ip}:${builtins.toString(ports.jellyfin)}";
						};
					}
				];
			}
		];
	};
}