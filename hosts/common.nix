# These are settings which should be applied to all current and future machines.

{ config, pkgs, ... } :

{
	# Enable networking
	networking.networkmanager.enable = true;

	# Set localization
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

	# Set nix settings
	nix = {
		settings = {
			experimental-features = [
				"nix-command"
				"flakes"
			];
			auto-optimise-store = true;
			trusted-users = [
				"root" "@wheel"
			];
		};
	};

	# Define a user account
	users.users = {
		aht = {
			isNormalUser = true;
			description = "Asbjørn Holk Thomsen";
			openssh.authorizedKeys.keys = [
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQAmVd2liqsJWR2qE7ZJh5SfOjNTueYuNE+pKbpn+md"
			];
			extraGroups = [ 
				"networkmanager" 
				"wheel" 
			];
		};
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

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
}