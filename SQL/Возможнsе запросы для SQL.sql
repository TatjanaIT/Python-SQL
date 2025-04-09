USE movies;
SELECT * 
FROM movies;
				-- Поиск фильмов по жанру, году, актёру, рейтингу и ключевым словам (один из запросов для Python)
                
	# Шаблон movies SELECT запроса
SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies
WHERE genres LIKE '%{genre}%' AND
      year LIKE '%{year}%' AND
      cast LIKE '%{actor}%' AND
      `imdb.rating` >= {rating} AND
      (title LIKE '%{keyword}%' OR plot LIKE '%{keyword}%');
     
	# Пример     
SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies
WHERE genres LIKE '%Drama%' AND
      year LIKE '%2010%' AND
      cast LIKE '%{actor}%' AND
      `imdb.rating` >= 6 AND
      (title LIKE '%The%' OR plot LIKE '%Love%');
      
-- Построение SQL-запроса (один из запросов для Python)    
SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies;

							-- Поиск фильмов по нескольким жанрам

SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies
WHERE FIND_IN_SET('{genre1}', genres) > 0 AND 
      FIND_IN_SET('{genre2}', genres) > 0 AND
      (title LIKE '%{keyword}%' OR plot LIKE '%{keyword}%');
      
							-- Поиск фильмов, выпущенных в диапазоне лет

SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies
WHERE year BETWEEN {start_year} AND {end_year} AND
      `imdb.rating` >= {rating};
# Использование {start_year} и {end_year} для задания интервала лет, например, 2000 и 2020.


                                -- Поиск фильмов по нескольким актёрам
                                
SELECT title, year, `imdb.rating`, genres, runtime, cast
FROM movies
WHERE cast LIKE '%{actor1}%' AND 
      cast LIKE '%{actor2}%' AND
      genres LIKE '%{genre}%' AND
      `imdb.rating` >= {rating};
# {actor1} и {actor2} — конкретные актёры, которые нужно найти, например, 'Leonardo DiCaprio' и 'Brad Pitt'.
      
								-- Поиск фильмов по типу (фильм или сериал)
                                
SELECT title, year, `imdb.rating`, genres, runtime 
FROM movies
WHERE type = '{type}' AND
      year LIKE '%{year}%' AND
      `imdb.rating` >= {rating} AND
      (title LIKE '%{keyword}%' OR plot LIKE '%{keyword}%');  
# {type} — заменяется на 'movie' или 'series'.

										-- Поиск фильмов по языкам

SELECT title, year, `imdb.rating`, genres, runtime, languages 
FROM movies
WHERE languages LIKE '%{language}%' AND
      `imdb.rating` >= {rating};
      
