from flask import Flask, jsonify, request
import json, os, dotenv, psycopg2, psycopg2.extras

# Create a Flask server.
app = Flask(__name__)
dotenv.load_dotenv()
# Create a cursor and initialize psycopg
pg_conn_string = os.environ["PG_CONN_STRING"]

connection = psycopg2.connect(pg_conn_string)


# Set to automatically commit each statement
connection.set_session(autocommit=True)

cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

# user analytics: total karma, total posts, days since joining, 
#                 average carma, carma by day, ratio of pos v neg,
#                 most popular, n favorited inspos
# general: word cloud

# Helper Functions

## Full Table
def get_all(table):
    cursor.execute(f'SELECT * FROM {table}')
    results = cursor.fetchall()
    return results

## Filtered Table
def get_by_id(table, id):
    id_label = "user_id" if table == "favorites" else "id"
    cursor.execute("SELECT * FROM {table} WHERE {id_label} = {id}")
    result = cursor.fetchall()
    return result

def random_inspo(n = 10, category = None, carma = None):
    """Return `n` randomly selected inspirations based on filters"""
    filters = [category, carma]
    if not any(filters):
    # filter none
        filter_str = " "
    elif all(filters):
    #filter both
        filter_str = f" WHERE carma >= {carma} AND WHERE cateogry = {category} "
    elif category:
        filter_str = f" WHERE cateogry = {category} "
    #filter category
    else:
    #filter carma
        filter_str = f" WHERE carma >= {carma} "
    cursor.execute("SELECT * FROM inspo{filter_str}ORDER BY RANDOM() LIMIT {n};")
    results = cursor.fetchall()
    # create table with filters then order by random and choose first row
    return results
    
# Routes!

## GET methods
@app.route('/', methods=['GET'])
def index():
    return str("Welcome to the Care-ma app REST API!! <3 ;)")

@app.route('/quotes', methods=['GET'])
def get_all_inspo():
    return jsonify(get_all("inspo"))

@app.route('/favorites', methods=['GET'])
def get_all_favs():
    return jsonify(get_all("favories"))

@app.route('/users', methods=['GET'])
def get_all_users():
    return jsonify(get_all("users"))

@app.route("/<table>/<id>", methods=['GET'])
def search_id(table, id):
    result = get_by_id(table, id)
    return jsonify(result)

@app.route("/search", methods=['GET'])
def filter_listings():
    v = request.args
    n, carma, category = [v.get(k, None) for k in ["n", "carma", "category"]]
    if n:
        result = random_inspo(n=n, category=category, carma=carma)
    else:
        result = random_inspo(category=category, carma=carma)
    return jsonify(result)


## POST methods

@app.route("/", methods=['POST'])
def create_airbnb():
    new_airbnb = request.json
    try:
        res = db_create_airbnb(new_airbnb['title'], new_airbnb['name'],
                               new_airbnb['neighbourhood'],
                               new_airbnb['neighbourhood_group'],
                               new_airbnb['verified'], new_airbnb['year'])
        return jsonify(res)

    except Exception as e:
        return jsonify({"error": str(e)})

## PUT methods

@app.route("/<id>", methods=['PUT'])
def update_title(id):
    try:
        title = request.json['title']
      
        return jsonify(db_update_title(id, title))
    except Exception as e:
        return jsonify({"error": str(e)})

## DELETE methods

@app.route("/<id>", methods=['DELETE'])
def delete_book(id):
    try:
        return jsonify(db_delete_listing(id))
    except Exception as e:
        return jsonify({"error": str(e)})


# Runs the API and exposes it on https://<repl name>.<replit username>.repl.co
# ex. Mine deploys to https://htn-api.jayantsh.repl.co.
app.run(host="0.0.0.0", debug=True)
