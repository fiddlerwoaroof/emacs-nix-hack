{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=934034b7f676e542e0441d1c1087c1ac86b55033";
    emacs-community = {url = "github:nix-community/emacs-overlay";};
    emacs-community.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    emacs-community,
    nixpkgs,
  }: let
    emacs-pkgs = emacs-community.packages.aarch64-darwin;
    emacs = emacs-pkgs.emacs-git;
  in {
    packages.aarch64-darwin.emacs = emacs.overrideAttrs (old: {
      patches = old.patches ++ [./emacs-eln-fix.patch];
      postPatch = ''
        find "$src" -name '*comp-run*'
        pwd; ls
        substituteInPlace "lisp/emacs-lisp/comp-run.el" --replace 'PLACEHOLDER-FOR-PATCH' "${./clean-eln}"
      '';
    });
    packages.aarch64-darwin.default = self.packages.aarch64-darwin.emacs;
  };
}
