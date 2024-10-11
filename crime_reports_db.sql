use crime_reports_db;


use crime_reports_db;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM assault_reports;
DELETE FROM murder_reports;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

use crime_reports_db;
CREATE TABLE murder_reports (
    murder_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    weapon_used ENUM('Firearm', 'Knife', 'None', 'Other') NOT NULL,
    victim_known ENUM('Yes', 'No') NOT NULL,
    crime_severity ENUM('Minor', 'Moderate', 'Serious', 'Critical') NOT NULL,
    victim_age INT NOT NULL,
    victim_gender VARCHAR(10) NOT NULL,
    victim_occupation VARCHAR(100) NOT NULL,
    witness_present ENUM('Yes', 'No') NOT NULL,
    reported_immediately ENUM('Yes', 'No') NOT NULL,
    reported_same_day ENUM('Yes', 'No') NOT NULL,
    details_of_incident TEXT NOT NULL,
    case_status ENUM('Yes', 'No') NOT NULL,
    additional_comments TEXT
);



use crime_reports_db;
CREATE TABLE assault_reports (
    assault_id VARCHAR(50) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    crime_severity ENUM('Minor', 'Moderate', 'Serious', 'Critical') NOT NULL,
    victim_age INT NOT NULL,
    victim_gender VARCHAR(50) NOT NULL,
    victim_occupation VARCHAR(100) NOT NULL,
    witness_present ENUM('Yes', 'No') NOT NULL,
    reported_immediately ENUM('Yes', 'No') NOT NULL,
    reported_same_day ENUM('Yes', 'No') NOT NULL,
    type_of_assault ENUM('Physical', 'Verbal', 'Sexual') NOT NULL,
    injuries_reported ENUM('Yes', 'No') NOT NULL,
    weapon_involved ENUM('Yes', 'No') NOT NULL,
    details_of_incident TEXT NOT NULL,
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE theft_reports (
    theft_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(100) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    weapon_involved VARCHAR(3) CHECK (weapon_involved IN ('Yes', 'No')),
    robbery_violent VARCHAR(3) CHECK (robbery_violent IN ('Yes', 'No')),
    stolen_items TEXT NOT NULL,
    crime_severity VARCHAR(10) CHECK (crime_severity IN ('Minor', 'Moderate', 'Serious', 'Critical')),
    victim_age INT NOT NULL,
    victim_gender VARCHAR(10) NOT NULL,
    victim_occupation VARCHAR(100) NOT NULL,
    witness_present VARCHAR(3) CHECK (witness_present IN ('Yes', 'No')),
    report_immediate VARCHAR(3) CHECK (report_immediate IN ('Yes', 'No')),
    reported_same_day VARCHAR(3) CHECK (reported_same_day IN ('Yes', 'No')),
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE fraud_reports (
    fraud_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location ENUM('Online', 'Physical') NOT NULL,
    type_of_fraud ENUM('Identity theft', 'Financial fraud', 'Credit card fraud', 'Other') NOT NULL,
    details_of_incident TEXT NOT NULL,
    crime_severity ENUM('Minor', 'Moderate', 'Serious', 'Critical') NOT NULL,
    victim_age INT NOT NULL,
    victim_gender ENUM('Male', 'Female', 'Other') NOT NULL,
    victim_occupation VARCHAR(255) NOT NULL,
    witness ENUM('Yes', 'No') NOT NULL,
    reported_same_day ENUM('Yes', 'No') NOT NULL,
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE sexual_assault_reports (
    sa_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    relationship_to_perpetrator ENUM('Stranger', 'Acquaintance', 'Partner', 'Family') NOT NULL,
    crime_severity ENUM('Minor', 'Moderate', 'Serious', 'Critical') NOT NULL,
    victim_age INT NOT NULL,
    victim_gender ENUM('Male', 'Female', 'Other') NOT NULL,
    victim_occupation VARCHAR(255) NOT NULL,
    was_witness ENUM('Yes', 'No') NOT NULL,
    reported_same_day ENUM('Yes', 'No') NOT NULL,
    details_of_incident TEXT NOT NULL,
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE domestic_violence_reports (
    da_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(100) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    crime_severity VARCHAR(20) NOT NULL,
    type_of_abuse VARCHAR(20) NOT NULL,
    relationship_to_perpetrator VARCHAR(20) NOT NULL,
    victim_age INT NOT NULL,
    victim_gender VARCHAR(20) NOT NULL,
    victim_occupation VARCHAR(100) NOT NULL,
    witness VARCHAR(3) NOT NULL,
    reported_same_day VARCHAR(3) NOT NULL,
    details_of_incident TEXT NOT NULL,
    victim_previously_harmed VARCHAR(3) NOT NULL,
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE drug_offense_reports (
    drug_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    incident_time DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    drug_type VARCHAR(50) NOT NULL,
    details TEXT NOT NULL,
    severity VARCHAR(50) NOT NULL,
    criminal_age INT NOT NULL,
    criminal_gender VARCHAR(50) NOT NULL,
    criminal_occupation VARCHAR(100) NOT NULL,
    witness VARCHAR(3) NOT NULL CHECK (witness IN ('yes', 'no')),
    reported_same_day VARCHAR(3) NOT NULL CHECK (reported_same_day IN ('yes', 'no')),
    quantity_seized DECIMAL(10, 2),
    additional_comments TEXT
);

use crime_reports_db;
CREATE TABLE traffic_accident_reports (
    traffic_id VARCHAR(10) PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    time_of_incident DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    injuries VARCHAR(3) NOT NULL,
    property_damage VARCHAR(3) NOT NULL,
    alcohol_drugs_involved VARCHAR(3) NOT NULL,
    details_of_accident TEXT NOT NULL,
    crime_severity VARCHAR(10) NOT NULL,
    victim_age INT NOT NULL,
    victim_gender VARCHAR(10) NOT NULL,
    victim_occupation VARCHAR(100) NOT NULL,
    witness VARCHAR(3) NOT NULL,
    same_day_report VARCHAR(3) NOT NULL,
    additional_comments TEXT
);
