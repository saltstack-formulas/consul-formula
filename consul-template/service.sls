{% from "consul-template/map.jinja" import consul_template with context %}

{% for instance, templates in consul_template.instances.iteritems() %}
{% if instance == 'default' -%}
consul-template-service:
{% else -%}
consul-template-{{ instance }}-service:
{% endif %}
  file.managed:
    - source: salt://consul-template/files/consul-template.service.jinja
    {% if instance == 'default' -%}
    - name: /etc/systemd/system/consul-template.service
    {% else -%}
    - name: /etc/systemd/system/consul-template-{{ instance }}.service
    {% endif %}
    - mode: 0644
    - template: jinja
    - context:
      unit:
        {% if instance == 'default' -%}
        name: consul-template
        {% else -%}
        name: consul-template-{{ instance }}
        {% endif %}
      service:
        exec_start:
          - config: /etc/consul-template/{{ instance }}/consul-template.d

{% if instance == 'default' -%}
consul-template:
{% else -%}
consul-template-{{ instance }}:
{% endif %}
  service.running:
    - enable: True
    - watch:
      - file: /etc/consul-template/{{ instance }}/consul-template.d/*
    - require:
      {% if instance == 'default' -%}
      - file: consul-template-service
      {% else %}
      - file: consul-template-{{ instance }}-service
      {% endif %}
{% endfor %}
