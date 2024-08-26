#!/usr/bin/env python
# coding: utf-8

# In[1]:

import os
import nltk
import random
import json
import sys
import joblib
import warnings
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.corpus import wordnet
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import MultinomialNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from nltk.stem import WordNetLemmatizer

warnings.filterwarnings("ignore", category=UserWarning, module="sklearn")


# In[6]:

intents = {
    "intents": [
        {
            "tag": "greeting",
            "patterns": ["Hi", "Hello", "Hey", "Good day", "How are you?"],
            "responses": ["Hello!", "Good to see you!", "Hi there, how can I help?"],
        },
        {
            "tag": "Bye",
            "patterns": ["Goodbye", "Bye", "See you later", "Talk to you later"],
            "responses": ["Sad to see you go :(", "Goodbye!", "Come back soon!"],
        },
        {
            "tag": "creator",
            "patterns": ["Who created you?", "Who is your developer?", "Who made you?"],
            "responses": ["I was created by Seow Hui Chee."],
        },
        {
            "tag": "identity",
            "patterns": [
                "What is your name?",
                "What should I call you?",
                "Who are you?",
                "What are you",
                "Introduce Yourself",
            ],
            "responses": ["You can call me TAR UMT query chatbot. I'm a Chatbot."],
        },
        {
            "tag": "communication",
            "patterns": [
                "How can I communicate with the university?",
                "What are the communication channels for students and parents?",
            ],
            "responses": [
                "You can communicate with the university through our official email (info@tarc.edu.my), tel (6)03-41450123, or by visiting the respective department."
            ],
        },
        {
            "tag": "casual_greeting",
            "patterns": ["What's up?", "How are you?", "How you doing?"],
            "responses": [
                "I'm here to assist you with any questions or information you need. How can I assist you today?"
            ],
        },
        {
            "tag": "good_morning",
            "patterns": ["Good morning", "Morning"],
            "responses": ["Good morning! How can I assist you today?"],
        },
        {
            "tag": "good_afternoon",
            "patterns": ["Good afternoon", "Afternoon"],
            "responses": ["Good afternoon! How can I assist you today?"],
        },
        {
            "tag": "good_evening",
            "patterns": ["Good evening", "Evening"],
            "responses": ["Good evening! How can I assist you today?"],
        },
        {
            "tag": "thank_you",
            "patterns": ["Thank you", "Thanks"],
            "responses": [
                "You're welcome! If you have any more questions, feel free to ask."
            ],
        },
        {
            "tag": "sorry",
            "patterns": ["Sorry", "Apologies"],
            "responses": [
                "No problem! If there's anything else you need assistance with, feel free to let me know."
            ],
        },
        {
            "tag": "hours",
            "patterns": [
                "What are the university working timings?",
                "When is the university open?",
                "What are the hours of operation?",
                "What are the operational hours",
            ],
            "responses": [
                "The university is open from 8.30 am to 5.30 pm for Monday to Friday. Close for Saturday and Sunday. "
            ],
        },
        {
            "tag": "contact",
            "patterns": [
                "How can I contact the university?",
                "What is the university phone number",
                "What is the university telephone number?",
                "Can I get your contact number?",
            ],
            "responses": ["You can contact the university at (6)03-41450123."],
        },
        {
            "tag": "location",
            "patterns": [
                "Where is the TARUMT university located?",
                "What is the TARUMT university address?",
                "How can I reach the TARUMT university?",
            ],
            "responses": [
                'The university is located at Jalan Genting Kelang, Setapak, 53300 Kuala Lumpur. You can find the location on Google Maps. <br/><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7967.0756243214!2d101.7178023697754!3d3.2152552000000023!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc3843bfb6a031%3A0x2dc5e067aae3ab84!2sTunku%20Abdul%20Rahman%20University%20of%20Management%20and%20Technology%20(TAR%20UMT)!5e0!3m2!1sen!2smy!4v1722357853971!5m2!1sen!2smy" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
            ],
        },
        {
            "tag": "hostel",
            "patterns": [
                "Does the college provide hostel facilities?",
                "Where is the hostel located?",
                "What are the hostel fees?",
            ],
            "responses": [
                "The university provides hostel accommodation (location: <a href='https://maps.app.goo.gl/ezCAwd35tNnJTBuU8' target='_blank' rel='noopener noreferrer'>View Hostel Location</a>), consisting of 10 blocks of 5-storey buildings with 1,000 standard rooms that can accommodate 2,000 students. Each room is on a twin-sharing basis with 400 rooms allocated for males and 600 rooms for females in separate blocks. Each floor has its own common bathrooms, toilets, pantry, water dispenser, and drying area. Hostel availability is based on a first-come-first-served basis. Rental fees: RM 243.00 per person per month and is paid on a semester basis. It provides lots of facilities. For detailed information about the hostel, please visit our college website: <a href='https://www.tarc.edu.my/dsa/a/accommodation/accommodation-kl-main-campus/' target='_blank' rel='noopener noreferrer'>Hostel Information</a>."
            ],
        },
        {
            "tag": "events",
            "patterns": [
                "What events are organized in the college?",
                "Are there any upcoming events?",
                "Tell me about the college events.",
            ],
            "responses": [
                "There are many events held at Yum Yum Cafeteria (<a href='https://maps.app.goo.gl/9qTMrSzNWaCWeAYG6' target='_blank' rel='noopener noreferrer'>View Location</a>) and The Rimba (<a href='https://maps.app.goo.gl/xCYqiUkDA29czSaYA' target='_blank' rel='noopener noreferrer'>View Location</a>)."
            ],
        },
        {
            "tag": "library",
            "patterns": [
                "Does the university have a library?",
                "Where is the library located?",
                "What are the library timings?",
            ],
            "responses": [
                'The library is located at <a href="https://maps.app.goo.gl/FXLd4RwD7z2PYeNM6" target="_blank" rel="noopener noreferrer">this link</a>. The timings are from 8:30 am to 9:00 pm from Monday to Friday, 9:00 am to 2:00 pm on Saturday, and it is closed on Sunday. <br/><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d704.1954516290003!2d101.72769535627513!3d3.2170536235931806!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc3869b40fb3bb%3A0x69267c00497dfef5!2sTAR%20UMT%20Library!5e0!3m2!1sen!2sus!4v1719762758660!5m2!1sen!2sus" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
            ],
        },
        {
            "tag": "facilities",
            "patterns": [
                "What facilities are available in the university?",
                "Tell me about the university facilities.",
                "Do you have a sports complex?",
            ],
            "responses": [
                "The university provides various facilities including a sports complex (<a href='https://maps.app.goo.gl/E8Rm3WKkG39xdCyz7' target='_blank' rel='noopener noreferrer'>view location</a>), 2 gyms located at the sports complex or club house (<a href='https://maps.app.goo.gl/nsVTKShzD9X8SX628' target='_blank' rel='noopener noreferrer'>view locations</a>), cafeteria, library, and so on."
            ],
        },
        {
            "tag": "class_size",
            "patterns": [
                "How big are your classes?",
                "Are the class sizes large or small?",
                "Do you have small class sizes?",
            ],
            "responses": [ 
                "Class sizes can vary depending on the course and program. As general, tutorial and practical is small class learning ; lecture is big class learning which may consist of multiple programme join together."
            ],
        },
        {
            "tag": "canteen",
            "patterns": [
                "Where is canteen or cafeteria?",
                "What food provided at the canteen or cafeteria",
                "How much is the price for food.",
            ],
            "responses": [
                "There are several cafeterias on campus: <br/>"
                + "   - **The Red Bricks Cafeteria** (Block G, West Campus) [7:30am-5:00pm (Mon-Fri), 8:00am-4:00pm (Sat)] : <a href='https://maps.app.goo.gl/DGRZHbtfxzLDcuR7A' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Yum Yum Cafeteria** (Block L, West Campus) [7:30am-5:00pm (Mon-Fri), 8:00am-4:00pm (Sat)] : <a href='https://maps.app.goo.gl/g4rRsv3ZA1LHyE3D8' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Fort Margherita Cafe** (Cyber Centre, West Campus) [7:30am-6:00pm (Mon-Fri), 8:00am-4:00pm (Sat)] : <a href='https://maps.app.goo.gl/syXd2oSUR5N4o9bD8' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Casuarina Cafe** (Block SC, East Campus) [7:30am-5:00pm (Mon-Fri), 8:00am-3:00pm (Sat)] : <a href='https://maps.app.goo.gl/kDKfr2Qw966qwEYp6' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Lily's Cafe** (Block SC, East Campus) [8:00am-6:00pm (Mon-Fri), 8:00am-3:00pm (Sat)] : <a href='https://maps.app.goo.gl/kDKfr2Qw966qwEYp6' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Heritage Kitchen** (ClubHouse, West Campus) [7:30am-7:00pm (Mon-Fri), 8:00am-4:00pm (Sat)] : <a href='https://maps.app.goo.gl/RsAeeBmejiDs1Kmc7' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "   - **Sunnydae** (Library Cafe, West Campus) [8:00am-7:00pm (Mon-Fri), 8:00am-4:00pm (Sat)] : <a href='https://maps.app.goo.gl/Mm2KEetfgs1m4yx56' target='_blank' rel='noopener noreferrer'>View location</a> <br/>"
                + "Various kinds of food are provided at these canteens. The food prices at the Canteen/Cafeteria on Campus are generally cheaper and more affordable compared to private food outlets outside the campus, ensuring that students can enjoy meals on campus rather than going off-site. For more information: <a href='https://www.tarc.edu.my/dsa/food-and-beverage/' target='_blank' rel='noopener noreferrer'>Food and Beverage Information</a>"
            ],
        },
        {
            "tag": "classroom_class_venue",
            "patterns": [
                "I can't find classroom!",
                "Where is the class venue?",
                "I want map",
            ],
            "responses": [
                "This is map <img src='/Image/CampusMap.jpg' alt='Classroom Map' style='max-width:750px; height:auto;'>"
            ],
        },
        {
            "tag": "past_year_paper",
            "patterns": [
                "I can't find past year paper!",
                "Where is past year paper?",
                "Where is eprints?",
                "Where is eprint?",
            ],
            "responses": [
                "You can find past year paper at eprints: <a href='https://eprints.tarc.edu.my/' target='_blank' rel='noopener noreferrer'>eprints</a>"
            ],
        },
        {
            "tag": "parking_lot",
            "patterns": [
                "I can't find parking lot!",
                "Where is parking lot?",
                "Where is parking lot?",
                "I want park car",
            ],
            "responses": [
                "You can find parking lots at the following locations: <br>"
                + "1. Beside Sport Complex: <a href='https://maps.app.goo.gl/8kKJvh3CZnXxKrjD7' target='_blank' rel='noopener noreferrer'>View on Maps</a> <br>"
                + "2. Beside Club House: <a href='https://maps.app.goo.gl/Hv9ZSiYEHcht5vr8A' target='_blank' rel='noopener noreferrer'>View on Maps</a> <br>"
                + "3. Behind DK ABF: <a href='https://maps.app.goo.gl/Zyh4fu2yPnLWCBRPA' target='_blank' rel='noopener noreferrer'>View on Maps</a> <br>"
                + "4. East Campus Parking: <a href='https://maps.app.goo.gl/SKCmWDkYa7qmFZ3c7' target='_blank' rel='noopener noreferrer'>View on Maps</a>"
            ],
        },
        {
            "tag": "parking_pass",
            "patterns": [
                "Can I simply parking without any car pass?",
                "How to apply car pass?",
                "How to get vehicle entry pass?",
                "Vehicle Entry Pass application",
            ],
            "responses": [
                "You need to apply for the Vehicle Entry Pass by logging into TARUC Student Intranet: <a href='https://web.tarc.edu.my/portal/login.jsp' target='_blank' rel='noopener noreferrer'>Login to TARUC Student Intranet</a>"
            ],
        },
        {
            "tag": "timetable",
            "patterns": [
                "What is student Intranet?",
                "How to go to student Intranet",
                "How to find timetable?",
                "How to get announcement",
                "How to pay billing fees",
                "Where to see examination timetable?",
            ],
            "responses": [
                "You can find announcement, timetable, billing, examination details and so on at TARUC Student Intranet <a href='https://web.tarc.edu.my/portal/login.jsp' target='_blank' rel='noopener noreferrer'>Login to TARUC Student Intranet</a>"
            ],
        },
        {
            "tag": "attendance_leave",
            "patterns": [
                "How to apply attendance leave",
                "I am sick, what should I do",
                "How to apply leave",
            ],
            "responses": [
                "You can apply attendance leave at TARUC Student Intranet <a href='https://web.tarc.edu.my/portal/login.jsp' target='_blank' rel='noopener noreferrer'>Login to TARUC Student Intranet</a>"
            ],
        },
        {
            "tag": "financial_aids",
            "patterns": [
                "How to apply financial aid",
                "How to apply loan fund",
                "How to apply scholarship",
            ],
            "responses": [
                "You can apply for financial aid or scholarships at the TARUC Student Intranet: <a href='https://web.tarc.edu.my/portal/login.jsp' target='_blank' rel='noopener noreferrer'>Login to TARUC Student Intranet</a>. For more information, visit: <a href='https://www.tarc.edu.my/dsa/financial-aid/financial-aid/' target='_blank' rel='noopener noreferrer'>Financial Aid Information</a>."
            ],
        },
        {
            "tag": "transportation",
            "patterns": [
                "How to find bus schedule",
                "University has provide buses?",
                "Bus will be provided?",
                "What is the bus time?",
            ],
            "responses": [
                "TAR UMT has a fleet of air-conditioned buses to ferry students between the Kuala Lumpur Main Campus and the following nearby residential areas: 1 Wangsa Maju, 2 Teratai Residency/PV18, 3 Genting Kelang /PV18, 4 Melati Utama, 5 PV10, PV12, PV13, PV15, PV16 ; <br/><img src='/Image/bus1.jpg' alt='Bus Image 1' style='max-width:750px; height:auto;'> <img src='/Image/bus2.jpg' alt='Bus Image 2' style='max-width:750px; height:auto;'> <img src='/Image/bus3.jpg' alt='Bus Image 3' style='max-width:750px; height:auto;'>"
            ],
        },
        {
            "tag": "tutorial_class",
            "patterns": ["what is tutorial class?"],
            "responses": [
                "Tutorial class is a small class with group mate, doing and discuss questions with tutor."
            ],
        },
        {
            "tag": "practical_class",
            "patterns": ["what is practical class?"],
            "responses": [
                "Practical class is a small class with group mate, doing lab exercise or assignment using personal laptop or computer in computer lab with tutor."
            ],
        },
        {
            "tag": "lecture_class",
            "patterns": ["what is lecture class?"],
            "responses": [
                "Lecture class is a big class with different programme that taking the same course, listen the lesson taught by lecturer."
            ],
        },
        {
            "tag": "CITC",
            "patterns": [
                "where is citc?",
                "location of citc",
                "I want to use school computer",
                "I have no personal computer.",
            ],
            "responses": [
                'You can use the computer provided at TAR UMT Cyber Center CITC: <br/><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d341.1782695733669!2d101.72637765746907!3d3.2138701991858003!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc386bb5535b83%3A0x2d08b6c5b6fd0155!2sTAR%20UMT%20Cyber%20Centre%20(CITC)!5e0!3m2!1sen!2smy!4v1722355012730!5m2!1sen!2smy" width="800" height="600" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
            ],
        },
        {
            "tag": "block A",
            "patterns": [
                "where is block A?",
                "where is blok A",
                "location of block A?",
                "where is A block?",
                "where is A blok",
                "location of A block?",
            ],
            "responses": [
                'Block A located at <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d248.97112797939403!2d101.72617157479935!3d3.215194900000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc39b773cdafc5%3A0xb1eee137e4f44324!2sDepartment%20of%20Examinations%20and%20Credit%20Accumulation%20(DECA)%2C%20TARUC!5e0!3m2!1sen!2smy!4v1722355067956!5m2!1sen!2smy" width="800" height="600" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
            ],
        },
        {
            "tag": "academic_calandar",
            "patterns": [
                "when is sem break?",
                "I want to have academic calandar?",
                "academic calandar 2024 July",
                "When is examination start?",
                "When is exam start?",
                "When is exam date?",
                "When is school start?",
                "When open school?",
                "When school start?",
            ],
            "responses": [
                "This is academic calandar for July 2024 intake, you can know when is the sem start, when is sem break, when is examination date start in here.<br/> <img src='/Image/C1.jpg' style='max-width:750px; height:auto;'><img src='/Image/C3.jpg' style='max-width:750px; height:auto;'><img src='/Image/C2.jpg' style='max-width:750px; height:auto;'>"
            ],
        },
        {
            "tag": "programme course",
            "patterns": [
                "I want to change course, what are the programme offer?",
                "Programme offer",
                "Bachelor Degree programmes",
                "Diploma Degree programmes",
                "Foundation Degree programmes",
            ],
            "responses": [
                "If you want to change course, the Bachelor Degree and Diploma programmes offered can be found at https://www.tarc.edu.my/admissions/programmes/programme-offered-a-z/undergraduate-programme/ <br/> The Foundation programmes offered can be found at https://www.tarc.edu.my/admissions/programmes/programme-offered-a-z/pre-university-programme/"
            ],
        },
         {
            "tag": "merit_scholarship",
            "patterns": [
                "I obtained good results in my examinations. Is there any merit scholarship and how do I apply?",
                "merit scholarship"
            ],
            "responses": [
                "The Merit Scholarship is awarded to outstanding Malaysian students in the form of tuition fee waiver of up to 100%. Reference can be made at https://www.tarc.edu.my/admissions/a/merit-scholarship/ <br/> Candidates who meet the scholarship criteria will be automatically offered the Merit Scholarship (Terms & Conditions Apply) at the point of admission."
            ],
        },
           {
            "tag": "Faculty_Branch_Campus_Transfer",
            "patterns": [
                "I want to transfer programme to another faculty, how?",
                "I want to change the course to another branch, how?"
                "I want to change the course to another faculty, how?"
            ],
            "responses": [
                "New students who wish to transfer to a programme of another Faculty/Centre/Branch are to apply via Student Intranet. <a href='https://web.tarc.edu.my/portal/login.jsp' target='_blank' rel='noopener noreferrer'>Login to TARUC Student Intranet</a> <br/>Students who wish to transfer to a programme within the same Faculty or Centre are to complete the prescribed form and submit it to the respective Faculty/Centre for Pre-University Studies office/Branch. <br/>Approval for programme/campus transfer is NOT guaranteed.<br/>Students who have accepted the programme/campus transfer through payment of fees (where applicable) will NOT be allowed to transfer back into their original programme/campus."
            ],
        },
           {
            "tag": "withdrawal_programme",
            "patterns": [
                "I want to withdraw from programme, how",
                "I want to exit the programme, how"
            ],
            "responses": [
                "Students who wish to withdraw from their programmes must notify the Admissions Department.<br/>The date the University receives the student’s withdrawal notification is the official date of withdrawal even if the student has stopped attending classes earlier. <br/>Students who do not attend class or discontinues class attendance in a new semester without notifying the University of their withdrawal is liable to all fees due to the University for that semester and subsequently will be withdrawn from the University due to arrears of fees.<br/><a href='https://www.tarc.edu.my/files/admissions/form/221AB6F8-2569-4F9D-AC49-91B79E886656.pdf' target='_blank' rel='noopener noreferrer'>Withdrawal Form</a> "
            ],
        },
            {
            "tag": "horizontal_credit_transfer",
            "patterns": [
                "I want to transfer the credit hours to another course, how",
                "I want to transfer credit"
            ],
            "responses": [
                "Student who had withdrawn from their Bachelor Degree/Diploma programme and have enrolled into another programme of the same level may be eligible for horizontal credit transfer.<br/>The application for horizontal credit transfer is to be made at the respective Faculty latest by Friday of week 4 (for long semester) or week 3 (for short semester) after the commencement of the semester first joined. <br/><a href='https://www.tarc.edu.my/files/admissions/form/C938AE95-749D-4AF9-91F1-0C6F5546D9AC.pdf' target='_blank' rel='noopener noreferrer'>Horizontal Credit Transfer Form</a> "
            ],
        },
    ]
}


# Global variables
vectorizer = None
best_model = None


def train_models():
    global vectorizer, best_model

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
                    augmented_tokens = tokens[:i] + [synonym] + tokens[i + 1 :]
                    augmented_sentences.append(" ".join(augmented_tokens))
        return augmented_sentences

    text_data = []
    labels = []
    stopwords = set(nltk.corpus.stopwords.words("english"))
    lemmatizer = WordNetLemmatizer()

    limit_per_tag = 40

    for intent in intents["intents"]:
        augmented_sentences_per_tag = 0
        for example in intent["patterns"]:
            tokens = nltk.word_tokenize(example.lower())
            filtered_tokens = [
                lemmatizer.lemmatize(token)
                for token in tokens
                if token not in stopwords and token.isalpha()
            ]
            if filtered_tokens:
                text_data.append(" ".join(filtered_tokens))
                labels.append(intent["tag"])

                augmented_sentences = synonym_replacement(
                    filtered_tokens, limit_per_tag - augmented_sentences_per_tag
                )
                for augmented_sentence in augmented_sentences:
                    text_data.append(augmented_sentence)
                    labels.append(intent["tag"])
                    augmented_sentences_per_tag += 1
                    if augmented_sentences_per_tag >= limit_per_tag:
                        break

    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(text_data)
    y = labels

    def find_best_model(X, y, test_size=0.2):
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=test_size, random_state=100
        )

        models = [
            (
                "Logistic Regression",
                LogisticRegression(),
                {
                    "penalty": ["l2"],
                    "C": [0.1, 1.0, 10.0],
                    "solver": ["liblinear"],
                    "max_iter": [100, 1000, 10000],
                },
            ),
            ("Multinomial Naive Bayes", MultinomialNB(), {"alpha": [0.1, 0.5, 1.0]}),
            (
                "Linear SVC",
                LinearSVC(),
                {
                    "penalty": ["l2"],
                    "loss": ["hinge", "squared_hinge"],
                    "C": [0.1, 1, 10],
                    "max_iter": [100, 1000, 10000],
                },
            ),
            (
                "Decision Tree",
                DecisionTreeClassifier(),
                {
                    "max_depth": [5, 10, 20, None],
                    "min_samples_split": [2, 5, 10],
                    "min_samples_leaf": [1, 2, 4],
                    "criterion": ["gini", "entropy"],
                },
            ),
            (
                "Random Forest",
                RandomForestClassifier(),
                {
                    "n_estimators": [100, 200, 300],
                    "max_depth": [10, 20, None],
                    "min_samples_split": [2, 5, 10],
                    "min_samples_leaf": [1, 2, 4],
                },
            ),
        ]

        best_score = 0
        best_model = None

        for name, model, param_grid in models:
            grid = GridSearchCV(model, param_grid, cv=3, n_jobs=-1)
            grid.fit(X_train, y_train)
            y_pred = grid.predict(X_test)
            score = accuracy_score(y_test, y_pred)
            print(f"{name}: {score:.4f} (best parameters: {grid.best_params_})")

            if score > best_score:
                best_score = score
                best_model = grid.best_estimator_

        print(f"\nBest model: {type(best_model).__name__} with score {best_score:.4f}")

        # Fit the best model to the full training data
        best_model.fit(X, y)

        # Save the trained model and vectorizer
        joblib.dump(vectorizer, "vectorizer.pkl")
        joblib.dump(best_model, "best_model.pkl")

        return best_model

    best_model = find_best_model(X, y)


def chatbot_response(user_input):
    global vectorizer, best_model

    if vectorizer is None or best_model is None:
        vectorizer_path = (
            "C:/Users/SEOW HUI CHEE/source/repos/OneStopStudentSystem/vectorizer.pkl"
        )
        vectorizer = joblib.load(vectorizer_path)
        best_model_path = (
            "C:/Users/SEOW HUI CHEE/source/repos/OneStopStudentSystem/best_model.pkl"
        )
        best_model = joblib.load(best_model_path)

    input_text = vectorizer.transform([user_input])
    predicted_intent = best_model.predict(input_text)[0]

    for intent in intents["intents"]:
        if intent["tag"] == predicted_intent:
            response = random.choice(intent["responses"])
            return response

    return "Sorry, I didn't understand that."


if __name__ == "__main__":
    train_models()