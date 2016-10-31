{% from slspath+"/map.jinja" import consul with context %}

include:
  - {{ slspath }}.install
  - {{ slspath }}.config
  - {{ slspath }}.service
