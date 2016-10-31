{%- from slspath+"/map.jinja" import consul with context -%}

consul-init-env:
  file.managed:
    {%- if grains['os_family'] == 'Debian' %}
    - name: /etc/default/consul
    {%- else %}
    - name: /etc/sysconfig/consul
    - makedirs: True
    {%- endif %}
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - CONSUL_USER={{ consul.user }}
      - CONSUL_GROUP={{ consul.group }}

consul-init-file:
  file.managed:
    {%- if salt['test.provider']('service') == 'systemd' %}
    - name: /etc/systemd/system/consul.service
    - source: salt://consul/files/consul.service
    - template: jinja
    - mode: 0644
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - name: /etc/init/consul.conf
    - source: salt://consul/files/consul.upstart
    - mode: 0644
    {%- else %}
    - name: /etc/init.d/consul
    - source: salt://consul/files/consul.sysvinit
    - mode: 0755
    {%- endif %}
    - user: root
    - group: root

{%- if consul.service %}

consul-service:
  service.running:
    - name: consul
    - enable: True
    - watch:
      - file: consul-init-env
      - file: consul-init-file

{%- endif %}
