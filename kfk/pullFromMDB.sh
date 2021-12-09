#!/bin/bash

cd /home/ubuntu/kafka_2.13-3.0.0

cat /home/ubuntu/raw_input.csv        | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic raw_input
cat /home/ubuntu/aliens_lookup.csv    | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic aliens_lookup
cat /home/ubuntu/witnesses_lookup.csv | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic witnesses_lookup
cat /home/ubuntu/locations_lookup.csv | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic locations_lookup
# what the Huck was I doing this? this is unnecessery (так это слово пишется?)))