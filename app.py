import random
import json
import nltk
from nltk.corpus import wordnet
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from flask import Flask, request, jsonify
import warnings
warnings.filterwarnings('ignore')
from joblib import dump, load


nltk.download('stopwords')
nltk.download('punkt')
nltk.download('wordnet')

app = Flask(__name__)

# Load intents
intents = {
    "intents": [
        {
            "tag": "greeting",
            "patterns": ["Hi", "Hello", "Hey", "Good day", "How are you?"],
            "responses": ["Hello!", "Good to see you!", "Hi there, how can I help?"],
        }
    ]
}

# Function to perform synonym replacement
def synonym_replacement(tokens, limit):
    augmented_sentences = []
    for i in range(len(tokens)):
        synonyms = []
        for syn in wordnet.synsets(tokens[i]):
            for lemma in syn.lemmas():
                synonyms.append(lemma.name())
        if len(synonyms) > 0:
            num_augmentations = min(limit, len(synonyms))
            sampled_synonyms = random.sample(synonyms, num_augmentations)
            for synonym in sampled_synonyms:
                augmented_tokens = tokens[:i] + [synonym] + tokens[i+1:]
                augmented_sentences.append(' '.join(augmented_tokens))
    return augmented_sentences

# Preprocessing data
nltk.download('stopwords')
nltk.download('punkt')
nltk.download('wordnet')
text_data = []
labels = []
stopwords = set(nltk.corpus.stopwords.words('english'))
lemmatizer = nltk.WordNetLemmatizer()
limit_per_tag = 40

for intent in intents['intents']:
    augmented_sentences_per_tag = 0
    for example in intent['patterns']:
        tokens = nltk.word_tokenize(example.lower())
        filtered_tokens = [lemmatizer.lemmatize(token) for token in tokens if token not in stopwords and token.isalpha()]
        if filtered_tokens:
            text_data.append(' '.join(filtered_tokens))
            labels.append(intent['tag'])
            augmented_sentences = synonym_replacement(filtered_tokens, limit_per_tag - augmented_sentences_per_tag)
            for augmented_sentence in augmented_sentences:
                text_data.append(augmented_sentence)
                labels.append(intent['tag'])
                augmented_sentences_per_tag += 1
                if augmented_sentences_per_tag >= limit_per_tag:
                    break

vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(text_data)
y = labels

model = LogisticRegression()
model.fit(X, y)

# Save the model and vectorizer
joblib.dump(model, 'model.pkl')
joblib.dump(vectorizer, 'vectorizer.pkl')

model = joblib.load('model.pkl')
vectorizer = joblib.load('vectorizer.pkl')

def chatbot_response(user_input):
    input_text = vectorizer.transform([user_input])
    predicted_intent = model.predict(input_text)[0]
    for intent in intents['intents']:
        if intent['tag'] == predicted_intent:
            response = random.choice(intent['responses'])
            break
    return response

@app.route('/chatbot', methods=['POST'])
def chatbot():
    user_input = request.json.get('message')
    response = chatbot_response(user_input)
    return jsonify({'response': response})

if __name__ == '__main__':
    app.run(port=5000, debug=True)
