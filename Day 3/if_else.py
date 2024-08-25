weight = 65
height = 1.85

bmi = weight / (height ** 2)
print(bmi)
if bmi >=25:
    print("overweight")  
elif bmi >=18.5:
    print("normal weight")
else:
    print("underweight")
