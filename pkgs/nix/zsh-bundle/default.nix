{ lib, stdenv, fetchFromGitHub, zsh, oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions}:

# To make use of this derivation, use the `programs.zsh.enableSyntaxHighlighting` option

stdenv.mkDerivation rec {
  version = "1.0.0";
  pname = "zsh-bundle";

  srcs = [
    (fetchFromGitHub {
      owner = "conda-incubator";
      repo = "conda-zsh-completion";
      rev = "v0.11";
      sha256 = "sha256-OKq4yEBBMcS7vaaYMgVPlgHh7KQt6Ap+3kc2hOJ7XHk=";
      name = "conda-zsh-completion";
    })
    (fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-completions";
      rev = "0.35.0";
      sha256 = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
      name = "zsh-completions";
    })
  ];
  sourceRoot = ".";

  strictDeps = true;
  buildInputs = [ zsh ];

  installPhase = ''
    cp -r ${oh-my-zsh.out} $out/
    chmod +w $out/share/oh-my-zsh/custom/plugins/
    rm -rf $out/share/oh-my-zsh/custom/plugins/zsh-completions
    rm -rf $out/share/oh-my-zsh/custom/plugins/zsh-autosuggestions
    rm -rf $out/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    rm -rf $out/share/oh-my-zsh/custom/plugins/conda-zsh-completion
    cp -r ${zsh-autosuggestions}/ $out/share/oh-my-zsh/custom/plugins/zsh-autosuggestions
    cp -r ${zsh-syntax-highlighting}/ $out/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    cp -r conda-zsh-completion $out/share/oh-my-zsh/custom/plugins/
    cp -r zsh-completions $out/share/oh-my-zsh/custom/plugins/
  '';

  meta = with lib; {
    description = "zsh bundle";
  };
}
