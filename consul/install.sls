{% from "consul/map.jinja" import consul, consul_template with context %}

consul-dep-unzip:
  pkg.installed:
    - name: unzip

consul-bin-dir:
  file.directory:
    - name: /usr/local/bin
    - makedirs: True

# Create consul user
consul-user:
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

# Create directories
consul-config-dir:
  file.directory:
    - name: /etc/consul.d
    - user: consul
    - group: consul

consul-runtime-dir:
  file.directory:
    - name: /var/consul
    - user: consul
    - group: consul

consul-data-dir:
  file.directory:
    - name: /usr/local/share/consul
    - user: consul
    - group: consul
    - makedirs:

consul-template-config-dir:
  file.directory:
    - name: /etc/consul-template.d

consul-template-template-dir:
  file.directory:
    - name: /etc/consul-template/tmpl-source
    - makedirs: True

# Install agent
consul-download:
  file.managed:
    - name: /tmp/consul_{{ consul.version }}_linux_amd64.zip
    - source: https://releases.hashicorp.com/consul/{{ consul.version }}/consul_{{ consul.version }}_linux_amd64.zip
    - source_hash: sha256={{ consul.hash }}
    - unless: test -f /usr/local/bin/consul-{{ consul.version }}

consul-extract:
  cmd.wait:
    - name: unzip /tmp/consul_{{ consul.version }}_linux_amd64.zip -d /tmp
    - watch:
      - file: consul-download

consul-install:
  file.rename:
    - name: /usr/local/bin/consul-{{ consul.version }}
    - source: /tmp/consul
    - require:
      - file: /usr/local/bin
    - watch:
      - cmd: consul-extract

consul-clean:
  file.absent:
    - name: /tmp/consul_{{ consul.version }}_linux_amd64.zip
    - watch:
      - file: consul-install

consul-link:
  file.symlink:
    - target: consul-{{ consul.version }}
    - name: /usr/local/bin/consul
    - watch:
      - file: consul-install

# Install UI
consul-ui-download:
  file.managed:
    - name: /tmp/consul_{{ consul.ui_version }}_web_ui.zip
    - source: https://releases.hashicorp.com/consul/{{ consul.version }}/consul_{{ consul.ui_version }}_web_ui.zip
    - source_hash: sha256={{ consul.ui_hash }}
    - unless: test -d /usr/local/share/consul/ui-{{ consul.ui_version }}

consul-ui-extract:
  cmd.wait:
    - name: unzip /tmp/consul_{{ consul.ui_version }}_web_ui.zip -d /tmp/dist
    - watch:
      - file: consul-ui-download

consul-ui-install:
  file.rename:
    - name: /usr/local/share/consul/ui-{{ consul.ui_version }}
    - source: /tmp/dist
    - require:
      - file: /usr/local/share/consul
    - watch:
      - cmd: consul-ui-extract

consul-ui-clean:
  file.absent:
    - name: /tmp/consul_{{ consul.ui_version }}_web_ui.zip
    - watch:
      - file: consul-ui-install

consul-ui-link:
  file.symlink:
    - target: ui-{{ consul.ui_version }}
    - name: /usr/local/share/consul/ui
    - watch:
      - file: consul-ui-install

# Install template renderer
consul-template-download:
  file.managed:
    - name: /tmp/consul_template_{{ consul_template.version }}_linux_amd64.zip
    - source: https://releases.hashicorp.com/consul-template/{{ consul_template.version }}/consul-template_{{ consul_template.version }}_linux_amd64.zip
    - source_hash: sha256={{ consul_template.hash }}
    - unless: test -f /usr/local/bin/consul-template-{{ consul_template.version }}

consul-template-extract:
  cmd.wait:
    - name: unzip /tmp/consul_template_{{ consul_template.version }}_linux_amd64.zip -d /tmp
    - watch:
      - file: consul-template-download

consul-template-install:
  file.rename:
    - name: /usr/local/bin/consul-template-{{ consul_template.version }}
    - source: /tmp/consul-template
    - require:
      - file: /usr/local/bin
    - watch:
      - cmd: consul-template-extract

consul-template-clean:
  file.absent:
    - name: /tmp/consul_template_{{ consul_template.version }}_linux_amd64.zip
    - watch:
      - file: consul-template-install

consul-template-link:
  file.symlink:
    - target: consul-template-{{ consul_template.version }}
    - name: /usr/local/bin/consul-template
    - watch:
      - file: consul-template-install
