ARG BASE_IMAGE=ubuntu24.04

FROM curoky/dotbox:stage_${BASE_IMAGE}
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/gcc13/bin:/app/pipx/bin \
  DEBIAN_FRONTEND=noninteractive

COPY --link --from=curoky/dotbox:stage_nixpkg /nix /nix
COPY --link --from=curoky/dotbox:stage_pipx /app/pipx /app/pipx
COPY --link --from=curoky/dotbox:stage_conda /app/conda /app/conda
COPY --link --from=curoky/dotbox:stage_nixpkg /home/nix/.local/state/nix /home/cicada/.local/state/nix
COPY --chown=1000:1000 ./ /app/dotbox

RUN /app/dotbox/dists/docker/script/setup-sys-backport-pkg.sh \
  && /app/dotbox/dists/docker/script/installer/nvidia-ns.sh \
  && dotdrop install --cfg=/app/dotbox/config.yaml --force --profile=devbox-sysconf \
  && dotdrop install --cfg=/app/dotbox/config.yaml --force --profile=devbox-userconf-outofbox

USER cicada
RUN sudo mkdir -p /data/share /data/cache /data/workspace \
  && sudo chown -R cicada:cicada ~ /data \
  && mkdir ~/.nix-defexpr \
  && ln -s ~/.local/state/nix/profiles/profile ~/.nix-profile \
  && ln -s ~/.local/state/nix/profiles/channels ~/.nix-defexpr/channels \
  && dotdrop install --cfg=/app/dotbox/config.yaml --force --profile=devbox-userconf-base

USER root
ENTRYPOINT ["/app/dotbox/dists/docker/script/entrypoint.sh"]
