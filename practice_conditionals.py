'''What a program that asks the user for their age and prints, You are eligible to vote, 
If they are 18 or older.'''
# age = int(input("Enter your age:"))
# if age >= 18:
#     print("You can vote.")
# else:
#     print("You are not eligible to vote.")
'''Given a number, print "Even" if it's even and "Odd" if it's odd.'''
# num = int(input("Enter a number: "))
# if num % 2 == 0:
#     print("Number is Even.")
# else: 
#     print("Number is Odd.")
'''Write a program that asks the user for their grade (0-100) 
and prints the corresponidng letter grade (A-F)'''
grade = int(input("Enter your marks: "))
if 95 < grade <= 100:
    print("You got grade - A.")
elif 90 < grade <= 95:
    print("Your got grade - B.")
elif 85 < grade <= 90:
    print("your grade - C.")
elif 70 < grade <= 85:
    print("Your grade - D.")
elif 40 < grade <= 70:
    print("Your grade - E.")
else:
    print("You have failed, your grade - F.")