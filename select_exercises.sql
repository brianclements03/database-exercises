SHOW databases;
USE albums_db;
-- Explore the structure of the albums table.
DESCRIBE albums;

-- a. How many rows are in the albums table?
SELECT *
FROM albums;
-- 31 rows

-- b. How many unique artist names are in the albums table?
SELECT DISTINCT artist
FROM albums;
-- 22 + 'various artists' = "23"

-- c. What is the primary key for the albums table?
SHOW CREATE TABLE albums;
-- 'id'

-- d. What is the oldest release date for any album in the albums table? 
SELECT release_date
FROM albums;
-- 1967
-- What is the most recent release date?
-- 2011

-- Write queries to find the following information:
-- a. The name of all albums by Pink Floyd
SELECT name
FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon and The Wall

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT name,
	   release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 1967

-- c. The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = "Nevermind";
-- Grunge, Alternative rock

-- d. Which albums were released in the 1990s
SELECT name
FROM albums
WHERE `release_date` >= 1990;
-- see below

-- e. Which albums had less than 20 million certified sales
SELECT name
FROM albums
WHERE sales <= 20000000;
-- see below
-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?/*
SELECT name
FROM albums
WHERE genre = 'Rock';
-- see below