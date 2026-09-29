{ config, pkgs, ... }:
let
	hosts = import ../../hosts.nix;
	ports = {
		homepage = 8082;
		jellyfin = 8096;
	};
in
{
	services.jellyfin = {
		enable = true;
		openFirewall = true;

		group = "users";
		user = "aht";

		configDir = "/home/aht/services/jellyfin/config";
		cacheDir = "/home/aht/services/jellyfin/cache";
		dataDir = "/home/aht/services/jellyfin/data";
	};

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