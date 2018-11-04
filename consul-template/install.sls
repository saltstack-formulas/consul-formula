{% from slspath + '/map.jinja' import consul_template with context %}

{% set version = consul_template.version %}

consul-template-config-dir:
  file.directory:
    - name: /etc/consul-template.d

consul-template-template-dir:
  file.directory:
    - name: /etc/consul-template/tmpl-source
    - makedirs: True

# Install template renderer
/opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS:
  file.managed:
    - source: https://releases.hashicorp.com/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS
    - makedirs: true
    - skip_verify: true

/opt/consul-template/{{ version }}/bin:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul-template/{{ version }}/consul-template_{{ version }}_linux_amd64.zip
    - source_hash: /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS
    - enforce_toplevel: false
    - require:
      - /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS

/usr/local/bin/consul-template:
  file.symlink:
    - target: /opt/consul-template/{{ version }}/bin/consul-template
    - force: true
    - require:
      - /opt/consul-template/{{ version }}/bin

{% if consul_template.secure_download -%}
/opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS.sig:
  file.managed:
    - source: https://releases.hashicorp.com/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS.sig
    - skip_verify: true
    - require:
      - /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS


/tmp/hashicorp.asc:
  file.managed:
    - source: salt://{{ slspath }}/files/hashicorp.asc.jinja
    - template: jinja
    - context:
      consul_template:
        {{ consul_template | yaml }}

consul_gpg_pkg:
  pkg.installed:
    - name: {{ consul_template.gpg_pkg }}

import key:
  cmd.run:
    - name: gpg --import /tmp/hashicorp.asc
    - unless: gpg --list-keys {{ consul_template.hashicorp_key_id }}
    - require:
      - /tmp/hashicorp.asc
      - consul_gpg_pkg

verify shasums sig:
  cmd.run:
    - name: gpg --verify /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS.sig /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS
    - require:
      - /opt/consul-template/{{ version }}/consul-template_{{ version }}_SHA256SUMS.sig
      - import key
    - prereq:
      - /usr/local/bin/consul-template
{%- endif %}
