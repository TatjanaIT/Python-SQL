import mysql.connector

class Database:
    """Класс для работы с базой данных"""
    def __init__(self, config):
        self.config = config
        self.connection = None
        self.cursor = None

    def connect(self):
        """Подключение к базе данных"""
        try:
            self.connection = mysql.connector.connect(**self.config)
            self.cursor = self.connection.cursor()
            return True
        except mysql.connector.Error as err:
            print(f"Ошибка подключения: {err}")
            return False

    def execute_query(self, query, params=None):
        """Выполнение SELECT запроса"""
        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchall()
        except mysql.connector.Error as err:
            print(f"Ошибка выполнения запроса: {err}")
            return []

    def execute_update(self, query, params=None):
        """Выполнение INSERT, UPDATE, DELETE запроса"""
        try:
            self.cursor.execute(query, params)
            self.connection.commit()
        except mysql.connector.Error as err:
            print(f"Ошибка выполнения обновления: {err}")

    def close(self):
        """Закрытие соединения с базой данных"""
        if self.connection:
            self.cursor.close()
            self.connection.close()
