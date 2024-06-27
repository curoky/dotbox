ARG BASE_IMAGE=ubuntu24.04

FROM curoky/dotbox:stage_${BASE_IMAGE}
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin \
  DEBIAN_FRONTEND=noninteractive \
  SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
  NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

COPY --chown=1000:1000 --link --from=curoky/dotbox:stage_nixpkg /nix /nix
COPY --chown=1000:1000 --link --from=curoky/dotbox:stage_conda /app/pipx /app/pipx
COPY --chown=1000:1000 --link --from=curoky/dotbox:stage_conda /app/conda /app/conda
COPY --chown=1000:1000 --link --from=curoky/dotbox:stage_nixpkg /home/nix/.local/state/nix /home/x/.local/state/nix
COPY --chown=1000:1000 ./ /app/dotbox

RUN /app/dotbox/dists/docker/script/setup-sys-conf.sh \
  && /app/dotbox/dists/docker/script/link-tools-to-usr.sh \
  && dotdrop install --cfg=/app/dotbox/config/config.yaml --force --profile=docker-sysconf \
  && dotdrop install --cfg=/app/dotbox/config/config.yaml --force --profile=docker-userconf-final

USER x
RUN sudo mkdir -p /data/share /data/cache /data/workspace \
  && sudo chown x:x ~ /data /app ~/.local /app/conda /app/pipx \
  && mkdir ~/.nix-defexpr \
  && ln -s ~/.local/state/nix/profiles/profile ~/.nix-profile \
  && ln -s ~/.local/state/nix/profiles/channels ~/.nix-defexpr/channels \
  && dotdrop install --cfg=/app/dotbox/config/config.yaml --force --profile=docker-userconf-base

USER root
ENTRYPOINT ["/app/dotbox/dists/docker/script/entrypoint.sh"]
