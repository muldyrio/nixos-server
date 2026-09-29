{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		colmena.url = "github:nix-community/colmena";
	};

	outputs =
		{ nixpkgs, colmena, ...}:

		let
			# Import host information from central registry
			hosts = import ./hosts.nix;
		in
		{
			colmenaHive = colmena.lib.makeHive {
				meta = {
					nixpkgs = import nixpkgs {
						system = "x86_64-linux";
					};
				};

				muldyr = {
					deployment = {
						targetHost = hosts.muldyr.ip;
						targetUser = hosts.muldyr.user;
						tags = hosts.muldyr.tags;
					};

					imports = [
						./hosts/muldyr/configuration.nix
					];
				};
			};
		};
}