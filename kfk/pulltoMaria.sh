#!/bin/bash

cd kafka_2.13-3.0.0

#Gathering facts (hi ansible) Not now!! lol
#Gathering info from kafka to files to import. let them will be as txt.
./bin/kafka-console-consumer.sh --topic raw_input        --bootstrap-server localhost:9092 --from-beginning --timeout-ms 2000 > ../raw_inputFORmaria.txt
./bin/kafka-console-consumer.sh --topic aliens_lookup    --bootstrap-server localhost:9092 --from-beginning --timeout-ms 2000 > ../aliens_lookupFORmaria.txt
./bin/kafka-console-consumer.sh --topic witnesses_lookup --bootstrap-server localhost:9092 --from-beginning --timeout-ms 2000 > ../witnesses_lookupFORmaria.txt
./bin/kafka-console-consumer.sh --topic locations_lookup --bootstrap-server localhost:9092 --from-beginning --timeout-ms 2000 > ../locations_lookupFORmaria.txt

#--from-beginning
cd ..
# Upload dumps to Mariadb
mysql --local-infile=1 -h 0.0.0.0 -u root --port=3366 -p < sql/lasttaskupload.sql 