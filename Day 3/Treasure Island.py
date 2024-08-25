print('''Welcome to Treasure Island.
Your mission is to find the treasure
    !LETS B EGIN!
''')

c1 = input("where do want to go ? 'LEFT' or 'RIGHT' : ").lower()


if c1 == "left":
    c2 = input("Will you swim or wait? ").lower()
    if c2 == "wait":
        c3 = input("which door you choose?").lower()
        if c3 == "blue":
            print("Eaten by beasts.Game Over.")
        elif c3 == "red":
            print("Burned by fire.Game Over.")
        elif c3 == "yellow":
            print("YOU WIN!!!")
        else:
            print("GAME OVER!")
    else:
        print("Attacked by trout.Game Over.!")
else:
    print("Fall into a hole.GAME OVER!")

