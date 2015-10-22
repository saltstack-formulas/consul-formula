{% from "consul/map.jinja" import consul with context %}

unzip:
  pkg.installed

/usr/local/bin:
  file.directory:
    - makedirs: True

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

consul_config_dir:
  file.directory:
    - name: /etc/consul.d
    - user: consul
    - group: consul

consul_runtime_dir:
  file.directory:
    - name: /var/consul
    - user: consul
    - group: consul

consul_data_dir:
  file.directory:
    - name: /usr/share/local/consul
    - user: consul
    - group: consul
    - makedirs: True

# Consul agent
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

# Consul template engine
consul_template_download:
  file.managed:
    - name: /tmp/consul_template_{{ consul.template_version }}_linux_amd64.zip
    - source: https://github.com/hashicorp/consul-template/releases/download/v{{ consul.template_version }}/consul_template_{{ consul.template_version }}_linux_amd64.zip
    - source_hash: sha1={{ consul.template_hash }}
    - unless: test -f /usr/local/bin/consul-template-{{ consul.template_version }}

consul_template_extract:
  cmd.wait:
    - name: unzip /tmp/consul_template_{{ consul.template_version }}_linux_amd64.zip -d /tmp
    - watch:
      - file: consul_template_download

consul_template_install:
  file.rename:
    - name: /usr/local/bin/consul-template-{{ consul.template_version }}
    - source: /tmp/consul-template
    - require:
      - file: /usr/local/bin
    - watch:
      - cmd: consul_template_extract

consul_template_clean:
  file.absent:
    - name: /tmp/consul_template_{{ consul.template_version }}_linux_amd64.zip
    - watch:
      - file: consul_template_install

consul_template_link:
  file.symlink:
    - target: consul-template-{{ consul.version }}
    - name: /usr/local/bin/consul-template
    - watch:
      - file: consul_template_install

# Consul UI
consul_ui_download:
  file.managed:
    - name: /tmp/{{ consul.ui_version }}_web_ui.zip
    - source: https://dl.bintray.com/mitchellh/consul/{{ consul.ui_version }}_web_ui.zip
    - source_hash: sha1={{ consul.ui_hash }}
    - unless: test -f /usr/local/share/consul/ui-{{ consul.ui_version }}

consul_ui_extract:
  cmd.wait:
    - name: unzip /tmp/{{ consul.ui_version }}_web_ui.zip -d /tmp/
    - watch:
      - file: consul_ui_download

consul_ui_install:
  file.rename:
    - name: /usr/local/share/consul/ui-{{ consul.template_version }}
    - source: /tmp/dist
    - require:
      - file: /usr/local/share/consul
    - watch:
      - cmd: consul_ui_extract

consul_ui_clean:
  file.absent:
    - name: /tmp/{{ consul.ui_version }}_web_ui.zip
    - watch:
      - file: consul_ui_install

consul_ui_link:
  file.symlink:
    - target: ui-{{ consul.version }}
    - name: /usr/local/share/consul/ui
    - watch:
      - file: consul_ui_install

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

