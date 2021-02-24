USE imdb;


/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/

show TABLES;

/* total number of rows in movies */
select count(id), count(*) from movie;
/* 7997 */

select count(movie_id) as rows_, count(*) from genre;
-- 14662



-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

SELECT COUNT(*) AS movie
FROM movie;
-- There are total 7,997 rows

SELECT COUNT(*) AS genre
FROM genre;
-- There are total of 14,662 rows 

SELECT COUNT(*) AS director_mapping
FROM director_mapping;
-- There are total of 3,867 rows 

SELECT COUNT(*) AS role_mapping
FROM role_mapping;
-- There are total of 15,615 rows 

SELECT COUNT(*) AS 'names'
FROM names;
-- There are total of 25,735 rows 

SELECT COUNT(*) AS ratings
FROM ratings;
-- There are total of 7,997 rows






-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT COUNT(id) - COUNT(id) AS id, COUNT(id)- COUNT(title) AS title, COUNT(id) - COUNT(year) AS year_,
COUNT(id)- COUNT(date_published) date_published, COUNT(id)- COUNT(duration) AS duration,
COUNT(id)- COUNT(country) AS country, COUNT(id)- COUNT(worlwide_gross_income) AS worlwide_gross_income,
COUNT(id)-COUNT(languages) AS languages, COUNT(id)- COUNT(production_company) AS production_company
FROM movie;

-- id     title      year_      date_published     duration     country     worlwide_gross_income    languages    production_company
-- 0        0         0               0               0            20               3724                194               528





-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 

-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)
/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below for first part:

SELECT year as Year,
		count(id) AS number_of_movies
FROM movie
GROUP BY year
ORDER BY year asc;

# year, number_of_movies
-- 2017 , 3052
-- 2018 , 2944
-- 2019 , 2001

-- Type your code below for second part:

SELECT  month(date_published) AS month_num,
		count(id) AS number_of_movies
FROM movie
GROUP BY month_num
ORDER BY month_num asc;

# month_num, number_of_movies
# month_num, number_of_movies
-- 1, 804
-- 2, 640
-- 3, 824
-- 4, 680
-- 5, 625
-- 6, 580
-- 7, 493
-- 8, 678
-- 9, 809
-- 10, 801
-- 11, 625
-- 12, 438






/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/

-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

select count(id) as released
from movie
where (country like '%USA%' or country like '%India%') and year = 2019;

-- No of movies were produced in the USA or India in the year 2019 were 1059.






/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT DISTINCT genre
FROM genre
ORDER BY 1;

# genre list
-- Action
-- Adventure
-- Comedy
-- Crime
-- Drama
-- Family
-- Fantasy
-- Horror
-- Mystery
-- Others
-- Romance
-- Sci-Fi
-- Thriller






/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT genre, count(*) AS movies_produced 
FROM genre
GROUP BY genre
ORDER BY 2 desc;

-- genre   movies_produced
-- 'Drama','4285'
-- 'Comedy','2412'
-- 'Thriller','1484'
-- 'Action','1289'
-- 'Horror','1208'
-- 'Romance','906'
-- 'Crime','813'
-- 'Adventure','591'
-- 'Mystery','555'
-- 'Sci-Fi','375'
-- 'Fantasy','342'
-- 'Family','302'
-- 'Others','100'






/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH one_genre AS (
	SELECT movie_id,
		COUNT(genre) AS genres
	FROM genre
	GROUP BY movie_id
	HAVING genres = 1)
SELECT COUNT(movie_id) AS Single_Genre
FROM one_genre;

-- 3289 movies were belong to only one genre.






/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)
/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT genre,
		round(avg(duration),2) as avg_duration
FROM movie m INNER JOIN genre g
ON m.id= g.movie_id
GROUP BY genre
ORDER BY avg_duration desc;

# genre, avg_duration
-- Action, 112.8829
-- Romance, 109.5342
-- Crime, 107.0517
-- Drama, 106.7746
-- Fantasy, 105.1404
-- Comedy, 102.6227
-- Adventure, 101.8714
-- Mystery, 101.8000
-- Thriller, 101.5761
-- Family, 100.9669
-- Others, 100.1600
-- Sci-Fi, 97.9413
-- Horror, 92.7243






/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)
/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH rank_thriller AS
(
SELECT genre,
		count(movie_id) AS movie_count,
        RANK() OVER(ORDER BY count(movie_id) desc) AS genre_rank
FROM genre
GROUP BY genre
)
SELECT *
FROM rank_thriller
WHERE genre= 'thriller';

 # genre, movie_count, genre_rank
-- Thriller, 1484, 3





/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/



-- Segment 2:



-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

SELECT min(avg_rating) AS min_avg_rating,
		max(avg_rating) AS max_avg_rating,
        min(total_votes) AS min_total_votes,
        max(total_votes) AS max_total_votes,
        min(median_rating) AS min_median_rating,
        max(median_rating) AS min_median_rating
FROM ratings;

-- # min_avg_rating 	max_avg_rating 	min_total_votes 	max_total_votes 	min_median_rating	max_median_rating
-- 		1.0					10.0			100				    725138			        1                  10


    



/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

SELECT title,
		avg_rating,
        DENSE_RANK() OVER(ORDER BY avg_rating desc) AS movie_rank
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
LIMIT 10;

# title							avg_rating	movie_rank
-- Kirket							10.0	   1
-- Love in Kilnerry					10.0	   1
-- Gini Helida Kathe				9.8		   2
-- Runam							9.7		   3
-- Fan								9.6		   4
-- Android Kunjappan Version 5.25	9.6		   4
-- Yeh Suhaagraat Impossible		9.5		   5
-- Safe								9.5		   5
-- The Brighton Miracle				9.5		   5
-- Shibu							9.4		   6






/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating,
		COUNT(movie_id)
FROM ratings
GROUP BY median_rating
ORDER BY median_rating desc;

# median_rating , movie_count
-- 10 				346
-- 9 				429
-- 8 				1030
-- 7 				2257
-- 6 				1975
-- 5 				985
-- 4 				479
-- 3 				283
-- 2 				119
-- 1 				94






/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT production_company,
		 COUNT(movie_id) AS movie_count,
         DENSE_RANK() OVER(ORDER BY count(movie_id) desc) AS prod_company_rank
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
WHERE avg_rating > 8 AND production_company IS NOT NULL
GROUP BY production_company
ORDER BY count(movie_id) desc;

# production_company 		movie_count 	prod_company_rank
-- Dream Warrior Pictures 	 3 					1
-- National Theatre Live 	 3					1
-- Lietuvos Kinostudija		 2					2
-- Swadharm Entertainment	 2					2
-- Panorrama Studios         2                  2
-- Marvel Studios            2                  2






-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT genre , COUNT(m.id) AS movie_count
FROM movie m 
JOIN ratings r ON m.id=r.movie_id
JOIN genre g ON m.id=g.movie_id
WHERE total_votes > 1000 AND month(date_published)= 3 AND m.year=2017
AND m.country LIKE '%USA%'
GROUP BY genre
ORDER BY 2 desc;

# genre 	movie_count
-- Drama	 24
-- Comedy	 9
-- Action	 8
-- Thriller	 8
-- Sci-Fi	 7
-- Crime	 6
-- Horror	 6
-- Mystery	 4
-- Romance	 4
-- Fantasy	 3
-- Adventure 3
-- Family	 1






-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT title,
		avg_rating,
		genre
FROM movie m INNER JOIN genre g ON
m.id=g.movie_id INNER JOIN ratings r ON 
m.id= r.movie_id
WHERE title REGEXP '^The.*' AND avg_rating> 8
ORDER BY avg_rating desc;

# title	                     avg_rating	       genre
-- The Brighton Miracle	        9.5	           Drama
-- The Colour of Darkness	    9.1	           Drama
-- The Blue Elephant 2	        8.8	           Drama
-- The Blue Elephant 2	        8.8	           Horror
-- The Blue Elephant 2	        8.8	           Mystery
-- The Irishman	                8.7	           Crime
-- The Irishman					8.7			   Drama
-- The Mystery of Godliness:The Sequel	8.5	   Drama
-- The Gambinos					8.4			   Crime
-- The Gambinos	                8.4	           Drama
-- Theeran Adhigaaram Ondru	    8.3	           Action
-- Theeran Adhigaaram Ondru	    8.3	           Crime
-- Theeran Adhigaaram Ondru	    8.3	           Thriller
-- The King and I	            8.2	           Drama
-- The King and I	            8.2	           Romance







-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT median_rating,COUNT(r.movie_id) AS number_of_movies
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
WHERE date_published BETWEEN '2018-04-01' AND '2019-04-01' AND median_rating=8
GROUP BY median_rating;

-- median rating   number_of_movies
--       8               361






-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

SELECT
CASE
WHEN  ((SELECT  SUM(r.total_votes)
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
WHERE country='germany')  >
(SELECT  sum(r.total_votes)
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
WHERE country='italy'))
THEN  'Yes'
ELSE 'No'
END AS German_gets_more_vote_than_italy;

-- 'YES' German movies get more votes than Italian movies.
-- 17.1 : BELOW CODE IS FOR GERMAN MOVIES TOTAL VOTES :

SELECT SUM(total_votes)
FROM movie m 
JOIN ratings r ON m.id=r.movie_id
WHERE country LIKE '%Germany%';

-- TOTAL VOTES GET FOR GERMAN MOVIES ARE 2026223.
-- 17.2 : BELOW CODE IS FOR ITALIAN MOVIES TOTAL VOTES :

SELECT SUM(total_votes)
FROM movie m 
JOIN ratings r ON m.id=r.movie_id
WHERE country LIKE '%Italy%';

-- TOTAL VOTES GET FOR ITALIAN MOVIES ARE 703024.





-- Answer is Yes.
/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls, 
		SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_nulls, 
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
	SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_nulls
FROM names;

-- name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls
--    0                17335                13431               15226






/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_genre AS
(
SELECT genre,
		count(g.movie_id) AS movie_count
FROM genre g INNER JOIN ratings r ON
g.movie_id=r.movie_id
WHERE avg_rating>8
GROUP BY genre
ORDER BY movie_count
LIMIT 3
),
Top_3_director AS
(
SELECT nm.name AS director_name,
		COUNT(g.movie_id) AS movie_count,
        DENSE_RANK() OVER(ORDER BY count(g.movie_id) desc) AS director_rank,
        ROW_NUMBER() OVER(ORDER BY count(g.movie_id) desc) AS director_rank_row
FROM names nm INNER JOIN director_mapping dm ON
nm.id=dm.name_id INNER JOIN genre g ON
dm.movie_id=g.movie_id INNER JOIN ratings r ON
r.movie_id= g.movie_id,
top_genre
WHERE g.genre IN (top_genre.genre) AND avg_rating>8
GROUP BY director_name
ORDER BY movie_count desc
)
SELECT *
FROM Top_3_director
WHERE director_rank<=3
LIMIT 3;

-- Director_name    movie_count     director_rank     director_rank_row
-- James Mangold        1                  1                  1
-- Anthony Russo        1                  1                  2
-- Joe Russo            1                  1                  3






/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/
-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:
+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT name AS actor_name, 
		count(m.id) AS movie_count

FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id INNER JOIN role_mapping rm ON
m.id= rm.movie_id INNER JOIN names nm ON
rm.name_id=nm.id
WHERE category='actor' AND median_rating>=8
GROUP BY name
ORDER BY movie_count DESC
LIMIT 2;

-- actor_name	|	movie_count
-- Mammootty             8
-- mohanlal              5






/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/
-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT m.production_company, SUM(r.total_votes) total_votes, 
RANK() OVER (ORDER BY SUM(r.total_votes) DESC) votes_rank
FROM movie m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.production_company
ORDER BY 3
LIMIT 3;

-- production_company    |       vote_count			|		prod_comp_rank
-- Marvel Studios                2656967                         1
-- Twentieth Century Fox         2411163                         2
-- Warner Bros                   2396057                         3






/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.
Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT name AS actor_name,
				total_votes,
                COUNT(m.id) AS movie_count,
                ROUND(SUM(avg_rating*total_votes)/sum(total_votes),2) as actor_avg_rating,
                RANK() OVER(ORDER BY avg_rating DESC) AS actor_rank
		
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id INNER JOIN role_mapping rm ON
m.id=rm.movie_id INNER JOIN names nm ON
rm.name_id=nm.id
WHERE category='actor' AND country= 'india'
GROUP BY name
HAVING count(m.id)>=5
LIMIT 1;

--     actor_name	      |	   total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank
-- Vijay Sethupathi               20364                  5                   8.42                  1






-- Top actor is Vijay Sethupathi
-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT name AS actress_name,
				total_votes,
                COUNT(m.id) AS movie_count,
                ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actress_avg_rating,
                RANK() OVER(ORDER BY avg_rating DESC) AS actress_rank
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id INNER JOIN role_mapping rm ON
m.id=rm.movie_id INNER JOIN names nm ON 
rm.name_id=nm.id
WHERE category='actress'  AND country= 'india' AND languages= 'hindi'
GROUP BY name
HAVING COUNT(m.id)>=3
LIMIT 5;

-- actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	 
-- Taapsee pannu       2269                 3                     7.74                  1
-- divya dutta         345                  3                     6.88                  2
-- kriti kharbanda     1280                 4                     4.80                  3
-- Sonakshi Sinha      1367                 4                     4.18                  4






/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/
/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT m.title,
	r.avg_rating,
	CASE
		WHEN avg_rating > 8 THEN 'Superhit'
		WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit'
		WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch'
		ELSE 'Flop movies'
	END AS movie_type
FROM movie m INNER JOIN ratings r
	ON m.id = r.movie_id INNER JOIN genre g
		ON m.id = g.movie_id
WHERE genre = 'thriller';

-- title                 avg_rating          movie_type
-- Deer mude tod           7.7                  hit
-- fahrenheit 451          4.9               flop movies
-- pet Sematary            5.8               one_time_watch
-- dukan                   6.9               one_time_watch
-- back roads              7.0               hit





/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/



-- Segment 4:



-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT genre,
		ROUND(avg(duration),2) AS avg_duration,
        SUM(AVG(duration)) OVER(ORDER BY genre rows unbounded preceding) AS running_total_duration,
        AVG(AVG(duration)) OVER(ORDER BY genre rows 13 preceding) AS moving_avg_duration
FROM movie m INNER JOIN genre g ON
m.id= g.movie_id
GROUP BY genre
ORDER BY genre;

-- # genre     avg_duration     running_total_duration     moving_avg_duration
-- Action         112.88             112.8829                     112.8829
-- Adventure      101.87             214.7543                     107.3771
-- Comedy         102.62             317.3770                     105.7923
-- Crime          107.05             424.4287                     106.1071
-- Drama          106.77             531.2033                     106.2406
-- Family         100.97             632.1702                     105.3617
-- Fantasy        105.14             737.3106                     105.3300
-- Horror         92.72              830.0349                     103.7543
-- Mystery        101.80             931.8349                     103.5372
-- Others         100.16             1031.994                     103.1994
-- Romance        109.53             1141.529                     103.7753
-- Sci-Fi         97.94              1239.470                     103.2892
-- Thriller       101.58             1341.046                     103.1574





-- Round is good to have and not a must have; Same thing applies to sorting
-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
-- Top 3 Genres based on most number of movies:

SELECT genre,
	COUNT(movie_id) AS movie_count
FROM genre
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 3;

-- The TOP 3 genre are 'Drama', 'Comedy' and 'Thriller'.

-- Type your code below :( the five highest-grossing movies of each year that belong to the top three genres )

WITH Top AS (
	SELECT g.genre,
		m.year,
		m.title AS movie_name,
		m.worlwide_gross_income,
		DENSE_RANK () OVER ( PARTITION BY year
							 ORDER BY worlwide_gross_income DESC) AS movie_rank
	FROM movie m INNER JOIN genre g
		ON m.id = g.movie_id
	WHERE genre IN ('Drama', 'Comedy', 'Thriller') AND worlwide_gross_income IS NOT NULL)

SELECT *
FROM Top
WHERE movie_rank <= 5
GROUP BY (movie_name);

-- genre		year		movie_name		           worldwide_gross_income          movie_rank
-- drama        2017        Shatamanam Bhavati          INR 530500000                       1
-- drama        2017        Winner                      INR 250000000                       2
-- drama        2017        Thank You for Your Service  $ 9995692                           3
-- comdey       2017        The Healer                  $ 9979800                           4
-- thriller     2017        Gi-eok-ui bam               $ 9968972                           5






-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT production_company,
		COUNT(m.id) AS movie_count,
        ROW_NUMBER() OVER(ORDER BY COUNT(id) DESC) AS prod_comp_rank
FROM movie m INNER JOIN ratings r ON
m.id=r.movie_id
WHERE median_rating>=8 AND production_company IS NOT NULL AND position(',' IN languages)>0
GROUP BY production_company
LIMIT 2;

-- production_company         movie_count          	prod_comp_rank 
-- Star Cinema                    7                       1
-- Twentieth Century Fox          4                       2






-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language

-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH Top AS (
	SELECT n.name AS actress_name,
		SUM(total_votes) AS total_votes,
		COUNT(m.id) AS movie_count,
		r.avg_rating
	FROM names n INNER JOIN role_mapping ro
		ON n.id = ro.name_id INNER JOIN ratings r
			ON ro.movie_id = r.movie_id INNER JOIN movie m 
				ON m.id = r.movie_id INNER JOIN genre g
					ON m.id = g.movie_id
	WHERE category = 'Actress' AND  genre = 'Drama' AND avg_rating > 8
	GROUP BY actress_name)
SELECT *,
	DENSE_RANK () OVER ( ORDER BY movie_count DESC) AS actress_rank
FROM Top
LIMIT 3;

-- actress_name	    	  total_votes			movie_count		  actress_avg_rating	    actress_rank
-- Parvathy Thiruvothu     4974                     2                   8.3                      1
-- Susan Brown             656                      2                   8.9                      1
-- Amanda Lawrence         656                      2                   8.9                      1






/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations
Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

WITH date_in AS
(
SELECT d.name_id, name, d.movie_id,
	   m.date_published, 
       lead(date_published, 1) OVER (PARTITION BY d.name_id ORDER BY date_published, d.movie_id) AS next_movie_date
FROM director_mapping d
	 JOIN names n ON d.name_id=n.id 
	 JOIN movie m ON d.movie_id=m.id
),
date_dif AS
(
 SELECT *, DATEDIFF(next_movie_date, date_published) AS diff
 FROM date_in
 ),
 avg_inter_days AS
 (
 SELECT name_id, AVG(diff) AS avg_inter_movie_days
 FROM date_dif
 GROUP BY name_id
 ),
 final AS
 (
 SELECT d.name_id AS director_id,
	 name AS director_name,
	 COUNT(d.movie_id) AS number_of_movies,
	 ROUND(avg_inter_movie_days) AS inter_movie_days,
	 ROUND(AVG(avg_rating),2) AS avg_rating,
	 SUM(total_votes) AS total_votes,
	 MIN(avg_rating) AS min_rating,
	 MAX(avg_rating) AS max_rating,
	 SUM(duration) AS total_duration,
	 ROW_NUMBER() OVER(ORDER BY COUNT(d.movie_id) DESC) AS director_row_rank
 FROM
	 names n JOIN director_mapping d ON n.id=d.name_id
	 JOIN ratings r ON d.movie_id=r.movie_id
	 JOIN movie m on m.id=r.movie_id
	 JOIN avg_inter_days a ON a.name_id=d.name_id
 GROUP BY director_id
 )
 SELECT *	
 FROM final;

-- 



