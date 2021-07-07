{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot + '/map.jinja' import consul with context -%}

{% set version = consul.version %}

consul-dep-unzip:
  pkg.installed:
    - name: {{ 'app-arch/unzip' if grains.os_family == 'Gentoo' else 'unzip' }}

consul-bin-dir:
  file.directory:
    - name: /usr/local/bin
    - makedirs: True

# Create consul user
consul-group:
  group.present:
    - name: {{ consul.group }}
    {% if consul.get('group_gid', None) != None -%}
    - gid: {{ consul.group_gid }}
    {%- endif %}

consul-user:
  user.present:
    - name: {{ consul.user }}
    {% if consul.get('user_uid', None) != None -%}
    - uid: {{ consul.user_uid }}
    {% endif -%}
    - groups:
      - {{ consul.group }}
    - home: {{ salt['user.info'](consul.user)['home']|default(consul.config.data_dir) }}
    - createhome: False
    - system: True
    - require:
      - group: consul-group

# Create directories
consul-config-dir:
  file.directory:
    - name: /etc/consul.d
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: '0750'

consul-data-dir:
  file.directory:
    - name: {{ consul.config.data_dir }}
    - makedirs: True
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: '0750'

# Install agent
/opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS:
  file.managed:
    - source: https://releases.hashicorp.com/consul/{{ version }}/consul_{{ version }}_SHA256SUMS
    - makedirs: true
    - skip_verify: true

/opt/consul/{{ version }}/bin:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/{{ version }}/consul_{{ version }}_linux_amd64.zip
    - source_hash: /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS
    - enforce_toplevel: false
    - require:
      - /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS

/usr/local/bin/consul:
  file.symlink:
    - target: /opt/consul/{{ version }}/bin/consul
    - force: true
    - require:
      - /opt/consul/{{ version }}/bin

{% if consul.secure_download -%}
/opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS.sig:
  file.managed:
    - source: https://releases.hashicorp.com/consul/{{ version }}/consul_{{ version }}_SHA256SUMS.sig
    - skip_verify: true
    - require:
      - /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS


/tmp/hashicorp.asc:
  file.managed:
    - source: salt://{{ slspath }}/files/hashicorp.asc.jinja
    - template: jinja
    - context:
      consul:
        {{ consul | yaml }}

import key:
  cmd.run:
    - name: gpg --import /tmp/hashicorp.asc
    - unless: gpg --list-keys {{ consul.hashicorp_key_id }}
    - require:
      - /tmp/hashicorp.asc

verify shasums sig:
  cmd.run:
    - name: gpg --verify /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS.sig /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS
    - require:
      - /opt/consul/{{ version }}/consul_{{ version }}_SHA256SUMS.sig
      - import key
    - prereq:
      - /usr/local/bin/consul
{%- endif %}
