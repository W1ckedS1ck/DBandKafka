CREATE TABLE locations_lookup (
 location_id SERIAL PRIMARY KEY,
 lat FLOAT(40),
 lon FLOAT(40),
 place VARCHAR(40),
 country VARCHAR(40),
 region VARCHAR(40)
);