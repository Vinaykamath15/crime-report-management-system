create database crime_reports_db;


use crime_reports_db;
SET SQL_SAFE_UPDATES = 0;
delete from murder_reports;
ALTER TABLE murder_reports MODIFY case_status VARCHAR(50);


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

use crime_reports_db;
CREATE VIEW crime_summary AS
SELECT 'Murder' AS crime_type, case_name, time_of_incident, location, crime_severity, reported_immediately, reported_same_day
FROM murder_reports
UNION ALL
SELECT 'Assault', case_name, time_of_incident, location, crime_severity, reported_immediately, reported_same_day
FROM assault_reports
UNION ALL
SELECT 'Theft', case_name, time_of_incident, location, crime_severity, report_immediate, reported_same_day
FROM theft_reports
UNION ALL
SELECT 'Fraud', case_name, time_of_incident, location, crime_severity, reported_same_day, NULL
FROM fraud_reports
UNION ALL
SELECT 'Sexual Assault', case_name, time_of_incident, location, crime_severity, reported_same_day, NULL
FROM sexual_assault_reports
UNION ALL
SELECT 'Domestic Violence', case_name, time_of_incident, location, crime_severity, reported_same_day, NULL
FROM domestic_violence_reports
UNION ALL
SELECT 'Drug Offense', case_name, incident_time AS time_of_incident, location, severity AS crime_severity, reported_same_day, NULL
FROM drug_offense_reports
UNION ALL
SELECT 'Traffic Accident', case_name, time_of_incident, location, crime_severity, same_day_report, NULL
FROM traffic_accident_reports;

-- Total cases by crime type
SELECT crime_type, COUNT(*) AS total_cases
FROM crime_summary
GROUP BY crime_type;

-- Case severity distribution for a specific crime type
SELECT crime_severity, COUNT(*) AS severity_count
FROM crime_summary
WHERE crime_type = 'Murder'
GROUP BY crime_severity;

-- Incidents by location for all crimes
SELECT location, COUNT(*) AS location_count
FROM crime_summary
GROUP BY location;


USE crime_reports_db;

INSERT INTO murder_reports (
    murder_id, case_name, time_of_incident, location, weapon_used, victim_known, 
    crime_severity, victim_age, victim_gender, victim_occupation, witness_present, 
    reported_immediately, reported_same_day, details_of_incident, case_status, additional_comments
) VALUES 
    ('md--01', 'Downtown Knife Assault', '2024-05-12 22:15:00', 'Downtown Park', 'Knife', 'Yes', 
     'Critical', 34, 'Male', 'Engineer', 'Yes', 'Yes', 'No', 
     'The victim was attacked with a knife during an altercation.', 'Yes', 'Witness provided a description.'),
    
    ('md--02', 'Mall Robbery Shooting', '2024-06-18 03:30:00', 'Central Mall', 'Firearm', 'No', 
     'Serious', 28, 'Female', 'Teacher', 'No', 'No', 'No', 
     'Victim was shot in a robbery attempt.', 'No', 'Investigations are ongoing.'),
    
    ('md--03', 'Bridge Guard Assault', '2023-11-22 19:45:00', 'City Bridge', 'Other', 'Yes', 
     'Moderate', 45, 'Male', 'Security Guard', 'Yes', 'Yes', 'Yes', 
     'The victim was attacked with a blunt object during patrol.', 'Yes', 'Suspect identified by victim.'),
    
    ('md--04', 'Strangulation in Alley', '2023-12-10 08:30:00', 'Suburban Alley', 'None', 'No', 
     'Minor', 29, 'Female', 'Nurse', 'No', 'Yes', 'Yes', 
     'Victim found injured with signs of strangulation.', 'No', 'No suspect yet.'),
    
    ('md--05', 'Domestic Stabbing Incident', '2024-01-01 01:15:00', 'Apartment Complex', 'Knife', 'Yes', 
     'Serious', 38, 'Male', 'Accountant', 'No', 'No', 'No', 
     'The victim was stabbed during a domestic dispute.', 'Yes', 'No other witnesses were present.'),
    
    ('md--06', 'Highway Drive-By Shooting', '2024-02-15 14:25:00', 'Highway 101', 'Firearm', 'No', 
     'Critical', 22, 'Male', 'Student', 'Yes', 'No', 'Yes', 
     'Victim was shot from a vehicle in a suspected gang-related incident.', 'No', 'Details remain unclear.'),
    
    ('md--07', 'Beachfront Rock Attack', '2024-03-12 16:00:00', 'Beachfront', 'Other', 'Yes', 
     'Moderate', 56, 'Female', 'Chef', 'Yes', 'Yes', 'Yes', 
     'Victim was attacked with a rock during an argument.', 'Yes', 'Suspect is in custody.'),
    
    ('md--08', 'Club Stabbing', '2024-04-18 23:50:00', 'Riverside Club', 'Knife', 'No', 
     'Critical', 31, 'Male', 'Bartender', 'No', 'Yes', 'No', 
     'Victim was stabbed in a club altercation.', 'No', 'Few leads on suspects.'),
    
    ('md--09', 'Downtown Burglary Shooting', '2024-05-02 02:45:00', 'Downtown Street', 'Firearm', 'No', 
     'Serious', 25, 'Female', 'Artist', 'Yes', 'No', 'Yes', 
     'Victim shot during suspected burglary.', 'Yes', 'Victim survived with critical injuries.'),
    
    ('md--10', 'Crowbar Assault in Shopping District', '2024-06-25 20:00:00', 'Shopping District', 'Other', 'Yes', 
     'Moderate', 40, 'Male', 'Retail Manager', 'No', 'Yes', 'No', 
     'Victim attacked with a crowbar in attempted robbery.', 'No', 'Victim is recovering.'),
    
    ('md--11', 'Stabbing in Legal Dispute', '2023-07-14 13:30:00', 'Suburban Mall', 'Knife', 'Yes', 
     'Critical', 47, 'Female', 'Lawyer', 'Yes', 'Yes', 'Yes', 
     'Victim was fatally stabbed during a legal dispute.', 'Yes', 'Suspect apprehended.'),
    
    ('md--12', 'Farmland Assault', '2024-08-05 05:20:00', 'Rural Farmland', 'None', 'No', 
     'Minor', 35, 'Male', 'Farmer', 'No', 'Yes', 'Yes', 
     'Victim found with head injury, possible accident or assault.', 'No', 'Awaiting forensic report.'),
    
    ('md--13', 'Industrial Site Shooting', '2024-09-09 18:10:00', 'Industrial Site', 'Firearm', 'Yes', 
     'Serious', 33, 'Female', 'Engineer', 'Yes', 'No', 'Yes', 
     'Victim was shot while exiting her vehicle.', 'Yes', 'Suspect known to victim.'),
    
    ('md--14', 'Nightclub Glass Assault', '2024-10-11 00:00:00', 'Night Club', 'Other', 'No', 
     'Critical', 29, 'Male', 'DJ', 'Yes', 'Yes', 'Yes', 
     'Victim was severely injured with a glass bottle.', 'No', 'Suspect fled the scene.'),
    
    ('md--15', 'Backstage Stabbing at Concert', '2024-10-31 21:35:00', 'Concert Venue', 'Knife', 'Yes', 
     'Serious', 24, 'Female', 'Musician', 'Yes', 'Yes', 'Yes', 
     'Victim was stabbed during a backstage altercation.', 'Yes', 'Witnesses confirm suspect identity.');

USE crime_reports_db;

INSERT INTO assault_reports (
    assault_id, case_name, time_of_incident, location, crime_severity, victim_age, 
    victim_gender, victim_occupation, witness_present, reported_immediately, 
    reported_same_day, type_of_assault, injuries_reported, weapon_involved, 
    details_of_incident, additional_comments
) VALUES 
    ('as--01', 'Park Brawl Incident', '2024-01-15 21:45:00', 'City Park', 'Serious', 30, 
     'Male', 'Construction Worker', 'Yes', 'Yes', 'Yes', 'Physical', 'Yes', 'Yes', 
     'Victim was attacked with a baseball bat by an unknown assailant.', 'Investigation ongoing.'),
    
    ('as--02', 'Mall Threat Encounter', '2024-02-20 14:30:00', 'Shopping Mall', 'Moderate', 25, 
     'Female', 'Retail Associate', 'No', 'No', 'Yes', 'Verbal', 'No', 'No', 
     'Victim was verbally threatened by a customer.', 'Assailant left before security arrived.'),
    
    ('as--03', 'Campus Assault', '2024-03-18 17:10:00', 'School Campus', 'Critical', 19, 
     'Female', 'Student', 'Yes', 'Yes', 'No', 'Sexual', 'Yes', 'No', 
     'Victim reported being attacked in a secluded area of campus.', 'Support provided to victim.'),
    
    ('as--04', 'Bar Altercation', '2024-04-05 23:00:00', 'Downtown Bar', 'Serious', 40, 
     'Male', 'Bartender', 'Yes', 'No', 'Yes', 'Physical', 'Yes', 'Yes', 
     'Victim was punched by a patron during an altercation.', 'Victim sustained minor injuries.'),
    
    ('as--05', 'Office Harassment', '2024-05-12 08:45:00', 'Office Building', 'Moderate', 34, 
     'Female', 'Accountant', 'No', 'Yes', 'Yes', 'Verbal', 'No', 'No', 
     'Victim harassed by a colleague with aggressive language.', 'HR investigating incident.'),
    
    ('as--06', 'Subway Knife Attack', '2024-06-21 19:00:00', 'Subway Station', 'Critical', 27, 
     'Male', 'Musician', 'Yes', 'Yes', 'No', 'Physical', 'Yes', 'Yes', 
     'Victim attacked with a knife while waiting for the train.', 'Security footage under review.'),
    
    ('as--07', 'Market Threat Incident', '2024-07-15 13:25:00', 'Local Market', 'Moderate', 55, 
     'Female', 'Vendor', 'No', 'Yes', 'Yes', 'Verbal', 'No', 'No', 
     'Victim was threatened by a customer over a dispute.', 'Victim filed a report.'),
    
    ('as--08', 'Parking Dispute Assault', '2024-08-23 21:15:00', 'Residential Area', 'Serious', 31, 
     'Male', 'Teacher', 'Yes', 'No', 'No', 'Physical', 'Yes', 'No', 
     'Victim was attacked by a neighbor in a parking dispute.', 'Medical assistance was provided.'),
    
    ('as--09', 'Garage Attack', '2024-09-14 18:40:00', 'Parking Garage', 'Critical', 29, 
     'Female', 'Doctor', 'Yes', 'Yes', 'Yes', 'Sexual', 'Yes', 'No', 
     'Victim reported an assault by an unidentified individual.', 'Investigation is in progress.'),
    
    ('as--10', 'Concert Hall Attack', '2024-10-08 20:10:00', 'Concert Hall', 'Serious', 23, 
     'Male', 'Event Staff', 'No', 'No', 'Yes', 'Physical', 'Yes', 'Yes', 
     'Victim was attacked by an intoxicated attendee.', 'Witnesses provided statements.');


 