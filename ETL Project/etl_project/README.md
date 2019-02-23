ETL Project Documentation

STEP 1:
pip install MySQLdb()


EXTRACT
STEP 2: 
read "Resources/business_licenses.csv", "Resources/Chicago_Crimes_2012_to_2017.csv" into separate pandas dataframe


TRANSFORM
STEP 3: 
select desired columns from pandas dataframes
business dataframe: [['LEGAL NAME', 'ADDRESS', 'POLICE DISTRICT', 'APPLICATION REQUIREMENTS COMPLETE']]
crime dataframe: [['Date', 'Primary Type', 'Description', 'District', 'Arrest']]

STEP 4: 
rename columns in pandas dataframes
business dataframe:     
    'LEGAL NAME':'legal_name',
    'ADDRESS':'address',
    'POLICE DISTRICT':'police_district',
    'APPLICATION REQUIREMENTS COMPLETE': 'paid_date'
crime dataframe: 
    'Date':'date', 
    'Primary Type':'crime_type',
    'Description':'description',
    'District':'district',
    'Arrest':'arrest'


LOAD
STEP 5: 
Create schemas to load in pandas dataframes

CREATE TABLE chicago_crime(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date VARCHAR(255),
    crime_type VARCHAR(255),
    description VARCHAR(255),
    location_type VARCHAR(255),
    district VARCHAR(255),
    arrest VARCHAR(255)
);

CREATE TABLE business(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    legal_name VARCHAR(255),
    address VARCHAR(255),
    police_district VARCHAR(255),
    paid_date VARCHAR(255)
);

STEP 6: 
create connection/engine to link pandas/Jupyter Notebook to MySQL:
rds_connection_string = f'root:{password}@127.0.0.1/etl_project'
engine = create_engine(f'mysql://{rds_connection_string}')

STEP 7:
Check table names

STEP 8: 
send pandas dataframes to MySQL
crime_clean_df.to_sql(name='chicago_crime', con=engine, if_exists='append', index=False)
business_clean_df.to_sql(name='business', con=engine, if_exists='append', index=False)

STEP 9: 
merge crime, business MySQL tables by joining on Police District columns to analyze what types of crimes occur in business-heavy police districts as compared to more residential police districts

SELECT
chicago_crime.date as crime_date,
chicago_crime.description, 
chicago_crime.district,
chicago_crime.arrest,
business.legal_name,
business.address, 
business.police_district,
business.paid_date
FROM chicago_crime
INNER JOIN business
ON chicago_crime.district = business.police_district
;
