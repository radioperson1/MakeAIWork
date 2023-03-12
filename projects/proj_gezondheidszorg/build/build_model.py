#!/usr/bin/env python

import logging
import pandas as pd
import pickle
import statsmodels as sm
import statsmodels.formula.api as smf
import sqlite3

# Global configuration
logging.basicConfig(level=logging.DEBUG)

dbName = "../rest_server/medisch_centrum_randstad/db.sqlite3"
tableName = "rest_api_netlify"

logging.info("Load transformed data from database into dataframe")
dbConnection = sqlite3.connect(dbName)
dfFromDB = pd.read_sql_query(f"SELECT * FROM {tableName}", dbConnection)

logging.info("Build Regression Model")

y = dfFromDB['lifespan']
logging.debug(f"y : {y}")

X = dfFromDB['length']
logging.debug(f"X : {X}")

model = sm.OLS(y, X).fit()

# pickle.dump(self.model, open(exportFile,'wb'))
    