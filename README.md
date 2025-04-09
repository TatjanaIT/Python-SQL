# Python-SQL
Сonsole application for searching movies in a database

# 🎬 Project: Movie Search
## 📌 Project Goal
To create an interactive Python-based interface for searching movies in a database using parameters such as genre, release year, actor, rating, and keywords. The system also logs user queries and displays the most popular ones.

## 🗂️ Project Structure

project/

- main.py (Main execution script for Jupyter (user input, logic, visualization))
- movie_searcher.py (Module for searching movies in the database)
- logger.py (Module for logging user queries)
- database.py (Utility for database connection and interaction)
- Start_page.ipynb (Jupyter Notebook interface for project demo)

## 🔍 Module Descriptions

### main.py

Main script to be executed in Jupyter Notebook.

Responsibilities:
- Connects to two databases: movies and logs.
- Gathers user input through the console.
- Displays search results with posters using HTML formatting.
- Logs user input and shows most popular queries.
  
Uses tabulate and IPython.display for formatted output.

### movie_searcher.py

The MovieSearcher class performs the movie search.

Builds dynamic SQL queries using:
- Genre (genres LIKE '%...')
- Year, actor, rating (imdb.rating >= ...), and keywords (in title or plot).
  
Returns results with movie details, including poster URLs.

### logger.py

The Logger class handles query logging.
- Saves search descriptions to the queries table.
- Retrieves the top 3 most frequent search queries.

### database.py

Utility class for MySQL database interaction.

Key methods:
- connect() — connect to the database
- execute_query() — execute SELECT queries
- execute_update() — for INSERT/UPDATE/DELETE
- close() — close the database connection

### Start_page.ipynb

A Jupyter Notebook used for demonstrating the app.

Imports and runs main.py, providing a visual interface for search logic.

## ⚙️ Technologies Used
- Python 3
- MySQL
- Jupyter Notebook
- Libraries: tabulate, mysql.connector, IPython.display

## 📊 Key Features
- Search movies by genre, year, actor, rating, and keyword
- Visual display with movie posters in a table format
- Logs and stores user queries
- Displays the top 3 most frequent queries
- Interactive, multi-step CLI interface for continued exploration

## 🎯 Project Highlights
- Clean modular architecture
- Simple to use and extend
- Scalable: easy to add filters, connect APIs, or build dashboards
