#!/bin/bash

cd /home/ubuntu/kafka_2.13-3.0.0

./bin/kafka-topics.sh --create --topic locations_lookup --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
./bin/kafka-topics.sh --create --topic witnesses_lookup --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
./bin/kafka-topics.sh --create --topic raw_input        --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
./bin/kafka-topics.sh --create --topic aliens_lookup    --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1