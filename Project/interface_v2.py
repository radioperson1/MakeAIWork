#!/usr/bin/env python

import logging
import pandas as pd
import pickle
import statsmodels as sm
import statsmodels.formula.api as smf
import sqlite3


gen_coef = 1.0009704513524607
exe_coef = 0.7776985050881321
smo_coef = -0.26863618220273244
alc_coef = -0.1975255196844301
sug_coef = -0.05445870178572912
bmi_coef = -0.07155025866396975

# Predict lifespan with regressor and inputData, bij volgende versie model gebruiken
def determineLifespan(genetic, exercise, smoking, alcohol, sugar, bmi):
    
    genetic *= gen_coef
    exercise *= exe_coef
    smoking *= smo_coef
    alcohol *= alc_coef
    sugar *= sug_coef
    bmi *= bmi_coef
    b = 1.3430756808759128
    lifespan = genetic + exercise + smoking + alcohol + sugar + bmi + b
    
    return lifespan


def inputDigit(message, acceptableRange):
    inputStr = str()
    withinRange = False
    numberOfTries = 3
    inputNum = None
    i = 0

    while not (inputStr.isdigit() and withinRange) and i < numberOfTries:
        inputStr = input(message)
        logging.debug(inputStr)

        if inputStr.isdigit():
            inputNum = float(inputStr)

            if inputNum in acceptableRange:
                return inputNum

        i += 1

    return None


# 1. Read life style parameters (age, smoking, ..) # dit in een for loop zetten? clean code

acceptableRange = range(18, 118)
genetic = int(inputDigit("Genetic age [18 - 118]: ", acceptableRange))
logging.debug(f"genetic age : {genetic}")

acceptableRange = range(0,6)
exercise = float(inputDigit("Hours of exercise per day [0-6]", acceptableRange))
logging.debug(f"exercise : {exercise}")

acceptableRange = range(0, 30)
smoking = float(inputDigit("Sigarettes per day [0 - 30]: ", acceptableRange))
logging.debug(f"smoking: {smoking}")

acceptableRange = range(0, 6)
alcohol = float(inputDigit("Glasses of alcohol per day [0 - 6]", acceptableRange)) # optie wijzigen naar per week meesten zijn niet zo consequent
logging.debug(f"alcohol : {alcohol}")

acceptableRange = range(0,14)
sugar = float(inputDigit("Sugar per day [0 - 14]", acceptableRange))
logging.debug(f"sugar : {sugar}")

acceptableRange = range(147, 220)
length = float(inputDigit("Lenght in cm [147 - 220]", acceptableRange))
logging.debug(f"length in cm: {length}")

acceptableRange = range(40,180)
mass = float(inputDigit("Mass in kg [40 - 150]", acceptableRange))
logging.debug(f"mass: {mass}", acceptableRange)


# 2. Compute BMI
bmi = mass / length**2

# 2. Feed the parameters into the model
prediction = determineLifespan(genetic, exercise, smoking, alcohol, sugar, bmi)

# 3. Display result
print(f"The expected lifespan of your patient, based off the info you filled in is {prediction}")

