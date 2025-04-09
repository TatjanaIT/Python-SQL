class Logger:
    """Класс для логирования запросов в базу данных"""
    def __init__(self, db):
        self.db = db

    def log_search_query(self, log):
        """Логирование поисковых запросов"""
        query = "INSERT INTO queries (query) VALUES (%s)"
        self.db.execute_update(query, (log,))

    def get_popular_queries(self):
        """Получение топ-3 популярных запросов"""
        query = "SELECT query, COUNT(*) as count FROM queries GROUP BY query ORDER BY count DESC LIMIT 3"
        return self.db.execute_query(query)
