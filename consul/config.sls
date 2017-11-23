{% from slspath + "/map.jinja" import consul with context %}

consul-config:
  file.serialize:
    - name: /etc/consul.d/config.json
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}
    - user: consul
    - group: consul
    - require:
      - user: consul
    - formatter: json
    - dataset: {{ consul.config }}

{% for script in consul.scripts %}
consul-script-install-{{ loop.index }}:
  file.managed:
    - source: {{ script.source }}
    - name: {{ script.name }}
    - template: jinja
    - context: {{ script.get('context', {}) | yaml }}
    - user: consul
    - group: consul
    - mode: 0755
{% endfor %}

consul-script-config:
  file.serialize:
    - name: /etc/consul.d/services.json
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}
    - user: consul
    - group: consul
    - require:
      - user: consul
    - formatter: json
    - dataset:
        services: {{ consul.register }}
