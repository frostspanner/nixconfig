{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-treesitter.withAllGrammars
          mini-nvim
        ];
      };
      customLuaRC = ''
print("hello")
'';
    };
  };
}
