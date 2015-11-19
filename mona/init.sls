is_monit_installed:
    pkg.installed:
        - name: monit
    service.running:
        - enable: True
        - name: monit
        - watch:
            - file: /etc/monit/monitrc
            - file: /etc/monit/conf.d/*

/etc/monit/monitrc:
    file.managed:
        - source: salt://mona/files/monitrc
        - template: jinja
        - require:
            - pkg: is_monit_installed

/etc/monit/conf.d:
    file.directory:
        - makedirs: True
        - require:
            - pkg: is_monit_installed