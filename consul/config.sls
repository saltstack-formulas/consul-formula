{% from slspath + "/map.jinja" import consul with context %}

/etc/consul.d/config.json:
  file.serialize:
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
    - user: consul
    - group: consul
    - mode: 0755
{% endfor %}

/etc/consul.d/services.json:
  file.serialize:
    - user: consul
    - group: consul
    - require:
      - user: consul
    - formatter: json
    - dataset:
        services: {{ consul.register }}
