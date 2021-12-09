CREATE TABLE raw_input (
 record_id SERIAL PRIMARY KEY, 
 alien_id INT REFERENCES aliens_lookup(alien_id), 
 witness_id INT REFERENCES witnesses_lookup(witness_id), 
 location_id INT REFERENCES locations_lookup(location_id), 
 time_of_day VARCHAR(20)
);