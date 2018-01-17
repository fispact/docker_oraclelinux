FROM oraclelinux:7.4
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
    yum install -y wget which make cmake gmake less doxygen rsync nano tar texi2html texinfo xz && \
    yum install -y libgcc gcc-c++ bzip2 && \
    yum install -y gmp-devel mpfr-devel libmpc-devel openssl-devel && \
    yum install -y python-devel autoconf automake zlib-devel libpng-devel libjpeg-devel bzip2 zip && \
    yum install -y gsl-devel lapack-devel freetype-devel && \
    yum -y install yum-utils && \
    yum -y groupinstall development && \
    yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel && \
    yum install -y readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel && \
    export NCPUS=$(getconf _NPROCESSORS_ONLN) && \
    wget http://python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz && \
    tar xf Python-3.6.3.tar.xz && cd Python-3.6.3 && \
    ./configure --prefix=/usr/local --with-ensurepip=install --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make -j${NCPUS} && \
    make altinstall && \
    make install && \
    ln -sf /usr/local/bin/pip3.6 /usr/local/bin/pip && \
    # pip3 packages
    pip install --upgrade pip && \
    pip install pytest pytest-xdist pypact numpy && \
    # clean up
    cd / && rm -rf Python-3.6.3.tar.xz Python-3.6.3

CMD /bin/bash $RUN_SCRIPT
