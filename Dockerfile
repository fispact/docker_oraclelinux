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
#RUN yum install --nogpgcheck -y wget && \
#    yum install --nogpgcheck -y python3 && \ 
#    yum install --nogpgcheck -y python3-devel &&\ 
#    wget https://public-yum.oracle.com/public-yum-ol7.repo -O /etc/yum.repos.d/public-yum-ol7.repo && \
#    yum  --nogpgcheck -y update && \
#    yum install --nogpgcheck -y which make cmake less rsync nano tar xz && \
#    yum install --nogpgcheck -y libgcc gcc-c++ bzip2 && \
#    yum install --nogpgcheck -y gmp-devel mpfr-devel openssl-devel && \
#    yum install --nogpgcheck -y autoconf automake zlib-devel libpng-devel libjpeg-devel bzip2 zip && \
#    yum install --nogpgcheck -y gsl-devel freetype-devel && \
#    yum install --nogpgcheck -y yum-utils && \
#    yum install --nogpgcheck -y gcc-gfortran && \
#    yum groupinstall --nogpgcheck -y development && \
#    yum install --nogpgcheck -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel && \
#    yum install --nogpgcheck -y readline-devel tk-devel gdbm-devel xz-devel expat-devel

CMD /bin/bash $RUN_SCRIPT
