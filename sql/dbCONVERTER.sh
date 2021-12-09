#!/bin/bash

#Backup mariaDB
mysql --local-infile=1 -h 0.0.0.0 -u root --port=3366 -pp < dump.sql

#Move files to workdir

do cp /var/lib/docker/volumes/3594c5950769655b4a0e984324e64d142aec2ad353649687e10a21c56080a0c4/_data/aliens/*.csv /home/ubuntu

#Rollout postgreSQL BD should be created or add here previous script pos import
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -f restore.sql
echo "Done"