{% from "consul-template/map.jinja" import consul_template with context %}

{% for instance, templates in consul_template.instances.iteritems() %}
consul-template-{{ instance }}-dir:
  file.directory:
    - name: /etc/consul-template/{{ instance }}/consul-template.d
    - makedirs: True

# This is a hack to fix https://github.com/saltstack/salt/issues/24436
consul-template-{{ instance }}-ignore-file:
  file.managed:
    - name: /etc/consul-template/{{ instance }}/consul-template.d/.ignore

consul-template-{{ instance }}-tmpl-dir:
  file.directory:
    - name: /etc/consul-template/{{ instance }}/tmpl-source
    - makedirs: True

{% if templates is not none %} 

{% for name, template in templates.iteritems() %}
consul-template-{{ name }}:
  file.serialize:
    - name: /etc/consul-template/{{ instance }}/consul-template.d/{{ name }}.json
    - dataset: {{ template.config }}
    - formatter: json

{% for tmpl in template.config.template %}
consul-template-tmpl-{{ name }}-{{ loop.index }}:
  file.managed:
    - name: {{ tmpl.source }}
    - contents: |
      {{ template.tmpl[loop.index - 1] | indent(8) }}
{% endfor %}
{% endfor %}

{% endif %}
{% endfor %}