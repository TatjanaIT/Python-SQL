use movies;
SELECT * 
FROM movies;

-- Запрос для получения всех фильмов определённого жанра
SELECT title, year, `imdb.rating`
FROM movies
WHERE genres LIKE '%Drama%';

SELECT * # title, year, `imdb.rating`
FROM movies
WHERE title LIKE '%Django Unchained%';

-- Запрос для получения фильмов, снятых определённым режиссёром
SELECT title, year, `imdb.rating`
FROM movies
WHERE JSON_CONTAINS(directors, '"Steven Spielberg"');

-- Запрос для получения фильмов на определённом языке
SELECT title, year, `imdb.rating`
FROM movies
WHERE JSON_CONTAINS(languages, '"English"');

-- Запрос для получения фильмов с рейтингом выше определённого значения
SELECT title, year, `imdb.rating`
FROM movies
WHERE `imdb.rating` > 8.0;

-- Запрос для получения фильмов, выпущенных в конкретный год или диапазон лет
SELECT title, year, `imdb.rating`
FROM movies
WHERE year BETWEEN 2000 AND 2010;

-- Запрос для получения всех фильмов, в которых снимался определённый актёр
SELECT title, year, `imdb.rating`
FROM movies
WHERE JSON_CONTAINS(cast, '"Leonardo DiCaprio"');

-- Запрос для получения списка всех фильмов, получивших награды
SELECT title, year, `awards.text`
FROM movies
WHERE `awards.text` IS NOT NULL;

-- Запрос для получения всех фильмов, которые являются сериалами (не фильмами)
SELECT title, year, `imdb.rating`
FROM movies
WHERE `type` = 'series';

-- Запрос для получения количества фильмов каждого жанра
SELECT genres, COUNT(*) as count
FROM movies
GROUP BY genres;

-- Запрос для получения максимального, минимального и среднего значения рейтинга IMDb
SELECT 
    MAX(`imdb.rating`) AS max_rating,
    MIN(`imdb.rating`) AS min_rating,
    AVG(`imdb.rating`) AS average_rating
FROM movies;

-- Запрос для сортировки фильмов по убыванию рейтинга
SELECT title, year, `imdb.rating`
FROM movies
ORDER BY `imdb.rating` DESC;

-- Запрос для получения всех фильмов, выпущенных до 2000 года, с сортировкой по году
SELECT title, year, `imdb.rating`
FROM movies
WHERE year < 2000
ORDER BY year ASC;

