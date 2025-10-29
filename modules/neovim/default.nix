{pkgs, ...}: let
in {
  programs.neovim = {
    enable = false;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-treesitter.withAllGrammars
          mini-nvim
          gruvbox-nvim
          kanagawa-nvim
        ];
      };
      customLuaRC = ''
        require ('mini.basics').setup()
        require ('mini.tabline').setup()
        require ('mini.pick').setup()
        require ('mini.statusline').setup()
        require ('mini.completion').setup()
        require ('mini.pairs').setup()
        require ('mini.git').setup()
        require ('mini.diff').setup()
        require ('mini.indentscope').setup()
        require ('mini.icons').setup()

        require ('gruvbox').setup({contrast = 'hard'})
        vim.cmd [[colo gruvbox]]

      '';
    };
  };
  environment.systemPackages = [
    pkgs.neovim
  ];
}
