FROM curoky/dotbox:ubuntu_23.10
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/gcc13/bin:/o/pipx/bin \
  DEBIAN_FRONTEND=noninteractive

COPY --link --from=curoky/dotbox:nixpkg /nix /nix
COPY --link --from=curoky/dotbox:pipx /o/pipx /o/pipx
# COPY --link --from=curoky/dotbox:mamba /o/conda /o/conda
COPY --chown=1000:1000 ./ /o/dotbox

RUN /o/dotbox/images/script/setup-sys-user.sh \
  && /o/dotbox/images/script/setup-sys-backport-pkg.sh \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-sysconf \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-outofbox \
  && mkdir -p /data/share /data/cache /data/workspace \
  && chown cicada:cicada /data/share /data/cache /data/workspace /opt /home/cicada

USER cicada
COPY --link --from=curoky/dotbox:nixpkg /home/nix/.local/state/nix /home/cicada/.local/state/nix
RUN ln -s ~/.local/state/nix/profiles/profile ~/.nix-profile \
  && mkdir ~/.nix-defexpr \
  && ln -s ~/.local/state/nix/profiles/channels ~/.nix-defexpr/channels \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-base

USER root
ENTRYPOINT ["/o/dotbox/images/script/entrypoint.sh"]
