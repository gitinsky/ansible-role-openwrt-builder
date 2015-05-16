FROM ubuntu:12.04.5

RUN apt-get update -y && \
    apt-get install -y \
    git-core build-essential libssl-dev libncurses5-dev unzip subversion mercurial \
    asciidoc bash bc binutils bzip2 fastjar flex git-core g++ gcc util-linux \
    gawk libgtk2.0-dev intltool zlib1g-dev make genisoimage libncurses5-dev \
    libssl-dev patch perl-modules rsync ruby sdcc unzip wget \
    gettext xsltproc zlib1g-dev \
    gcc make unzip zlib1g-dev libncurses-dev libssl-dev \
    gawk sed flex sdcc intltool gettext sharutils bison \
    virtualbox-ose qemu dosfstools syslinux tftp \
    gcc-multilib \
    build-essential subversion git-core libncurses5-dev zlib1g-dev gawk flex quilt libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs unzip \
    nano \
    && rm -rvf /var/lib/apt/lists/*
RUN useradd -m -d /compile -s /bin/bash -c 'To run compiler' compile

CMD ["/bin/bash"]
