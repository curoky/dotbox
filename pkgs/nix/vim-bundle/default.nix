{ lib, stdenv, fetchFromGitHub, vim, vimPlugins}:

let
  inherit (vimPlugins) vim-plug;
  inherit (vimPlugins) delimitMate;
  inherit (vimPlugins) vim-airline;
  inherit (vimPlugins) vim-airline-themes;
  inherit (vimPlugins) vim-colors-solarized;
  inherit (vimPlugins) indentLine;
  inherit (vimPlugins) vim-commentary;
  inherit (vimPlugins) vim-fugitive;
  inherit (vimPlugins) vim-gitgutter;
  inherit (vimPlugins) nerdtree;
  inherit (vimPlugins) nerdtree-git-plugin;
in

stdenv.mkDerivation rec {
  pname = "vim-bundle";
  version = "1.0.0";

  nativeBuildInputs = [ vim ];

  unpackPhase = ":";

  buildPhase = ":";

  installPhase = ''
    cp -r ${vim-plug.src}/ $out/
    chmod +w $out/
    mkdir -p $out/vim-plugin/autoload
    ln -s $out/plug.vim $out/vim-plugin/autoload/
    mkdir -p $out/vim-plugin/plugged
    cp -r ${delimitMate}/ $out/vim-plugin/plugged/delimitMate
    cp -r ${vim-airline}/ $out/vim-plugin/plugged/vim-airline
    cp -r ${vim-airline-themes}/ $out/vim-plugin/plugged/vim-airline-themes
    cp -r ${vim-colors-solarized}/ $out/vim-plugin/plugged/vim-colors-solarized
    cp -r ${indentLine}/ $out/vim-plugin/plugged/indentLine
    cp -r ${vim-commentary}/ $out/vim-plugin/plugged/vim-commentary
    cp -r ${vim-fugitive}/ $out/vim-plugin/plugged/vim-fugitive
    cp -r ${vim-gitgutter}/ $out/vim-plugin/plugged/vim-gitgutter
    cp -r ${nerdtree}/ $out/vim-plugin/plugged/nerdtree
    cp -r ${nerdtree-git-plugin}/ $out/vim-plugin/plugged/nerdtree-git-plugin
  '';

  meta = with lib; {
    description = "vim bundle";
  };
}
