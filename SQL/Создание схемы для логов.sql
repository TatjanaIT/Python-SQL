CREATE SCHEMA 'queries';

USE queries;

CREATE TABLE queries (
ID INT AUTO_INCREMENT PRIMARY KEY,
query TEXT);

-- Логирование поисковых запросов (один из запросов для Python)
INSERT INTO queries (query) VALUES (%s);

SELECT * FROM queries;

-- Получение топ-3 популярных запросов (один из запросов для Python)
SELECT query, COUNT(*) as count FROM queries GROUP BY query ORDER BY count DESC LIMIT 3;