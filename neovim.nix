{ symlinkJoin, neovim-unwrapped, makeWrapper, lib, runCommandLocal, pkgs }:
let
  startPlugins = with pkgs.vimPlugins; [
    which-key-nvim
    telescope-nvim
    plenary-nvim # missing dep of telescope: https://github.com/nix-community/nixvim/issues/4224
    mini-nvim
    nvim-lspconfig
    fidget-nvim
    blink-cmp
    nvim-treesitter.withAllGrammars
    neodev-nvim
  ];

  # Recursively collect plugings and deps
  foldPlugins = builtins.foldl'
    (acc: next: acc ++ [ next ] ++ (foldPlugins (next.dependencies or [ ]))) [ ];

  # Final unique list of plugins
  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  # Create a new package that contains symlinks to plugins
  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/plugins/{start,opt}

    ${
      lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/plugins/start/${lib.getName plugin}")
      startPluginsWithDeps
    }
  '';

  # Bundled LSP backends
  lsp = with pkgs; [
    lua-language-server
    nixd
  ];
in
symlinkJoin {
  name = "neovim-custom";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags '-u' \
      --add-flags '${./init.lua}' \
      --add-flags '--cmd' \
      --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --prefix PATH : ${lib.makeBinPath lsp } \
      --set-default NVIM_APPNAME nvim-custom
    ln -vsfT $out/bin/nvim $out/bin/vi
    ln -vsfT $out/bin/nvim $out/bin/vim
  '';

}
