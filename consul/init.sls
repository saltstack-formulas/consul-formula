# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as consul with context %}

{%- if consul.get('enabled', True) %}
include:
  - {{ tplroot }}.install
  - {{ tplroot }}.config
  - {{ tplroot }}.service
{%- endif %}
