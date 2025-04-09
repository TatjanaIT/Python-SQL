
-- Запрос выполняется по ключевому слову, которое может присутствовать в названии фильма (title) 
-- или в описании (plot). Запрос находит минимум 10 фильмов.

									# Поиск фильмов по ключевому слову
SELECT title, year, `imdb.rating`
FROM movies
WHERE title LIKE '%<ключевое_слово>%' OR plot LIKE '%<ключевое_слово>%'
LIMIT 10;

-- Пример для ключевого слова "love":
SELECT title, year, `imdb.rating`
FROM movies
WHERE title LIKE '%love%' OR plot LIKE '%love%'
LIMIT 10;

										# Поиск фильмов по жанру и году

SELECT title, year, `imdb.rating`
FROM movies
WHERE genres LIKE '%<жанр>%' AND year = <год>
LIMIT 10;

-- Пример для жанра "Drama" и года 2000:
SELECT title, year, `imdb.rating`
FROM movies
WHERE genres LIKE '%Drama%' AND year = 2000
LIMIT 10;

									# Вывод списка самых популярных запросов
                                    
SELECT keyword, count
FROM search_keywords
ORDER BY count DESC
LIMIT 10;

