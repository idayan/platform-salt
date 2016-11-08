{% set elasticsearch_version = salt['pillar.get']('elasticsearch2:version', '') %}
{% set elasticsearch_directory = salt['pillar.get']('elasticsearch2:directory', '') %}
{% set elasticsearch_datadir = salt['pillar.get']('elasticsearch2:datadir', '') %}
{% set elasticsearch_logdir = salt['pillar.get']('elasticsearch2:logdir', '') %}
{% set elasticsearch_workdir = salt['pillar.get']('elasticsearch2:workdir', '') %}

{% set elasticsearch_confdir = elasticsearch_directory + '/elasticsearch-' + elasticsearch_version + '/config/' %}

elasticsearch-elasticsearch:
  group.present:
    - name: elasticsearch
  user.present:
    - name: elasticsearch
    - gid_from_name: True
    - groups:
      - elasticsearch

elasticsearch-create_elasticsearch_dir:
  file.directory:
    - name: {{elasticsearch_directory}}
    - user: root
    - group: root
    - dir_mode: 777
    - makedirs: True

elasticsearch-create_elasticsearch_datadir:
  file.directory:
    - name: {{elasticsearch_datadir}}
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - makedirs: True

elasticsearch-create_elasticsearch_logdir:
  file.directory:
    - name: {{elasticsearch_logdir}}
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - makedirs: True


elasticsearch-create_elasticsearch_workdir:
  file.directory:
    - name: {{elasticsearch_workdir}}
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - makedirs: True


elasticsearch-dl_and_extract_elasticsearch:
  archive.extracted:
    - name: {{elasticsearch_directory}}
    - user: elasticsearch
    - group: elasticsearch
    - source: https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-{{elasticsearch_version}}.tar.gz
    - source: https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/{{elasticsearch_version}}/elasticsearch-{{elasticsearch_version}}.tar.gz
    - source_hash: https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-{{elasticsearch_version}}.tar.gz.sha1.txt
    - source_hash: https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/{{elasticsearch_version}}/elasticsearch-{{elasticsearch_version}}.tar.gz.sha1
    - archive_format: tar
    - tar_options: v
    - if_missing: {{elasticsearch_directory}}/elasticsearch-{{ elasticsearch_version }}


elasticsearch-copy_configuration_elasticsearch:
  file.managed:
    - source: salt://elasticsearch2/files/templates/elasticsearch.yml.tpl
    - user: elasticsearch
    - group: elasticsearch
    - name: {{elasticsearch_confdir}}/elasticsearch.yml
    - template: jinja

/etc/init/elasticsearch2.conf:
  file.managed:
    - source: salt://elasticsearch2/files/templates/elasticsearch.init.conf.tpl
    - mode: 644
    - template: jinja
    - context:
      installdir: {{elasticsearch_directory}}/elasticsearch-{{ elasticsearch_version }}
      logdir: {{elasticsearch_logdir }}
      datadir: {{elasticsearch_datadir }}
      confdir: {{elasticsearch_confdir }}
      workdir: {{elasticsearch_workdir }}
      defaultconfig: {{elasticsearch_confdir}}/elasticsearch.yml

elastic-ulimit:
  cmd.run:
    - name: ulimit -Sn `ulimit -Hn`
    
elasticsearch-service:
  service.running:
    - name: elasticsearch2
    - enable: true
    - watch:
      - file: /etc/init/elasticsearch2.conf
