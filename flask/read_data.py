import os
import psycopg2

# Create a cursor.
pg_conn_string = os.environ["PG_CONN_STRING"]

connection = psycopg2.connect(pg_conn_string)


# Set to automatically commit each statement
connection.set_session(autocommit=True)

cursor = connection.cursor()


cursor.execute(
    "CREATE TABLE airbnbs (id SERIAL PRIMARY KEY, title STRING, neighbourhood_group STRING, neighbourhood STRING, host_name STRING, verified BOOL, year INT)"
)

with open("airbnbs.csv", "r") as f:
    lines = f.readlines()

    for line in lines[1:]:
        parts = line.strip().split(',')

        cursor.execute(
            "INSERT INTO airbnbs VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (parts[0], parts[1], parts[5], parts[6], parts[4], parts[3]
             == "verified", parts[14]))
