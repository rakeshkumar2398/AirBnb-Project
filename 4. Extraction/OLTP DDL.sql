CREATE SCHEMA IF NOT EXISTS airbnb_db; 

CREATE TABLE airbnb_db.listings (
    id int,
    host_name VARCHAR(255),
    name VARCHAR(255),
    host_id BIGINT,
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude FLOAT8,
    longitude FLOAT8,
    room_type VARCHAR(255),
    price INT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month FLOAT4,
    calculated_host_listings_count INT,
    number_of_reviews_ltm INT,
    detailed_location TEXT
);
