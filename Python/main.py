from database import Database
from movie_searcher import MovieSearcher
from logger import Logger
from tabulate import tabulate
from IPython.display import display, HTML

# Конфигурация баз данных
dbconfig_movies = {
    'host': 'localhost', # Ваш хост
    'user': 'root', # Ваше имя пользователя MySQL
    'password': 'password',  # Ваш пароль MySQL
    'database': 'movies'  # Название вашей базы данных
}

dbconfig_logs = {
    'host': 'localhost',
    'user': 'root',
    'password': 'password',
    'database': 'queries'
}

# Основной код для запуска в Jupyter Notebook
db_movies = Database(dbconfig_movies)
db_queries = Database(dbconfig_logs)

# Проверка подключения к базе данных
if db_movies.connect() and db_queries.connect():
    # Создание экземпляров для поиска фильмов и логирования
    movie_searcher = MovieSearcher(db_movies)
    logger = Logger(db_queries)

    def search_movies():
        # Ввод данных пользователем
        year = input("Введите год (или оставьте поле пустым): ").strip() or None
        genres = input("Введите жанр [Adventure, Drama, Comedy, Family...](или оставьте поле пустым): ").strip() or None
        actor = input("Введите имя актера (или оставьте поле пустым): ").strip() or None
        rating = input("Введите нужный вам рейтинг от 1 (или оставьте поле пустым): ").strip() or None
        keyword = input("Введите ключевое слово (или оставьте поле пустым): ").strip() or None
        
        # Логирование запроса — сохраняем только то, что ввел пользователь
        log = f"Genres: {genres if genres else None}, Year: {year if year else None}, Actor: {actor if actor else None}, Rating: {rating if rating else None}, Keyword: {keyword if keyword else None}"
        logger.log_search_query(log)

        # Выполнение поиска фильмов и получение данных
        results = movie_searcher.search_movies(year, genres, actor, rating, keyword)
        if results:
            # Подготовка данных с HTML-кодом для постеров
            formatted_results = []
            for row in results:
                title, year, rating, genres, runtime, poster = row
                # Добавление миниатюры постера в таблицу
                poster_html = f'<img src="{poster}" width="80" height="120" alt="Poster" align="center">' if poster else "No Poster Available"
                formatted_results.append((f"<div align='center'>{title}</div>",
                                          f"<div align='center'>{year}</div>",
                                          f"<div align='center'>{rating}</div>",
                                          f"<div align='center'>{genres}</div>",
                                          f"<div align='center'>{runtime}</div>",
                                          poster_html))

            # Отображение табличных результатов с миниатюрами
            headers = ["Название", "Год", "Рейтинг", "Жанры", "Время", "Постер"]
            table_html = tabulate(formatted_results, headers=headers, tablefmt='unsafehtml')

            # Центрирование таблицы и добавление ширины
            centered_table_html = f'<div align="center" style="width:80%">{table_html}</div>'

            display(HTML(centered_table_html))
        else:
            print("Фильмы не найдены.")
        
        # Показать действия после вывода результатов
        show_actions()

    def show_actions():
        while True:
            action = input("\nЧто вы хотите сделать дальше?\n1. Продолжить поиск\n2. Вывести популярные запросы\nВыберите действие (1/2): ").strip()
            if action == '1':
                search_movies()  # Перезапуск поиска
                break
            elif action == '2':
                show_popular_queries()  # Вывод популярных запросов
                break
            else:
                print("Неверный выбор, попробуйте снова.")

    def show_popular_queries():
        popular_queries = logger.get_popular_queries()
        if popular_queries:
            # Формируем таблицу популярных запросов так же, как и основную таблицу поиска
            formatted_popular_queries = []
            for row in popular_queries:
                query, count = row
                formatted_popular_queries.append((f"<div align='center'>{query}</div>", f"<div align='center'>{count}</div>"))

            # Отображение табличных результатов
            headers = ["Запрос", "Количество"]
            table_html = tabulate(formatted_popular_queries, headers=headers, tablefmt='unsafehtml')

            # Центрирование таблицы и добавление ширины
            centered_table_html = f'<div align="center" style="width:80%">{table_html}</div>'

            display(HTML(centered_table_html))
        else:
            print("Нет популярных запросов.")

        # Запрос на продолжение после вывода популярных запросов
        if input("\nХотите продолжить поиск? (y/n): ").strip().lower() == 'y':
            search_movies()
        else:
            print("Работа завершена.")

    # Первый запуск поиска
    search_movies()

    # Закрытие соединения с базами данных при завершении работы
    db_movies.close()
    db_queries.close()

else:
    print("Ошибка подключения к базам данных.")
