{% from slspath+"/map.jinja" import consul with context %}

consul-config:
  file.managed:
    - name: /etc/consul.d/config.json
    - source: salt://consul/files/config.json
    - template: jinja
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: 640
    - contents: |
        {{ consul.config | json }}
{%- if consul.service %}
    - watch_in:
      - service: consul
{%- endif %}

{%- for script in consul.scripts %}

consul-script-install-{{ loop.index }}:
  file.managed:
    - name: {{ script.name }}
    - source: {{ script.source }}
    - template: jinja
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: 0755

{%- endfor %}

consul-script-config:
  file.managed:
    - name: /etc/consul.d/services.json
    - source: salt://consul/files/services.json
    - template: jinja
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: 644
    - context:
        register: |
          {{ consul.register | json }}
{%- if consul.service %}
    - watch_in:
      - service: consul
{%- endif %}
