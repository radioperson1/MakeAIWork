#!/usr/bin/env python

import logging
import pandas as pd
import pickle
import statsmodels as sm
import statsmodels.formula.api as smf
import sqlite3

# Global configuration
logging.basicConfig(level=logging.DEBUG)

dbName = "../Project/rest_server/db.sqlite3"
tableName = "bmi"

logging.info("Load transformed data from database into dataframe")
dbConnection = sqlite3.connect(dbName)
dfFromDB = pd.read_sql_query(f"SELECT * FROM {tableName}", dbConnection)


# Define different inputs to train model

v1 = ['genetic','exercise','smoking','alcohol','sugar','bmi']
v2 = ['exercise','smoking','alcohol','sugar','bmi']
v3 = ['genetic','exercise','smoking','alcohol','sugar']
v4 = ['exercise','smoking','alcohol','sugar']
v5 = ['genetic']
v6 = ['bmi']

version_list = [v1,v2,v3,v4,v5]

# Function to calculate and train model for different dataframe input
logging.info("Build Regression Model")

def calculateModel(dataframe, version):

    x = dataframe[version]
    y = dataframe.loc[:, 'lifespan']
    
    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size= 0.3, random_state = 42)
    
    model = LinearRegression()
    model.fit(x_train,y_train)
    predictions = model.predict(x_test)

    ms_error =  mean_squared_error(y_test, predictions)
    ma_error = mean_absolute_error(y_test, predictions)
    
    coefs = list(zip(x.columns, model.coef_))
    r2 = r2_score(y_test, predictions)
    intercept = model.intercept_
    
    return ms_error, ma_error, coefs, r2, intercept

# Function to calculate lifespan based of model

def determineLifespan(genetic, exercise, smoking, alcohol, sugar, bmi):

    gen_coef = 1.0009704513524607
    exe_coef = 0.7776985050881321
    smo_coef = -0.26863618220273244
    alc_coef = -0.1975255196844301
    sug_coef = -0.05445870178572912
    bmi_coef = -0.07155025866396975
    
    genetic *= gen_coef
    exercise *= exe_coef
    smoking *= smo_coef
    alcohol *= alc_coef
    sugar *= sug_coef
    bmi *= bmi_coef

    b = 1.3430756808759128

    lifespan = genetic + exercise + smoking + alcohol + sugar + bmi + b
    
    return lifespan

pickle.dump(model, open('model.pkl', 'wb'))