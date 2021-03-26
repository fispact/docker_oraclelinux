FROM oraclelinux:8
MAINTAINER UKAEA <admin@fispact.ukaea.uk>

# Build-time metadata as defined at http://label-schema.org
ARG PROJECT_NAME
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="$PROJECT_NAME" \
      org.label-schema.description="Oracle Linux docker image for FISPACT-II" \
      org.label-schema.url="http://fispact.ukaea.uk/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/fispact/docker_oraclelinux" \
      org.label-schema.vendor="UKAEA" \
      org.label-schema.version=$VERSION \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.schema-version="1.0"

ENV RUN_SCRIPT ~/.bashrc

WORKDIR /

# Install additional packages
RUN yum -y update && \
    yum install -y wget which make cmake less rsync nano tar xz && \
    yum install -y libgcc gcc-c++ bzip2 && \
    yum install -y gmp-devel mpfr-devel openssl-devel && \
    yum install -y autoconf automake zlib-devel libpng-devel libjpeg-devel bzip2 zip && \
    yum install -y gsl-devel freetype-devel && \
    yum -y install yum-utils && \
    yum -y install python3 && \
    yum -y install python3-devel &&\
    yum -y groupinstall development && \
    yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel && \
    yum install -y readline-devel tk-devel gdbm-devel xz-devel expat-devel

CMD /bin/bash $RUN_SCRIPT
