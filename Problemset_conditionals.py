'''IN "Deep Thought" we implement a program that prompts the user for the answer to Greet Question of life,
the universe and everything, outputting Yes if the user inputs 42 or forty-two or forty two.
Otherwise No.'''
# user = input("What is the Answer to the Great Question of Life, the Universe, and Everything? ")
# simple approach 
# if user == "42":
#     print( "Yes")
# elif user == "forty-two" or user == "FORTY-TWO" or user == "forty two" or user == "FORTY TWO":
#     print("Yes")
# else:
#     print("No")
# more compact approach.
# if user.strip() == "42" or user.lower() == "forty-two" or user.lower() == "forty-two":
#     print("Yes")
# else:
#     print("No")
'''Implement a program that prompts the user for a greeting. If the greeting starts with "hello"
,output $0. If the greeting starts with an "h"(but not hello), output $20. Otherwise output $100
Ignore any leading whitespace in the users greeting, and treat the user's greeting case- insensitivity.'''

# greet = int(input("Greeting: "))
# if greet.strip().lower().startswith("hello"):
#     print("$0")
# elif greet.strip().lower()[0] == "h":
#     print("$20")
# else:
#     print("$100")
'''Meal Time.''' 
# def main():
#     time = input("What time is it? ").strip().lower()
#     dectime = convert(time)
#     if 7 <= dectime <= 8:
#         print("breakfast time")
#     elif 12 <= dectime <= 13:
#         print("lunch time")
#     elif 18 <= dectime <= 19:
#         print("dinner time")
    
# def convert(time):
#     hours, minutes = time.split(":")
#     dectime = float(hours)+float(minutes)/60
#     return dectime

# if __name__ == "__main__":
#     main()