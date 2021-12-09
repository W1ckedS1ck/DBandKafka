use aliens;

LOAD DATA LOCAL INFILE 'big_alien_witness_data.csv'
INTO TABLE raw_input
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '^'
IGNORE 1 lines;