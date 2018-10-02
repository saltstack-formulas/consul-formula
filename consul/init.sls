{%- if pillar.get('consul', {}).get('enabled', True) %}
{% from slspath+"/map.jinja" import consul with context %}

include:
  - {{ slspath }}.install
  - {{ slspath }}.config
  - {{ slspath }}.service

{%- endif %}
