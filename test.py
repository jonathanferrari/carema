import pandas as pd, requests
inspo = {'user_id': ['1', '1', '2', '1', '1', '1', '2', '2'], 
         'quote': ['You got this', 'Have a great time', 
                   'You deserve it', 'turn that frown upside-down', 
                   'keep your head up', 'Never give up', 
                   'You\'re almost there', 
                   'you\'re so close you can see the light at the end of the tunnel!'],
         'photo': ['./images/bk2','./images/bk12'
                   ,'./images/bk7','./images/bk8',
                   './images/bk2','./images/bk4',
                   './images/bk5','./images/bk14'],
         'up': [6, 2, 1, 3, 5, 1, 3, 1], 
         'down': [0, 1, 0, 0, 2, 1, 0, 1], 
         'font': ['Lato', 'Lato', 'Roboto', 'Arial', 
                  'Lato', 'Arial', 'Arial', 'Lato'], 
         'size': [2.4, 2.4, 2.1, 2.4, 2.4, 2.4, 3.1, 2.4], 
         'color' : [3262, 43023, 392031, 34586, 80382, 555555, 66666, 919191], 
         'align' : ['4', '3', '1', '4', '4', '3', '4', '4']}
users = {'email': ['json22@berkeley.edu', 'jessicagolden@berkeley.edu'], 
         'name': ['Jason Telanoff', 'Jessica Golden'], 
         'pwd': ['3208ryhftwe0th20fewpdsni', 'shoreww0er32pqw23dws3'], 
         'deleted': [0, 0], 'up': [13, 9], 'down': [3, 2], 'posts': [5, 3]}
favorites = {'user_id': [12323841, 1023918, 2930482],
             'inspo_id': [1192314, 2038241, 20384024]}


l = requests.post("http://127.0.0.1:6000/users", 
                  data = eval("{'id':70, 'email': 'json22@berkeley.edu', 'name': 'Jason Telanoff', 'pwd': '3208ryhftwe0th20fewpdsni', 'deleted': 0, 'up': 0, 'down': 0 , 'posts': 5}"))
print(l)