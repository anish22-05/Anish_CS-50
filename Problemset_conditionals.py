'''IN "Deep Thought" we implement a program that prompts the user for the answer to Greet Question of life,
the universe and everything, outputting Yes if the user inputs 42 or forty-two or forty two.
Otherwise No.'''
user = input("What is the Answer to the Great Question of Life, the Universe, and Everything? ")
if user == "42":
    print( "Yes")
elif user == "forty-two" or user == "FORTY-TWO" or user == "forty two" or user == "FORTY TWO":
    print("Yes")
else:
    print("No")