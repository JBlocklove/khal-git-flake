{
	description = "Flake for installing khal from Git and enabling via a module";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }:
	let
		system = "x86_64-linux"
		pkgs = import nixpkgs { inherit system; };
	in
	{
		packages.${system}."khal-git" = pkgs.python3Packages.buildPythonApplication {
			pname = "khal-git";
			version = "git-master";
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
	};
}

