#!/usr/bin/env python

# Imports
import pandas as pd
import sqlite3
import logging
from pathlib import Path

logging.basicConfig(level=logging.DEBUG)

# Global variables
# Relatief pad naar data
dbPath = "/Data"
dbName = "Project/Data/db.sqlite3"
tableName = "rest_api_netlify"
# Extract
# Sheets -> Collection

logging.info("Extract from DB")

# Maak een verbinding met de SQLite DB

dbConnection = sqlite3.connect(dbName)

# Haal alle gegevens op uit de tabel rest_netlify_api en sla die op in een Pandas dataframe
# Zie notebook data_collection
df = pd.read_sql_query(f"SELECT * FROM {tableName}", dbConnection)
pd.set_option('display.max_columns', 10)
dfFromDB.drop(['id'], axis=1)

logging.info("Transform the data")


# Sheets -> Data Selection

for c in df.columns:
    df[c] = pd.to_numeric(df[c], errors='coerce')

# outliers

def remove_outliers(df,columns,n_std):
    for col in columns:
        print('Working on column: {}'.format(col))
        
        mean = df[col].mean()
        sd = df[col].std()
        
        df = df[(df[col] <= mean+(n_std*sd))]
        
    return df

# Maak nieuw dataframes aan o.b.v. geselecteerde kolommen -> kopieer uit je notebook EDA
# Sheets - > Feature Extraction

# df_bmi

col_bmi = (df.mass/(df.length/100)**2)
df_bmi = df.drop(['length', 'mass'], axis=1)
df_bmi['bmi'] = col_bmi
 
logging.info("Load the transformed datasets as tables in the DB")  

# df_lifestyle

df_lifestyle = df[['exercise', 'smoking', 'alcohol', 'sugar', 'lifespan']]

# df_not_genetic

df_not_genetic = df.drop(['genetic'], axis = 1)
df_ng = df_not_genetic

# Zie notebook SQL Practicum
df.to_sql('bmi', con=dbConnection, if_exists=replace, index=False)
logging.info("Succes")
# Sluit database

con.close()
