{
  description = "Custom nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.nvim-custom = nixpkgs.callPackage ./neovim.nix { };
  };
}
