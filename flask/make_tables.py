import os, dotenv
import psycopg2

# Create a cursor.
dotenv.load_dotenv()
pg_conn_string = os.environ["PG_CONN_STRING"]

connection = psycopg2.connect(pg_conn_string)


# Set to automatically commit each statement
connection.set_session(autocommit=True)

cursor = connection.cursor()

#clear tables
cursor.execute("DROP TABLE inspo; DROP TABLE users; DROP TABLE favorites;")

# create tables
cursor.execute(
    "CREATE TABLE inspo (id SERIAL PRIMARY KEY, user_id INT, photo STRING, up INT, down INT, font STRING, size REAL, color INT, align INT)"
)

cursor.execute(
    "CREATE TABLE users (id SERIAL PRIMARY KEY, email STRING, name STRING, pwd STRING, deleted INT, up INT, down INT, posts INT)"
)

cursor.execute(
    "CREATE TABLE favorites (user_id INT, inspo_id INT)"
)


