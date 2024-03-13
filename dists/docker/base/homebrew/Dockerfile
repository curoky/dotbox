FROM homebrew/brew:latest

ENV HOMEBREW_NO_ANALYTICS=1

COPY Brewfile install-pkgs.sh .
COPY Formula/ /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/curoky/homebrew-dotbox/Formula/

RUN ./setup-pkg-brew.sh Brewfile \
  && rm -rf "$(brew --cache)"
