#!/bin/bash

cd ~
rm -R PSGRS
mkdir PSGRS

#Save dumps
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -d aliens -c "select * FROM raw_input"         > /home/ubuntu/PSGRS/raw_input.csv
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -d aliens -c "select * FROM aliens_lookup"     > /home/ubuntu/PSGRS/aliens_lookup.csv
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -d aliens -c "select * FROM witnesses_lookup"  > /home/ubuntu/PSGRS/witnesses_lookup.csv
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -d aliens -c "select * FROM locations_lookup"  > /home/ubuntu/PSGRS/locations_lookup.csv

#Pull Dumps From PostgreSQL To Kafka
cd /home/ubuntu/kafka_2.13-3.0.0

cat /home/ubuntu/PSGRS/raw_input.csv        | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic raw_input
cat /home/ubuntu/PSGRS/aliens_lookup.csv    | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic aliens_lookup
cat /home/ubuntu/PSGRS/witnesses_lookup.csv | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic witnesses_lookup
cat /home/ubuntu/PSGRS/locations_lookup.csv | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic locations_lookup