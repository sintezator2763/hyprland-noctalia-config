{
  description = "sintezator's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs.follows НЕ указываем - иначе не будет работать бинарный кэш Cachix
    # (см. настройку nix.settings в configuration.nix)
    noctalia.url = "github:noctalia-dev/noctalia";
  };

  outputs = { self, nixpkgs, noctalia, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # прокидывает inputs во все модули
      modules = [
        ./configuration.nix
      ];
    };
  };
}
