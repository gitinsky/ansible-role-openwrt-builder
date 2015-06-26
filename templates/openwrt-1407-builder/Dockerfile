FROM gitinsky/openwrt-builder:latest

RUN su compile -c "git clone git://git.openwrt.org/14.07/openwrt.git /compile/openwrt-1407"

RUN cd /compile/openwrt-1407 && su compile -c "./scripts/feeds update -a"
RUN cd /compile/openwrt-1407 && su compile -c "./scripts/feeds install -a"
RUN cd /compile/openwrt-1407 && su compile -c "make defconfig"
RUN cd /compile/openwrt-1407 && su compile -c "make prereq"
RUN cd /compile/openwrt-1407 && su compile -c "make V=99 prepare"

CMD ["/bin/bash"]
