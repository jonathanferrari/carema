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



# Helper Functions
class Retrieve:
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

class Make:
    def user(id, email, name , pwd, deleted, up, down, posts, joined):
        columns = "(id, email, name , pwd, deleted, up, down, posts, joined)"
        values = f"VALUES{(id, email, name , pwd, deleted, up, down, posts, joined)}"
        cursor.execute(f"INSERT INTO users {columns} {values} RETURNING *")
        result = cursor.fetchone()
        return result
    def inspo(id, user_id, photo, up, down, font, size, color, align):
        columns = "(id, user_id, photo, up, down, font, size, color, align)"
        values = f"Values{(id, user_id, photo, up, down, font, size, color, align)}"
        cursor.execute(f"INSERT INTO inspos {columns} {values} RETURNING *")
        result = cursor.fetchone()
        return result
    def favorite(user_id, inspo_id):
        columns = "(user_id, inspo_id)"
        values = f"VALUES{(user_id, inspo_id)}"
        cursor.execute(f"INSERT INTO favorites {columns} {values} RETURNING *")
        result = cursor.fetchone()
        return result
    
class UserStats:

    def most_popular(id):
        pass
    def total_karma(id):
        pass
    def total_posts(id):
        pass
    def days_since_join(id):
        pass
    def avg_carma(id):
        pass
    def carma_per_day(id):
        pass
    def positivity_ratio(id):
        pass
    def favorite_inspo(n, id):
        pass
    
        
class UniversalStats:
    
    def word_cloud():
       pass 
        
# Routes!

## GET methods

### Full tables
@app.route('/', methods=['GET'])
def index():
    return str("Welcome to the Care-ma app REST API!! <3 ;)")

@app.route('/inspo', methods=['GET'])
def get_all_inspo():
    return jsonify(Retrieve.get_all("inspo"))

@app.route('/favorites', methods=['GET'])
def get_all_favs():
    return jsonify(Retrieve.get_all("favories"))

@app.route('/users', methods=['GET'])
def get_all_users():
    return jsonify(Retrieve.get_all("users"))

### Filtered Tables

@app.route("/<table>/<id>", methods=['GET'])
def search_id(table, id):
    result = Retrieve.get_by_id(table, id)
    return jsonify(result)

@app.route("/search", methods=['GET'])
def filter_listings():
    v = request.args
    n, carma, category = [v.get(k, None) for k in ["n", "carma", "category"]]
    if n:
        result = Retrieve.random_inspo(n=n, category=category, carma=carma)
    else:
        result = Retrieve.random_inspo(category=category, carma=carma)
    return jsonify(result)


## POST methods

@app.route("/user", methods=['POST'])
def create_user():
    new_user = request.json
    try:
        result = Make.user(
         int(new_user["id"]),
         new_user["email"],
         new_user["name"],
         new_user["pwd"],
         int(new_user["deleted"]),
         int(new_user["up"]),
         int(new_user["down"]),
         int(new_user["posts"]),
         new_user["joined"]
         )
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)})

@app.route("/favorites", methods=['POST'])
def create_favorite():
    new_fav = request.json
    try:
        result = Make.favorite(
            int(new_fav["user_id"]), 
            int(new_fav["inspo_id"])
            )
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)})
    
@app.route("/inspo", methods=['POST'])
def create_inspo():
    new_inspo = request.json
    try:
        result = Make.inspo(
            int(new_inspo["id"]),
            int(new_inspo["user_id"]),
            new_inspo["photo"],
            int(new_inspo["up"]),
            int(new_inspo["down"]),
            new_inspo["font"],
            float(new_inspo["size"]),
            int(new_inspo["color"]),
            int(new_inspo["align"])
        )
        return jsonify(result)
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
