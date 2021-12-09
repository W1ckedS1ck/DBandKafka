CREATE DATABASE FROM_POST;
USE FROM_POST;

CREATE TABLE aliens_lookup (
 alien_id INT PRIMARY KEY,
 alien_name VARCHAR(40),
 alien_type VARCHAR(40),
 alien_color VARCHAR(40)
);

CREATE TABLE witnesses_lookup (
 witness_id INT PRIMARY KEY,
 witness_name VARCHAR(40),
 witness_last_name VARCHAR(40),
 witness_address VARCHAR(40),
 witness_age INT
);

CREATE TABLE locations_lookup (
 location_id INT PRIMARY KEY,
 lat FLOAT(40),
 lon FLOAT(40),
 place VARCHAR(40),
 country VARCHAR(40),
 region VARCHAR(40)
);

CREATE TABLE raw_input (
 record_id INT, 
 alien_id INT, 
 witness_id INT, 
 location_id INT, 
 time_of_day VARCHAR(20),
 CONSTRAINT fk_alien_id FOREIGN KEY (alien_id) REFERENCES aliens_lookup(alien_id),
 CONSTRAINT fk_witness_id FOREIGN KEY (witness_id) REFERENCES witnesses_lookup(witness_id),
 CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES locations_lookup(location_id)
);