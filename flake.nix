{
  description = "sintezator's hyprland-noctalia config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia";
  };

  outputs = { self, nixpkgs, noctalia, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.noctalia.nixosModules.default

        ({ pkgs, ... }: {
          programs.hyprland = {
            enable = true;
            xwayland.enable = true;
          };

          programs.noctalia = {
            enable = true;
            recommendedServices.enable = true;
          };

          environment.systemPackages = with pkgs; [
            kitty
            wayland
            vicinae
            kdePackages.dolphin
            kdePackages.qtsvg
            kdePackages.kio
            kdePackages.kio-extras
            kdePackages.kio-fuse
            kdePackages.solid
            kdePackages.kio-admin
            kdePackages.ark
            adwaita-icon-theme
            fastfetch
            fetch
            git
            btop
          ];
        })
      ];
    };
  };
}
