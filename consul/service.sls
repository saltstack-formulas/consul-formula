{% from "consul/map.jinja" import consul, consul_template with context %}

consul-init-script:
  file.managed:
    {% if salt['test.provider']('service') == 'systemd' %}
    - source: salt://consul/files/consul.service
    - name: /etc/systemd/system/consul.service
    - mode: 0644
    {% elif salt['test.provider']('service') == 'upstart' %}
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

consul-template-init-script:
  file.managed:
    {% if salt['test.provider']('service') == 'systemd' %}
    - source: salt://consul/files/consul-template.service
    - name: /etc/systemd/system/consul-template.service
    - mode: 0644
    {% endif %}
    {% if consul_template.service != False %}
    - watch_in:
      - service: consul
    {% endif %}

{% if consul.service != False %}
consul-service:
  service.running:
    - name: consul
{% endif %}
