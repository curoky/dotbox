FROM curoky/dotbox:stage_nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

RUN sudo mkdir -p /o/vcpkg && sudo chown 1000:1000 -R /o \
  && git clone https://github.com/microsoft/vcpkg /o/vcpkg \
  && cd /o/vcpkg \
  && ./bootstrap-vcpkg.sh -disableMetrics
