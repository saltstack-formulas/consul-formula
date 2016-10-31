{%- from slspath+"/map.jinja" import consul with context -%}

consul-init-file:
  file.managed:
    {%- if salt['test.provider']('service') == 'systemd' %}
    - source: salt://{{ slspath }}/files/consul.service
    - name: /etc/systemd/system/consul.service
    - mode: 0644
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - source: salt://{{ slspath }}/files/consul.upstart
    - name: /etc/init/consul.conf
    - mode: 0644
    {%- else %}
    - source: salt://{{ slspath }}/files/consul.sysvinit
    - name: /etc/init.d/consul
    - mode: 0755
    {%- endif %}

{%- if consul.service %}

consul-service:
  service.running:
    - name: consul
    - enable: True
    - watch:
      - file: consul-init-file

{%- endif %}
