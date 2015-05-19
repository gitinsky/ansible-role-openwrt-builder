#!/bin/bash
if test -n "$1"
then
  cp -v /compile/config/$1 /compile/openwrt-{{ unirun_open_wrt_release_version }}/.config
  chown compile:compile /compile/openwrt-{{ unirun_open_wrt_release_version }}/.config
else
  cd /compile/openwrt-{{ unirun_open_wrt_release_version }} && su compile -c "time make defconfig" 2>&1 | tee    /compile/logs/make.log
fi

rm -rf /compile/openwrt-{{ unirun_open_wrt_release_version }}/bin/{{ unirun_open_wrt_arch }}

chown compile:compile /compile/openwrt-{{ unirun_open_wrt_release_version }}/bin
cd /compile/openwrt-{{ unirun_open_wrt_release_version }} && su compile -c "time make V=99"      2>&1 | tee -a /compile/logs/make.log
date > /compile/logs/openwrt-{{ unirun_open_wrt_release_version }}-builder-raw.done
while true
do
  sleep 60
done
