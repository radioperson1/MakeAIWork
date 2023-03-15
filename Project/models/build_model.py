#!/usr/bin/env python

import sqlite3
import logging
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
from sklearn import preprocessing, linear_model

import pickle

# Global configuration
logging.basicConfig(level=logging.DEBUG)


dbName = "Project/rest_server/db.sqlite3"
tableName = "bmi"

logging.info("Load transformed data from database into dataframe")
dbConnection = sqlite3.connect(dbName)
df = pd.read_sql_query(f"SELECT * FROM {tableName}", dbConnection)


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

model = [] 

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

for v in version_list:
    model.append(calculateModel(df, v))

pickle.dump(model, open('model.pkl', 'wb'))

logging.info("Succes")