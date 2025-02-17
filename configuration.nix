{ pkgs, modulesPath, inputs, ... }: { 
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.raid.HPSmartArray.enable = true;
  
  environment.systemPackages = with pkgs; [
    inputs.neovim.packages.x86_64-linux.default
    git
  ];
  environment.sessionVariables = {
    EDIOTR = "nvim";
  };
  services.openssh = {
    enable = true;
    PasswordAuthentication = true;
  };
  users.users."bootstrap" = { 
    isNormalUser = true;
    initialPassword = "12345";
    extraGruops = [ "wheel" ];
  };
}
