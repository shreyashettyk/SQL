
/*1. List the first and last names of all the actors who played in the movie 'Officer 444'. [~13 rows expected]*/

	 SELECT first_name,last_name FROM actors 
	 WHERE id in (SELECT actor_id FROM roles WHERE movie_id in 
	(SELECT id FROM movies WHERE name='Officer 444'));

/*2. List all the directors who directed a 'Film-Noir' movie in a leap year. (You need to check that the genre is 'Film-Noir' 
   and simply assume that every year divisible by 4 is a leap year.) Your query should return director id, director name, the 
   movie name, and the year. [~113 rows]*/

	SELECT dir.first_name,dir.last_name, m.name,m.year 
	FROM directors dir,movies m ,movies_genres mg,movies_directors md 
	WHERE mg.genres='Film-Noir' 
	and mg.movie_id= md.movie_id 
	and md.director_id=dir.id 
	and md.movie_id = m.id 
	and m.year % 4 == 0;

/*3.List all the actors who acted in a film before 1900 and also in a film after 2000. (That is: < 1900 and > 2000.) [~53 rows]*/


/*4. List all directors who directed 500 movies or more, in descending order of the number of movies they directed. 
  Return the directors' names and the number of movies each of them directed. [~47 rows]*/
  
	  SELECT directors.first_name , directors.last_name, COUNT(*) Directed_Movies
	  FROM directors,movies_directors 
	  WHERE directors.id = movies_directors.director_id GROUP BY directors.id HAVING Directed_Movies >=500;
  
/*We want to find actors that played five or more roles in the same movie during the year 2010. Notice that CASTS may 
have occasional duplicates, but we are not interested in these: we want actors that had five or more distinct roles 
in the same movie in the year 2010. Write a query that returns the actors' names, the movie name, and the number of 
distinct roles that they played in that movie (which will be ≥ 5). [~24 rows]*/

    
/*https://course.ccs.neu.edu/cs3200sp18s2/download/HW1.pdf*/	
	
/*1. List	the	first	and	last	names	of	all	the	actors	who	
were	cast	in	'Officer 444',and	the	roles	
they	played	in	that	production.	[3	- 15	rows]*/

	SELECT first_name,last_name,roles 
	FROM actors,roles,movies 
	WHERE movies.name='Officer 444' 
	and movies.id = roles.movie_id 
	and actor.id = roles.actor_id


/*2. List all the	directors	(first	and	last	names)	who	directed
a	movie	that	casted	a	role	for	'Sean Maguire'.	[5	- 20rows]*/


	SELECT directors.first_name,directors.last_name 
	FROM directors WHERE directors.id 
	in (SELECT director_id FROM movies_directors WHERE movie_id in
	(SELECT movie_id FROM roles WHERE role='Sean Maguire'));

    
