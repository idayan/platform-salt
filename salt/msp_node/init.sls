include:
  - python-pip

msp-install_python_deps:
  pip.installed:
    - pkgs:
      - cm_api == 11.0.0
      - tornado
      - pip == 8.1.2 
      - elasticsearch == 2.3.0 
      - scipy == 0.17.1 
      - numpy == 1.11.0  
      - networkx == 1.11  
      - geopy == 1.11.0  
      - sklearn ==0.0
      - pandas == 0.18.1
      - sortedcontainers == 1.5.3 
      - pytest == 2.9.2
      - altair == 1.0.0 
      - elasticsearch-dsl == 2.1.0
      - pyjavaproperties

    - reload_modules: True
    - require:
      - pip: python-pip-install_python_pip

msp-add_cdh5_repository:
  pkgrepo.managed:
    - humanname: msp-cloudera-cdh5
    - name: deb [arch=amd64] https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib
    - file: /etc/apt/sources.list.d/msp-cloudera-cdh5.list 
    - refresh: False
    - dist: trusty-cdh5

msp-install-hadoop-hdfs-fuse:
  pkg.installed:
    - name: hadoop-hdfs-fuse
    - skip_verify: True

msp-create-folders:
  file.directory:
    - name:  /vagrant/provision/resources/output_files
    - dir_mode: 777
    - file_mode: 777
    - recurse:
      - mode
    - makedirs: true

msp-create-mount-point:
  file.directory:
    - name: /mnt/hdfs
    - user: hdfs
    - dir_mode: 777

msp-mount-hdfs:
  cmd.run:
    - name: 'mountpoint -q /mnt/hdfs || sudo hadoop-fuse-dfs dfs://HDFS-HA  /mnt/hdfs'
