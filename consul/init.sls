{% from "consul/map.jinja" import consul with context %}

include:
  - consul.install
  - consul.config
  - consul.service
