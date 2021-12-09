# FIFTH WEEKLY ASSASEMENT PERFORMED BY VITALI KUTS


## **1. Spin up 2 Dockers: postgres and mariadb (2)
```bash
 docker pull postgres
 docker pull mariadb
```
Then RUN their id's OR:
### * postgres should listen on 5533 
```bash
docker run --name postgres -p 5533:5432 -e POSTGRES_PASSWORD=p -d postgres
```
###	* mariadb should listen on 3366
```bash
docker run -p 3366:3306 --name mariadb -e MARIADB_ROOT_PASSWORD=p -d mariadb
```
---

## **2. Load the file “big_alien_witness_data.csv” into mariadb (2)
```bash
sudo apt install mysql-client
sudo apt install postgresql-client
```
```bash
gzip -dk big_alien_witness_data.csv.gz
```
###	* create a table called “raw_input” for that file (it’s CSV, so you have to understand the schema by yourself)
```bash
mysql --local-infile=1 -h 0.0.0.0 -u root --port=3366 -p < sql/create_table_raw_input.sql
```
### * load the file into the table “raw_input”
```bash
mysql --local-infile=1 -h 0.0.0.0 -u root --port=3366 -p < sql/load.sql 
```
---

## **3. Think of a “normalized” design for the “raw_input” file and implement it on POSTGRES(3) minimum 2 tables.
Done. But it would be a good thing to check it.
### * create the necessary normalized tables in postgres
```bash
PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -f sql/pos_import.sql
```
---

## **4. Sample data question (3):
### 1. Which city had the most alien witnesses?
Ramla |     1401
```sql
SELECT place, COUNT(*) FROM raw_input GROUP BY place ORDER BY COUNT(*) DESC LIMIT 1;
```
### 2. Which Region had the least alien witnesses?
Europe/Zaporozhye |      507
```sql
SELECT region, COUNT(*) FROM raw_input GROUP BY region ORDER BY COUNT(*) LIMIT 1;
```
### 3. Which time of day (day/night) had the most alien witnesses?
day         |     5061
```sql
SELECT time_of_day, COUNT(*) FROM raw_input GROUP BY time_of_day ORDER BY COUNT(*) DESC LIMIT 1;
```
### 4. How many distinct locations were involved?
COUNT(*) |      165
```sql
SELECT COUNT(*) result FROM (SELECT DISTINCT location_id FROM raw_input) loc LIMIT 1;
```
---

## **5. Create a script that reads the data from mariadb “raw_input” table, and writes the data to postgres new tables (3)
### * it can be several scripts
### * you can do it with file as intermediate step

mysql --local-infile=1 -h 0.0.0.0 -u root --port=3366 -p < sql/dump.sql
sudo cp /var/lib/docker/volumes/3594c5950769655b4a0e984324e64d142aec2ad353649687e10a21c56080a0c4/_data/aliens/*.csv /home/ubuntu

PGPASSWORD=p psql -h 127.17.0.1 -p 5533 -U postgres -f sql/restore.sql
### ** bonus – do it without an intermediate file (3)
---

## **6. Spin off a local kafka cluster (can be standalone) (2)
```bash
wget -c wget -c https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz
tar -xzf kafka_2.13-3.0.0.tgz
```
---

## **7. Create topics based on postgres tables
> Note: !!JAVA SHOULD BE INSTALLED!!
```bash
sudo apt install openjdk-11-jre-headless
java --version
```
first terminal (launching zookeeper)
```bash
cd kafka_2.13-3.0.0
sudo ./bin/zookeeper-server-start.sh config/zookeeper.properties
```
second terminal (launching kafka broker)
```bash
cd kafka_2.13-3.0.0
sudo ./bin/kafka-server-start.sh config/server.properties
```
third terminal (run topics)
```bash
chmod +x kfk_topic.sh
./kfk_topic.sh
```
Kafka broker should notice it:
> [2021-11-07 20:40:23,920] INFO Created log for partition locations_lookup-0 in /tmp/kafka-logs/locations_lookup-0 with properties {}   
> [2021-11-07 20:40:25,704] INFO Created log for partition witnesses_lookup-0 in /tmp/kafka-logs/witnesses_lookup-0 with properties {}  
> [2021-11-07 20:40:27,540] INFO Created log for partition raw_input-0 in /tmp/kafka-logs/raw_input-0 with properties {}   
> [2021-11-07 20:40:29,381] INFO Created log for partition aliens_lookup-0 in /tmp/kafka-logs/aliens_lookup-0 with properties {}   
---

## **8. Create a script that reads data from postgres and streams it to appropriate topic in kafka (5)
### * script should be called stream.sh 
### * stream.sh TABLE_NAME
This script will backup our tables from postgreSQL and push them to apropriate kafka topics
```bash
chmod +x stream.sh
./stream.sh
```
---

## **9. Create A script that reads topics from #6 and writes the data to the same tables in mariadb (5)
```bash
chmod +x pulltoMaria.sh
./pulltoMaria.sh
```

This script doesn't work because of witnesses_lookupFORmaria.txt. It has been dumped incorrect because of "\n". Could it be kafka?