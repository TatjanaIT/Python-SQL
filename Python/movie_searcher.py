class MovieSearcher:
    """Класс для поиска фильмов в базе данных"""
    def __init__(self, db):
        self.db = db

    def search_movies(self, year, genres, actor, rating, keyword):
        """Функция поиска фильмов с пользовательским вводом"""
        # Создание условий выборки
        conditions = []
        if genres:
            conditions.append(f"genres LIKE '%{genres}%'")
        if year:
            conditions.append(f"year LIKE '%{year}%'")
        if actor:
            conditions.append(f"cast LIKE '%{actor}%'")
        if rating:
            try:
                rating = float(rating)  # Проверка, что введено число
                conditions.append(f"`imdb.rating` >= {rating}")
            except ValueError:
                print("Рейтинг должен быть числом.")
                return []
        if keyword:
            conditions.append(f"(title LIKE '%{keyword}%' OR plot LIKE '%{keyword}%')")

        # Построение SQL-запроса, добавление столбца poster
        query = "SELECT title, year, `imdb.rating`, genres, runtime, poster FROM movies"
        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        return self.db.execute_query(query)
