## Docker images description

This role builds multiple docker images. Let me describe the naming idea in these examples:

- ```gitinsky/openwrt-builder-base``` is based on ubuntu 12.04 and just includes required packages
- ```gitinsky/openwrt-1407-builder``` is ready for configuring and compiling openwrt
- ```gitinsky/openwrt-1407-builder-ar71xx``` contains openwrt code that has already compiled default configuration for ```ar71xx``` once.

The idea of “architecture” specific images is simple: first compilation always takes longer. And you get default firmwares and packages as a bonus. These images also produce log files on compilation time, log for ```14.07``` ```ar71xx``` could be found at ```{{ openwrt_config_dir }}/openwrt-1407-builder-ar71xx/logs/make.log```. Firmwares will be buid at ```{{ openwrt_config_dir }}/openwrt-1407-builder/result``` and then rsynced to ```{{ openwrt_config_dir }}/openwrt/```.

## Updating role with more architecture-specific images

- Start container from a basic image, for example:

	```
	docker run --rm \
	-v {{ openwrt_config_dir }}/openwrt-1407-builder/config:/openwrt/config \
	-v {{ openwrt_config_dir }}/openwrt-1407-builder/result:/compile/openwrt-1407/bin \
	-t -i gitinsky/openwrt-1407-builder /bin/bash
	```
2. Run the following command to open ```menuconfig```
	- 14.07:

		```
		cd /compile/openwrt-1407 && rm -v .config && su compile -c "make menuconfig" && cp -v .config /openwrt/config/1407.$(grep '^CONFIG_TARGET_BOARD' .config|cut -d '"' -f 2).config
		```
	* 12.09:

		```
	cd /compile/openwrt-1209 && rm -v .config && su compile -c "make menuconfig" && cp -v .config /openwrt/config/1209.$(grep '^CONFIG_TARGET_BOARD' .config|cut -d '"' -f 2).config
		```

- Change the “Target System”, exit, confirm saving. Configration file will be automatically copied to the ```{{ openwrt_config_dir }}/openwrt-1407-builder/config``` or ```{{ openwrt_config_dir }}/openwrt-1209-builder/config``` folder.
4. Exit container, copy these files to the role. If you are using vagrant, here’s the command that will copy your files to the role templates:

	```
	find {{ openwrt_config_dir }}/openwrt-{1407,1209}-builder/config -type f | xargs -I% cp -v % /vagrant/roles/openwrt-builder/templates/wrtconfigs/
	```
5. Open ```openwrt-builder/tasks/main.yml``` and add your new build task to the end of file similar to the following one:

	```
	- name: build 1407 ar71xx
  	  include: image_manager.yml unirun_open_wrt_release_version=1407 unirun_open_wrt_arch=ar71xx
  	  when: open_wrt_builder_1407 and open_wrt_builder_1407_ar71xx
	```

- Add version and architecture specific variable to default, in this example it is 	```open_wrt_builder_1407_ar71xx: yes```


##  Building firmwares with your modifications

This is done with the [```openwrt-compiler```](https://github.com/gitinsky/ansible-role-openwrt-compiler.git) role.

## Known issues

In ansible 1.9.0.1 and 1.9.1 filter_plugins are not read from roles. The workaround is to clone them to you ansible directory and to define plugins variable in ansible.cfg

```bash
mkdir -vp plugins
git submodule add https://github.com/gitinsky/ansible-filter_plugins.git plugins/filter_plugins
```

ansible.cfg:
```yaml
filter_plugins = ./plugins/filter_plugins
```
