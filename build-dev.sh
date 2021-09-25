
docker build -t cadotinfo/nsymfony . \
--build-arg BASE_IMAGE=php:7.4-apache  \
--build-arg NODE_VERSION=v16.10.0 \
--build-arg ENABLE_IMAGE_SUPPORT=true \
--build-arg LIBVIPS_VERSION=8.8.3 \
--build-arg ENABLE_DEBUG=true
