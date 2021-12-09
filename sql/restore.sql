\c aliens;

\COPY witnesses_lookup FROM '/home/ubuntu/witnesses_lookup.csv';
\COPY locations_lookup FROM '/home/ubuntu/locations_lookup.csv'; 
\COPY aliens_lookup FROM '/home/ubuntu/aliens_lookup.csv';
\COPY raw_input(alien_id,witness_id,location_id,time_of_day) FROM '/home/ubuntu/raw_input.csv';