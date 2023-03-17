# code to start flask in bash: flask --app interface_v1 --debug run

import logging
import pandas
import pickle
import sqlite3
from flask import Flask, redirect, url_for

app = Flask(__name__)
a = False
@app.route("/")
def home():
    return "Hello! This is the main page <h1>HELLO<h1>"

gen_coef = 1.0009704513524607
exe_coef = 0.7776985050881321
smo_coef = -0.26863618220273244
alc_coef = -0.1975255196844301
sug_coef = -0.05445870178572912
bmi_coef = -0.07155025866396975

@app.route("/<name>")
def user(name):
    return f"Welcome back {name}"

    def getInput():

        genetic = f"'Genetic age in years (18-120)' + input()"
pass

def determineLifespan(genetic, exercise, smoking, alcohol, sugar, bmi):
    
    genetic = input() gen_coef
    exercise *= exe_coef
    smoking *= smo_coef
    alcohol *= alc_coef
    sugar *= sug_coef
    bmi *= bmi_coef
    b = 1.3430756808759128
    lifespan = genetic + exercise + smoking + alcohol + sugar + bmi + b
    
    return lifespan

    def inputUser(genetic, exercise, smoking, alcohol, sugar, bmi):

        

@app.route("/admin")
def admin():
    if a: #someone who is not administor
    return redirect(url_for("home"))



if __name__ == "__main__":
    app.run()

