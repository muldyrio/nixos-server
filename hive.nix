# Import host information from central registry
let
	hosts = import ./hosts.nix;
in
{
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
}