#!/usr/bin/env python

# Imports
import logging
import pandas as pd
import sqlite3

# Hardening
from pathlib import Path

# Global configuration
logging.basicConfig(level=logging.DEBUG)
dbName = "Project/rest_server/db.sqlite3"
tableName = "rest_api_netlify"

# Collecting the data
logging.info("Load transformed data from database into dataframe")

logging.info(f"Connect to {Path(dbName).name}")
dbConnection = sqlite3.connect(dbName)
dfFromDB = pd.read_sql_query(f"SELECT * FROM {tableName}", dbConnection)
logging.debug(dfFromDB.head())

# Cleaning
logging.info("Preprocessing : remove rows with missing values")
for c in dfFromDB.columns: # de loop
    dfFromDB[c] = pd.to_numeric(dfFromDB[c], errors = 'coerce')
    dfCleanFromDB = dfFromDB.dropna()

logging.debug(dfCleanFromDB.head())

# Transform
# BMI = (Weight in Kilograms / (Height in Meters x Height in Meters))
col_bmi = (dfCleanFromDB.mass/(dfCleanFromDB.length/100)**2)
df = dfCleanFromDB.drop(['length', 'mass'], axis=1)
df['bmi'] = col_bmi
logging.debug(f"BMI : {df}")


# Save df as new table
df.to_sql('bmi', con=dbConnection, if_exists='replace', index=False)



# close Connection
dbConnection.close()