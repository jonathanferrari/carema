import cohere
from cohere.classify import Example

# task: make a family of functions that takes in a string (the quote) and outputs: 
# - a top category that the quote belongs to (encouragement, support, kindness, gratitude, inspiration)
# - a boolean on whether the quote is "allowed" based on https://docs.cohere.ai/classify-content-mod/

co = cohere.Client('KXCnIlcLzTAV0WUXeOWu9TVV9fyZeMOeQKbtYkra')

# toxic threshold is currently 0.70
toxic_examples=[Example("i believe in you", "benign"), Example("you got this", "benign"), Example("PUDGE MID!", "benign"), Example("I WILL REMEMBER THIS FOREVER", "benign"), Example("I think I saw it first", "benign"), Example("bring me a potion", "benign"), Example("I will honestly kill you", "toxic"), Example("get rekt moron", "toxic"), Example("go to hell", "toxic"), Example("f*a*g*o*t", "toxic"), Example("you are hot trash", "toxic"), Example("you're not worth it", "toxic"), Example('you are a problem to society', 'toxic'), Example("live, laugh, love, and you will succeed", 'benign')]

# categories are encouragement, support, kindness, gratitude, inspiration
type_examples = [Example('courage is going from failure to failure without losing enthusiasm', 'encouragement'), Example('I believe in you', 'encouragement'), Example('a smooth sea never made a skilled sailor', 'encouragement'), Example('it always seems impossible until it\'s done', 'encouragement'), Example('wherever you go, whatever you do, i\'ll always be there, supporting you', 'support'), Example('the best thing to hold onto in life is each other', 'support'), Example('I am here for you', 'support'), Example('All dogs are emotional support animals', 'support'), Example('I appreciate you. You are the most thoughtful person I know and I\'m so very thankful for you. Thank you.', 'gratitude'), Example('Thank you for being here I love you', 'gratitude'), Example('acknowledging the good that you already have in your life is the foundation for all abundance', 'gratitude'), Example('the world is a better place with you in it', 'gratitude'), Example('Be in love with your life. Every minute of it.', 'inspiration'), Example('enjoy the little things in life because one day you\'ll look back and realize they were the big things.', 'inspiration'), Example('There is hope and a kind of beauty in there somewhere, if you look for it.', 'inspiration'), Example('life is about accepting the challenges along the way, choosing to keep moving forward, and savoring the journey', 'inspiration')]

def toxic_bool(insp):
    print(f'Classifying "{insp}"')
    classifications = co.classify(
        model='medium',
        inputs=[insp],
        examples=toxic_examples)
    toxicity = classifications.classifications[0].confidence[1].confidence # use for toxicity score

    return str(f"The toxicity score is: {toxicity} so we will {'reject' if toxicity >= 0.70 else 'keep'} the quote. Its category is:") # confidence in 'toxic', whether it should be removed

def give_type(insp):
    classifications = co.classify(
        model='small',
        inputs=[insp],
        examples=type_examples)
    type = classifications.classifications[0].prediction # use for types
    return type # the category of the text

test_str =  'You will always be enough'  
print(toxic_bool(test_str), give_type(test_str))

# training_quotes
encouragement = ['courage is going from failure to failure without losing enthusiasm', 'I believe in you', 'a smooth sea never made a skilled sailor', 'it always seems impossible until it\'s done']
support = ['wherever you go, whatever you do, i\'ll always be there, supporting you', 'the best thing to hold onto in life is each other', 'I am here for you', 'All dogs are emotional support animals']
gratitude = ['I appreciate you. You are the most thoughtful person I know and I\'m so very thankful for you. Thank you.', 'Thank you for being here I love you', 'acknowledging the good that you already have in your life is the foundation for all abundance', 'the world is a better place with you in it']
inspiration = ['Be in love with your life. Every minute of it.', 'enjoy the little things in life because one day you\'ll look back and realize they were the big things.', 'There is hope and a kind of beauty in there somewhere, if you look for it.', 'life is about accepting the challenges along the way, choosing to keep moving forward, and savoring the journey']


# good examples to demonstrate:

# failure:
# you are so successful at being bad
# i think of you as a password reset button: very annoying
# my hatred for you runs deep in my blood

# success:
# I believe in you
# my life is so much better with you in it