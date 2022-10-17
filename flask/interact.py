import json, requests, os

base = ""
d = {"email":"jessicagolden@berkeley.edu",
     "name":"Jessica Golden",
     "pwd":"shoreww0er32pqw23dws3",
     "deleted":0,
     "up":9,
     "down":2,
     "posts":3}
l = requests.post("http://127.0.0.1:6000/users", data = d)
        
print(l)        