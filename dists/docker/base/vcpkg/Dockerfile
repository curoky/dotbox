FROM curoky/dotbox:stage_nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

RUN sudo mkdir -p /app/vcpkg && sudo chown 1000:1000 -R /o \
  && git clone https://github.com/microsoft/vcpkg /app/vcpkg \
  && cd /app/vcpkg \
  && ./bootstrap-vcpkg.sh -disableMetrics
