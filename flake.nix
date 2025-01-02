{
	description = "Flake for installing khal from Git and enabling via a module";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
	};

	outputs = { self, nixpkgs, ... }:
	let
		system = builtins.currentSystem;
		pkgs = import nixpkgs { inherit system; };
	in
	{
		packages.${system}.khal = pkgs.python3Packages.buildPythonApplication {
			pname = "khal-git";
			version = "git";
			src = pkgs.fetchFromGitHub {
				owner = "pimutils";
				repo = "khal";
				rev = "master";
			};
			propagatedBuildInputs = with pkgs.python3Packages; [
				urwid
				click
				pytz
				requests
			];
		};

		nixosModules.khal-git = import ./modules/khal-git.nix;

	};
}

