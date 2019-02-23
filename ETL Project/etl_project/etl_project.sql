CREATE DATABASE etl_project;

USE etl_project;


CREATE TABLE chicago_crime(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date VARCHAR(255),
    crime_type VARCHAR(255),
    description VARCHAR(255),
    location_type VARCHAR(255),
    district VARCHAR(255),
    arrest VARCHAR(255)
);


SELECT * FROM chicago_crime;

CREATE TABLE business(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    legal_name VARCHAR(255),
    address VARCHAR(255),
    police_district VARCHAR(255),
    paid_date VARCHAR(255)
);

SELECT * FROM business;


SELECT chicago_crime.id, chicago_crime.date, chicago_crime.description, 
chicago_crime.district, chicago_crime.arrest, business.legal_name, business.address, 
business.police_district, business.paid_date
FROM chicago_crime
JOIN business
ON chicago_crime.district = business.police_district;
