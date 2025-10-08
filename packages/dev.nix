{pkgs, ...}:
{
programs.direnv.enable =  true;
programs.git.enable = true;

environment.systemPackages = with pkgs; [
jetbrains.rust-rover
jetbrains.idea-community
jetbrains.rider
];

}
