{% from "consul-template/map.jinja" import consul_template with context %}

consul-template-init-script:
  file.managed:
    {% if salt['test.provider']('service') == 'systemd' %}
    - source: salt://consul-template/files/consul-template.service
    - name: /etc/systemd/system/consul-template.service
    - mode: 0644
    {% endif %}
    {% if consul_template.service != False %}
    - watch_in:
      - service: consul
    {% endif %}

{% if consul_template.service != False %}
consul-template-service:
  service.running:
    - name: consul-template
    - watch:
      - file: /etc/consul-template.d/*
{% endif %}
