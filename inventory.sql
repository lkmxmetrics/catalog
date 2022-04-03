USE magic;
# Which of the cards are needed in mulitple decks?
# Are any owned cards not accounted for in lumulli? How do we get them there?

SELECT 
    card_name, card_value
FROM
    tatyova
WHERE
    card_name IN (SELECT 
            card_name
        FROM
            card_list)
ORDER BY card_value DESC;

SELECT 
    COUNT(c.card_name)
FROM
    card_list AS c
		RIGHT JOIN
    muldrotha AS m ON c.card_name = m.card_name
		RIGHT JOIN
	tatyova AS t ON c.card_name = t.card_name;
    
SELECT 
    COUNT(card_name)
FROM
    lumulli
WHERE
    card_name IN (SELECT 
            card_name
        FROM
            muldrotha)
        AND card_name IN (SELECT 
            card_name
        FROM
            muldrotha);

SELECT 
    *
FROM
    muldrotha AS m
        LEFT JOIN
    tatyova AS t ON m.card_name = t.card_name 
UNION ALL SELECT 
    *
FROM
    muldrotha AS m
        RIGHT JOIN
    tatyova AS t ON m.card_name = t.card_name;


SELECT * 
FROM lumulli
ORDER BY card_value DESC;

SELECT 
    *
FROM
    lumulli
ORDER BY card_value DESC;

SELECT 
    SUM(owned)
FROM
    lumulli;


SELECT 
    COUNT(card_name), AVG(price), set_name
FROM
    all_cards
GROUP BY set_name;

SELECT 
    COUNT(card_name), set_name
FROM
    lumulli
GROUP BY set_name;


SELECT 
    c.card_name,
    l.owned,
    c.price,
    ROUND(l.owned * c.price, 2) AS total
FROM
    card_list AS c
        JOIN
    lumulli AS l ON c.card_name = l.card_name
ORDER BY total DESC;

ALTER TABLE card_list
RENAME TO card_list;

ALTER TABLE card_list
MODIFY COLUMN price INT;

SELECT card_name, price
FROM card_list
WHERE price NOT LIKE '[^a-zA-Z0-9._]'
ORDER BY card_name;

SELECT COUNT(c.card_name), COUNT(a.card_name)
FROM card_list AS c
JOIN all_cards AS a ON c.card_name = a.card_name;

SELECT COUNT(card_name)
FROM all_cards;

SELECT COUNT(*)
FROM card_list;


DROP TABLE all_cards;
CREATE TABLE IF NOT EXISTS all_cards(
	card_name VARCHAR(250),
    price VARCHAR(20),
	set_name VARCHAR(20),
	rarity VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS decklist(
	card_name VARCHAR(50) NOT NULL,
	deck VARCHAR(50) NOT NULL PRIMARY KEY
);

USE magic;
DROP TABLE IF EXISTS lumulli;
CREATE TABLE IF NOT EXISTS lumulli(
	owned INT,
    card_name VARCHAR(250),
    set_name VARCHAR(50),
    rarity VARCHAR(50),
    card_value INT, 
    total_value INT
);

USE magic;
DROP TABLE IF EXISTS tatyova;
CREATE TABlE IF NOT EXISTS tatyova(
	owned INT,
    card_name VARCHAR(250),
    card_value INT
);

CREATE TABLE IF NOT EXISTS muldrotha(
	owned INT,
    card_name VARCHAR(250),
    card_value INT
);

CREATE TABLE IF NOT EXISTS locustgod(
	owned INT,
    card_name VARCHAR(250),
    card_value INT
);
    
    

DROP DATABASE magic;
CREATE DATABASE IF NOT EXISTS magic;
USE magic;