create database aliens;
\c aliens;

CREATE TABLE aliens_lookup (
 alien_id SERIAL PRIMARY KEY,
 alien_name VARCHAR(40),
 alien_type VARCHAR(40),
 alien_color VARCHAR(40)
);

CREATE TABLE witnesses_lookup (
 witness_id SERIAL PRIMARY KEY,
 witness_name VARCHAR(40),
 witness_last_name VARCHAR(40),
 witness_address VARCHAR(40),
 witness_age INT
);

CREATE TABLE locations_lookup (
 location_id SERIAL PRIMARY KEY,
 lat FLOAT(40),
 lon FLOAT(40),
 place VARCHAR(40),
 country VARCHAR(40),
 region VARCHAR(40)
);

CREATE TABLE raw_input (
 record_id SERIAL PRIMARY KEY, 
 alien_id INT REFERENCES aliens_lookup.alien_id, 
 witness_id INT REFERENCES witnesses_lookup.witness_id, 
 location_id INT REFERENCES locations_lookup.location_id, 
 time_of_day VARCHAR(20)
);
