CREATE TABLE netflix(
show_id VARCHAR(6),
type VARCHAR(10),	
title	VARCHAR(150),
director VARCHAR(208),
casts	VARCHAR(1000),
country VARCHAR(150),
date_added	VARCHAR(50), 
release_year	INT,
rating VARCHAR(10),
duration VARCHAR(15),	
listed_in	VARCHAR(100),
description VARCHAR(250)
);
DROP TABLE IF EXISTS netflix;
SELECT * FROM  NETFLIX;




SELECT
	COUNT(*) as total_content
FROM netflix;

SELECT
	DISTINCT TYPE
FROM netflix;
	SELECT * FROM  NETFLIX;


--15 BUSINESS PROBLEMS
--1. COUNT the number of movies vs tv shows

SELECT * FROM  NETFLIX;

SELECT
type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type

--2. find the most common ratings for movies and tv shows

SELECT
	type,
	--rating
	MAX(rating)
FROM netflix
GROUP BY 1
	
SELECT * FROM  NETFLIX;

SELECT
	type,
	rating,
	COUNT(*)
	--MAX(rating)
FROM netflix
GROUP BY 1, 2

SELECT
	type,
	rating,
	COUNT(*)
	--MAX(rating)
FROM netflix
GROUP BY 1, 2
ORDER BY 1, 3 DESC
	
--To see the rank:
SELECT
	type,
	rating
FROM
(
SELECT
	type,
	rating,
	COUNT(*),
	RANK() OVER(partition by type order by COUNT(*)DESC)as ranking 
FROM netflix
GROUP BY 1, 2
) as t1
WHERE
	ranking = 1
--ORDER BY 1, 3 DESC


--list all the movies released in a specific year(EG- 2021)
     -- FILTER 2021
	 --movies


SELECT * FROM  netflix
WHERE 
     TYPE = 'Movie'
	 AND
	 release_year = 2021

-- Find the top 5 counntries with modt content on netflix
-- FULL SOLN CODE:
SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	COUNT(show_id) as total_content
FROM  netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- HERE we have multiple data in a single cell to overcome this 

SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) as new_country
from netflix

-- IDENTIFY THE LONGEST MOVIE
SELECT * FROM NETFLIX
WHERE 
	type = 'Movie'
	AND 
	duration = (select max(duration) FROM netflix)

-- find content added in last 5 years


SELECT 
	*
	FROM NETFLIX
	WHERE
	TO_DATE(date_added, 'Month DD ,YYYY')>= CURRENT_DATE - INTERVAL '5 years'

	

--FIND ALL THE MOVIES AND SHOWS BY DIRECTOR 'RAJIV CHILAKA'!

SELECT* FROM NETFLIX
WHERE director LIKE '%Rajiv Chilaka%' 

-- if letter case problem than ilike should be use on place of like.

--LIST ALL THE TV SHOWS WITH MORE THAN 5 SEASONS

SELECT 
*
FROM NETFLIX
WHERE
type = 'TV Show'
AND
SPLIT_PART(duration, ' ',1)::numeric > 5 

-- COUNT THE NO. OF CONTENT ITEM IN EACH GENRE
SELECT
UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,
	COUNT(show_id) AS total_content
FROM NETFLIX
GROUP BY 1