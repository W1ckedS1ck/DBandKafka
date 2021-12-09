use aliens;

SELECT DISTINCT alien_id,alien_name,alien_type,alien_color FROM raw_input ORDER BY alien_id INTO OUTFILE 'aliens_lookup.csv';
SELECT DISTINCT witness_id,witness_name,witness_last_name,witness_address,witness_age FROM raw_input ORDER BY witness_id INTO OUTFILE 'witnesses_lookup.csv';
SELECT DISTINCT location_id,lat,lon,place,country,region FROM raw_input ORDER BY location_id INTO OUTFILE 'locations_lookup.csv';
SELECT alien_id,witness_id,location_id, time_of_day FROM raw_input INTO OUTFILE 'raw_input.csv';