FROM gitinsky/openwrt-builder:latest

RUN su compile -c "git clone git://git.openwrt.org/12.09/openwrt.git /compile/openwrt-1209"

{% if inherit_feeds_in_dockerfile %}
RUN echo -n '' > /compile/openwrt-1209/feeds.conf.default && \
{%for line in feeds_lines %}
echo "{{ line }}" >> /compile/openwrt-1209/feeds.conf.default
{%- if loop.index < feeds_lines|count %}
 && \
{% endif %}
{% endfor %}
{% else %}
COPY feeds.conf.default /compile/openwrt-1209/feeds.conf.default
{% endif %}

RUN cd /compile/openwrt-1209 && su compile -c "./scripts/feeds update -a"
RUN cd /compile/openwrt-1209 && su compile -c "./scripts/feeds install -a"
RUN cd /compile/openwrt-1209 && su compile -c "make defconfig"
RUN cd /compile/openwrt-1209 && su compile -c "make prereq"
RUN cd /compile/openwrt-1209 && su compile -c "make V=99 prepare"

CMD ["/bin/bash"]
