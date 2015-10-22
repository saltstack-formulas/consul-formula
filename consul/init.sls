{% from "consul/map.jinja" import consul with context %}

unzip:
  pkg.installed

/usr/local/bin:
  file.directory:
    - recuse: True

consul_download:
  file.managed:
    - name: /tmp/{{ consul.version }}_linux_amd64.zip
    - source: https://dl.bintray.com/mitchellh/consul/{{ consul.version }}_linux_amd64.zip
    - source_hash: sha1={{ consul.hash }}
    - unless: test -f /usr/local/bin/consul-{{ consul.version }}

consul_extract:
  cmd.wait:
    - name: unzip /tmp/{{ consul.version }}_linux_amd64.zip -d /tmp
    - watch:
      - file: consul_download

consul_install:
  file.rename:
    - name: /usr/local/bin/consul-{{ consul.version }}
    - source: /tmp/consul
    - require:
      - file: /usr/local/bin
    - watch:
      - cmd: consul_extract

consul_clean:
  file.absent:
    - name: /tmp/{{ consul.version }}_linux_amd64.zip
    - watch:
      - file: consul_install

consul_link:
  file.symlink:
    - target: consul-{{ consul.version }}
    - name: /usr/local/bin/consul
    - watch:
      - file: consul_install

consul_user:
  group.present:
    - name: consul
  user.present: 
    - name: consul
    - createhome: false
    - system: true
    - groups:
      - consul
    - require:
      - group: consul

consul_init_script:
  file.managed:
    {% if salt['test.provider']('service') == 'upstart' %}
    - source: salt://consul/files/consul.upstart
    - name: /etc/init/consul.conf
    - mode: 0644
    {% else %}
    - source: salt://consul/files/consul.sysvinit
    - name: /etc/init.d/consul
    - mode: 0755
    {% endif %}
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}

consul_config_dir:
  file.directory:
    - name: /etc/consul.d
    - user: consul
    - group: consul

consul_data_dir:
  file.directory:
    - name: /var/consul
    - user: consul
    - group: consul

consul_script_dir:
  file.directory:
    - name: /opt/consul/scripts
    - user: consul
    - group: consul

consul_config:
  file.managed:
    - source: salt://consul/files/config.json
    - template: jinja
    - name: /etc/consul.d/config.json
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}
    - user: consul
    - group: consul
    - require:
      - user: consul

{% for script in consul.scripts %}
consul_service_register_{{ loop.index }}:
  file.managed:
    - source: {{ script.source }}
    - name: {{ script.name }}
    - template: jinja
    - user: consul
    - group: consul
    - mode: 0755
{% endfor %}

consul_service_register_config:
  file.managed:
    - source: salt://consul/files/services.json
    - name: /etc/consul.d/services.json
    - template: jinja
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}
    - user: consul
    - group: consul
    - require:
      - user: consul

{% if consul.service != False %}
consul_service:
  service.running:
    - name: consul
{% endif %}

