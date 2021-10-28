
## We're going to start by making the table and building the different elements available
CREATE DATABASE IF NOT EXISTS mtg;

USE mtg;

CREATE TABLE IF NOT EXISTS inventory(
	card_name VARCHAR(50) NOT NULL PRIMARY KEY,
	set_name VARCHAR(10) NOT NULL,
	rarity VARCHAR (20) NOT NULL, 
    count INT
);


