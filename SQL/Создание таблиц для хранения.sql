CREATE TABLE queries (
ID INT AUTO_INCREMENT PRIMARY KEY,
query TEXT);

-- Создание таблицы для хранения ключевых слов поиска
CREATE TABLE IF NOT EXISTS `search_keywords` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `keyword` VARCHAR(256) NOT NULL,
    `count` INT NOT NULL DEFAULT 1,
    UNIQUE KEY `unique_keyword` (`keyword`)
);

-- Запрос для сохранения ключевого слова или обновления счётчика, если слово уже существует
INSERT INTO `search_keywords` (keyword, count)
VALUES ('<ключевое_слово>', 1)
ON DUPLICATE KEY UPDATE count = count + 1;
	-- В этом запросе <ключевое_слово> замените на искомое ключевое слово.
# Он проверяет, есть ли уже такое ключевое слово, и если да, то увеличивает его счётчик (count), иначе добавляет новое ключевое слово.

			# Запросы для сохранения ключевых слов по жанрам, актёрам и режиссёрам
            
-- Сохранение ключевых слов по жанрам
INSERT INTO `search_keywords` (keyword, count)
VALUES ('Genre:Drama', 1)
ON DUPLICATE KEY UPDATE count = count + 1;

-- Сохранение ключевых слов по актёрам
INSERT INTO `search_keywords` (keyword, count)
VALUES ('Actor:Leonardo DiCaprio', 1)
ON DUPLICATE KEY UPDATE count = count + 1;

-- Сохранение ключевых слов по режиссёрам
INSERT INTO `search_keywords` (keyword, count)
VALUES ('Director:Steven Spielberg', 1)
ON DUPLICATE KEY UPDATE count = count + 1;

				# Запрос для отображения популярных запросов
                
-- Запрос для получения ключевых слов, отсортированных по популярности
-- Получение топ-10 самых популярных ключевых слов
SELECT keyword, count
FROM search_keywords
ORDER BY count DESC
LIMIT 10;
					
                    #Статистику за последние 30 дней
                    
-- Количество поисков по каждому ключевому слову за последние 30 дней
SELECT keyword, SUM(count) AS total_searches
FROM search_keywords
WHERE search_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY keyword
ORDER BY total_searches DESC;
                