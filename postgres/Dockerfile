FROM datacats/postgres

MAINTAINER datacats

ADD backup-dump.sql /pg_backup_file.sql
ADD restore.sh /restore.sh
ADD entrypoint.sh /entrypoint.sh

ENV DB_CLUSTER_DIR /db_volume
ENV CKAN_PASSWORD {CKAN_PASSWORD}
ENV DATASTORE_RO_PASSWORD {DATASTORE_RO_PASSWORD}
ENV DATASTORE_RW_PASSWORD {DATASTORE_RW_PASSWORD}
ENV POSTGRES_PASSWORD {POSTGRES_PASSWORD}

RUN /restore.sh

EXPOSE 5432
ENTRYPOINT ["/entrypoint.sh"]
CMD ["hi"]
