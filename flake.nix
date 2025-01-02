{
	description = "Flake for installing khal from Git and enabling via a module";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
	in
	{
		packages.${system}."khal-git" = pkgs.python3Packages.buildPythonApplication {
			format = "pyproject";
			pname = "khal-git";
			version = "0.0.0+git";
			src = pkgs.fetchFromGitHub {
				owner = "pimutils";
				repo = "khal";
				rev = "master";
				sha256 = "sha256-TADhBlOjhn29DwP7DRLevxpn3//a4Q5OM60EWyMXKxw=";
			};
			nativeBuildInputs = with pkgs.python3Packages; [
				setuptools
				setuptools_scm
				wheel
			];

			propagatedBuildInputs = with pkgs.python3Packages; [
				click
				click-log
				icalendar
				urwid
				pyxdg
				pytz
				python-dateutil
				configobj
				atomicwrites
				tzlocal
			];

			doCheck = true;

			checkInputs = with pkgs.python3Packages; [
				pytest
				freezegun
				hypothesis
				packaging
				vdirsyncer
			];
		};
	};
}

