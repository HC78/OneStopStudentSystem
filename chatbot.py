#!/usr/bin/env python
# coding: utf-8

import sys
import warnings
from chatbotTrain import chatbot_response

# Suppress warnings
warnings.filterwarnings('ignore', category=UserWarning, module='sklearn')

def main():
    if len(sys.argv) > 1:
        user_input = ' '.join(sys.argv[1:]) 
        response = chatbot_response(user_input)  
        print(response) 
    else:
        print("No input provided.")

if __name__ == "__main__":
    main()

