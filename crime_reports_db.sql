create database crime_reports_db;


use crime_reports_db;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

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
     
INSERT INTO theft_reports VALUES
('th--001', 'Robbery at Downtown Mall', '2024-10-11 14:30:00', 'Downtown Mall, NY', 'Yes', 'Yes', 'Jewelry, Cash', 'Critical', 35, 'Female', 'Store Manager', 'Yes', 'Yes', 'No', 'Suspect fled before police arrival.'),
('th--002', 'Burglary in Elm Street', '2024-09-20 02:45:00', 'Elm Street, TX', 'No', 'No', 'Electronics', 'Moderate', 28, 'Male', 'Software Engineer', 'No', 'No', 'No', 'The burglary happened late at night.'),
('th--003', 'Purse Snatching at Central Park', '2024-08-25 18:15:00', 'Central Park, NY', 'No', 'Yes', 'Purse, Phone', 'Serious', 42, 'Female', 'Teacher', 'Yes', 'Yes', 'Yes', 'The victim screamed for help.'),
('th--004', 'Car Theft at City Garage', '2024-07-10 09:00:00', 'City Garage, CA', 'No', 'No', 'Car, Keys', 'Serious', 30, 'Male', 'Driver', 'No', 'No', 'No', 'The thief used a duplicate key.'),
('th--005', 'Jewelry Theft at Bridal Shop', '2024-06-15 15:30:00', 'Bridal Shop, FL', 'Yes', 'No', 'Necklace, Earrings', 'Moderate', 27, 'Female', 'Sales Assistant', 'Yes', 'Yes', 'No', 'A customer distracted the staff.'),
('th--006', 'Bike Stolen at Park Avenue', '2024-05-12 18:00:00', 'Park Avenue, NJ', 'No', 'No', 'Bicycle', 'Minor', 22, 'Male', 'Student', 'No', 'Yes', 'Yes', 'The bike was left unlocked.'),
('th--007', 'ATM Robbery on Main Street', '2024-04-20 22:30:00', 'Main Street, TX', 'Yes', 'Yes', 'Cash', 'Critical', 41, 'Male', 'Accountant', 'Yes', 'No', 'No', 'The suspect used a weapon to threaten the victim.'),
('th--008', 'Pickpocketing at Train Station', '2024-03-11 08:45:00', 'Train Station, NY', 'No', 'No', 'Wallet, ID Cards', 'Minor', 29, 'Female', 'Nurse', 'No', 'No', 'Yes', 'Crowded station made it easier for the thief.'),
('th--009', 'Store Robbery at Maple Plaza', '2024-02-16 21:00:00', 'Maple Plaza, IL', 'Yes', 'Yes', 'Cash, Electronics', 'Serious', 38, 'Male', 'Manager', 'Yes', 'Yes', 'No', 'Suspect used a firearm during the robbery.'),
('th--010', 'Handbag Theft at Riverwalk', '2024-01-05 16:00:00', 'Riverwalk, MA', 'No', 'No', 'Handbag, Sunglasses', 'Moderate', 34, 'Female', 'HR Manager', 'No', 'Yes', 'No', 'The thief escaped on a bicycle.'),
('th--011', 'Home Burglary in Greenfield', '2024-08-08 03:00:00', 'Greenfield, WI', 'No', 'No', 'Electronics, Cash', 'Moderate', 45, 'Female', 'Retired', 'No', 'No', 'No', 'Residents were on vacation during the incident.'),
('th--012', 'Laptop Theft at Library', '2024-09-14 14:45:00', 'City Library, WA', 'No', 'No', 'Laptop, Charger', 'Minor', 19, 'Male', 'Student', 'No', 'No', 'Yes', 'Thief blended in with the crowd.'),
('th--013', 'Bag Snatching near Grocery Store', '2024-10-03 10:30:00', 'Grocery Store, OR', 'No', 'No', 'Grocery Bag, Cash', 'Minor', 50, 'Female', 'Homemaker', 'Yes', 'Yes', 'Yes', 'The incident occurred in broad daylight.'),
('th--014', 'Cash Register Theft at Coffee Shop', '2024-11-20 22:00:00', 'Coffee Shop, CO', 'Yes', 'No', 'Cash', 'Serious', 33, 'Male', 'Barista', 'Yes', 'Yes', 'No', 'The suspect wore a mask to hide identity.'),
('th--015', 'Tool Theft at Construction Site', '2024-07-28 06:30:00', 'Construction Site, PA', 'No', 'No', 'Power Tools', 'Moderate', 39, 'Male', 'Construction Worker', 'No', 'No', 'No', 'The tools were stolen during an overnight break.');

INSERT INTO fraud_reports VALUES
('fr--001', 'Online Credit Card Scam', '2024-10-01 10:00:00', 'Online', 'Credit card fraud', 'Unauthorized transactions on victim\'s credit card', 'Serious', 30, 'Male', 'Freelancer', 'No', 'Yes', 'Victim received phishing email.'),
('fr--002', 'Identity Theft in Bank Account', '2024-09-18 09:45:00', 'Online', 'Identity theft', 'Bank account details stolen using fake website', 'Critical', 40, 'Female', 'Accountant', 'No', 'No', 'Victim noticed only after 2 days.'),
('fr--003', 'Fake Investment Scheme', '2024-08-22 14:30:00', 'Online', 'Financial fraud', 'Victim was scammed into a fake cryptocurrency investment', 'Critical', 35, 'Male', 'Engineer', 'No', 'No', 'Scam website disappeared after funds were transferred.'),
('fr--004', 'Cheque Forgery in Local Bank', '2024-07-15 12:00:00', 'Physical', 'Other', 'Cheque was forged and cashed', 'Serious', 50, 'Female', 'Teacher', 'Yes', 'No', 'Bank is reviewing CCTV footage.'),
('fr--005', 'Phishing Email Fraud', '2024-06-10 08:45:00', 'Online', 'Other', 'Victim\'s credentials were stolen via email link', 'Moderate', 28, 'Male', 'Data Analyst', 'No', 'Yes', 'Fraudulent link resembled a trusted website.'),
('fr--006', 'Online Shopping Scam', '2024-05-05 20:15:00', 'Online', 'Other', 'Victim paid for items but never received them', 'Moderate', 26, 'Female', 'Sales Executive', 'No', 'No', 'Seller blocked victim after receiving payment.'),
('fr--007', 'Ponzi Scheme in Community', '2024-04-18 19:30:00', 'Physical', 'Financial fraud', 'Scam involved promising high returns for investments', 'Critical', 45, 'Male', 'Retired', 'Yes', 'No', 'Multiple people in the community were targeted.'),
('fr--008', 'Credit Card Skimming Incident', '2024-03-11 17:15:00', 'Physical', 'Credit card fraud', 'Card details stolen from ATM skimmer', 'Serious', 31, 'Female', 'Nurse', 'No', 'No', 'Victim noticed unauthorized withdrawals.'),
('fr--009', 'Fake Job Offer Fraud', '2024-02-22 11:00:00', 'Online', 'Other', 'Victim paid upfront fee for a fake job', 'Moderate', 29, 'Male', 'Software Developer', 'No', 'No', 'Victim realized after no response from employer.'),
('fr--010', 'Loan Application Fraud', '2024-01-10 15:45:00', 'Online', 'Identity theft', 'Fraudulent loan was taken using victim\'s name', 'Critical', 42, 'Female', 'HR Manager', 'No', 'No', 'Victim discovered through credit report.'),
('fr--011', 'PayPal Phishing Scam', '2024-07-30 09:30:00', 'Online', 'Other', 'Victim\'s account was accessed and funds transferred', 'Serious', 37, 'Male', 'Marketing Manager', 'No', 'Yes', 'Link mimicked PayPal login page.'),
('fr--012', 'Fraudulent Insurance Claim', '2024-06-19 10:15:00', 'Physical', 'Other', 'Fake documents submitted for insurance money', 'Serious', 52, 'Male', 'Business Owner', 'Yes', 'No', 'Insurance company flagged suspicious documents.'),
('fr--013', 'Online Donation Scam', '2024-05-25 18:00:00', 'Online', 'Other', 'Victim donated to fake charity website', 'Moderate', 34, 'Female', 'Graphic Designer', 'No', 'No', 'Website shut down after several complaints.'),
('fr--014', 'Online Auction Fraud', '2024-09-03 20:00:00', 'Online', 'Financial fraud', 'Winning bid paid but item never received', 'Moderate', 27, 'Male', 'Photographer', 'No', 'Yes', 'Victim was promised a refund but never received it.'),
('fr--015', 'Identity Theft for Mobile Contract', '2024-10-11 16:30:00', 'Online', 'Identity theft', 'Mobile contract opened using victim\'s ID', 'Critical', 39, 'Female', 'Administrator', 'No', 'No', 'Victim found out after receiving overdue bills.');

INSERT INTO sexual_assault_reports VALUES
('sa--001', 'Incident at Local Pub', '2024-10-07 23:30:00', 'Local Pub, NY', 'Stranger', 'Critical', 29, 'Female', 'Bartender', 'Yes', 'No', 'Victim was attacked on her way to the parking lot.', 'The perpetrator ran away before help arrived.'),
('sa--002', 'Assault at University Campus', '2024-09-25 21:00:00', 'University Campus, CA', 'Acquaintance', 'Serious', 21, 'Female', 'Student', 'No', 'Yes', 'The perpetrator was a fellow student.', 'Victim is receiving counseling.'),
('sa--003', 'Incident in Office Parking Lot', '2024-08-30 19:15:00', 'Office Parking Lot, TX', 'Stranger', 'Critical', 35, 'Female', 'Manager', 'Yes', 'No', 'Victim was approached while leaving work.', 'Security footage is being reviewed.'),
('sa--004', 'Assault at Concert Venue', '2024-07-14 23:45:00', 'Concert Venue, FL', 'Stranger', 'Serious', 26, 'Female', 'Photographer', 'Yes', 'Yes', 'The incident occurred during a crowded event.', 'Witnesses are cooperating with the investigation.'),
('sa--005', 'Incident in Apartment Complex', '2024-06-18 22:30:00', 'Apartment Complex, OH', 'Acquaintance', 'Critical', 40, 'Female', 'Nurse', 'No', 'No', 'Victim was attacked by a neighbor.', 'Victim has moved to a safer location.'),
('sa--006', 'Assault at Shopping Mall', '2024-05-10 16:00:00', 'Shopping Mall, WA', 'Stranger', 'Moderate', 22, 'Female', 'Cashier', 'Yes', 'Yes', 'The incident occurred in the restroom.', 'Security guards intervened.'),
('sa--007', 'Incident in Residential Area', '2024-04-08 20:15:00', 'Residential Area, IL', 'Partner', 'Serious', 32, 'Female', 'Teacher', 'No', 'No', 'Victim was attacked by her partner.', 'Case has been filed for domestic violence as well.'),
('sa--008', 'Assault at Public Park', '2024-03-15 18:45:00', 'Public Park, NY', 'Stranger', 'Critical', 28, 'Female', 'Artist', 'Yes', 'No', 'Victim was jogging when attacked.', 'Several witnesses have come forward.'),
('sa--009', 'Incident at Family Gathering', '2024-02-22 19:30:00', 'Family Home, TX', 'Family', 'Critical', 36, 'Female', 'Accountant', 'No', 'No', 'Victim was assaulted by a relative.', 'Victim has filed a restraining order.'),
('sa--010', 'Incident in Parking Garage', '2024-01-12 21:00:00', 'Parking Garage, MA', 'Stranger', 'Critical', 30, 'Female', 'Sales Executive', 'Yes', 'Yes', 'The perpetrator was masked.', 'Police are reviewing CCTV footage.'),
('sa--011', 'Assault at Gym Facility', '2024-09-03 20:15:00', 'Local Gym, CA', 'Acquaintance', 'Serious', 25, 'Female', 'Trainer', 'No', 'No', 'Victim was cornered in the locker room.', 'Management has increased security.'),
('sa--012', 'Incident at Public Library', '2024-07-22 15:30:00', 'Library, CO', 'Stranger', 'Moderate', 19, 'Female', 'Student', 'Yes', 'Yes', 'The perpetrator fled when others intervened.', 'Victim is traumatized but safe.'),
('sa--013', 'Assault in Taxi', '2024-05-30 23:00:00', 'Taxi, NJ', 'Stranger', 'Critical', 27, 'Female', 'Writer', 'No', 'No', 'The driver attacked the victim during the ride.', 'The taxi company is cooperating with authorities.'),
('sa--014', 'Incident in University Dormitory', '2024-04-12 22:45:00', 'Dormitory, NY', 'Acquaintance', 'Serious', 20, 'Female', 'Student', 'No', 'Yes', 'The victim knew the perpetrator from classes.', 'University has launched an internal investigation.'),
('sa--015', 'Assault at Beach Party', '2024-03-08 21:30:00', 'Beach, FL', 'Stranger', 'Moderate', 24, 'Female', 'Barista', 'Yes', 'Yes', 'The victim was intoxicated during the incident.', 'Event organizers have provided witness details.');

INSERT INTO domestic_violence_reports VALUES
('da--001', 'Dispute in Oakwood Apartments', '2024-09-15 20:00:00', 'Oakwood Apartments, IL', 'Serious', 'Physical', 'Partner', 32, 'Female', 'Nurse', 'Yes', 'No', 'Victim reported physical injuries.', 'Yes', 'Victim has filed restraining order.'),
('da--002', 'Violence in Smith Residence', '2024-08-29 22:30:00', 'Smith Residence, FL', 'Critical', 'Emotional', 'Family', 45, 'Male', 'Unemployed', 'No', 'No', 'Victim is mentally distressed.', 'No', 'Police had to intervene to stop the violence.'),
('da--003', 'Incident in Elm Street Residence', '2024-07-20 18:45:00', 'Elm Street, TX', 'Moderate', 'Verbal', 'Partner', 28, 'Female', 'Teacher', 'Yes', 'Yes', 'Victim faced prolonged verbal abuse.', 'No', 'Neighbors reported frequent arguments.'),
('da--004', 'Dispute in University Campus Dormitory', '2024-06-18 23:30:00', 'University Campus, CA', 'Serious', 'Physical', 'Partner', 21, 'Male', 'Student', 'No', 'Yes', 'Victim reported injuries from a physical altercation.', 'No', 'Campus police handled the case.'),
('da--005', 'Domestic Abuse in Central Park Residence', '2024-05-10 21:00:00', 'Central Park, NY', 'Critical', 'Physical', 'Family', 35, 'Female', 'Banker', 'No', 'No', 'Victim suffered broken ribs.', 'Yes', 'Case was filed by the victim\'s sister.'),
('da--006', 'Violence in Public Park Apartments', '2024-04-15 19:30:00', 'Public Park, NY', 'Moderate', 'Emotional', 'Partner', 29, 'Female', 'Retail Worker', 'Yes', 'No', 'Victim was emotionally distressed.', 'No', 'Social services are involved.'),
('da--007', 'Conflict in Apartment Complex', '2024-03-11 20:15:00', 'Apartment Complex, OH', 'Serious', 'Verbal', 'Partner', 40, 'Female', 'Sales Manager', 'No', 'Yes', 'Victim faced threatening behavior.', 'No', 'Perpetrator is under investigation.'),
('da--008', 'Dispute in Downtown Mall Residence', '2024-02-22 22:00:00', 'Downtown Mall, NY', 'Critical', 'Physical', 'Partner', 38, 'Male', 'Chef', 'No', 'No', 'Victim reported being physically harmed.', 'Yes', 'Witnessed by mall security guards.'),
('da--009', 'Incident in Residential Area', '2024-01-12 17:45:00', 'Residential Area, IL', 'Serious', 'Physical', 'Family', 50, 'Female', 'Retired', 'Yes', 'No', 'Victim was attacked by an estranged son.', 'Yes', 'Neighbors intervened to prevent further harm.'),
('da--010', 'Dispute at Oakwood Apartments', '2024-09-12 20:45:00', 'Oakwood Apartments, IL', 'Moderate', 'Emotional', 'Partner', 27, 'Male', 'Marketing Manager', 'No', 'Yes', 'Victim reported constant emotional abuse.', 'No', 'Therapy sessions have been recommended.'),
('da--011', 'Conflict in Elm Street Home', '2024-08-15 19:30:00', 'Elm Street, TX', 'Critical', 'Physical', 'Family', 34, 'Female', 'Social Worker', 'Yes', 'No', 'Victim suffered visible injuries.', 'Yes', 'Victim is under hospital care.'),
('da--012', 'Dispute in University Campus Housing', '2024-07-20 18:00:00', 'University Campus, CA', 'Serious', 'Physical', 'Partner', 23, 'Female', 'Graduate Student', 'No', 'No', 'Victim reported multiple incidents of abuse.', 'No', 'University authorities have initiated action.'),
('da--013', 'Incident at Library Complex', '2024-06-18 20:30:00', 'Library, CO', 'Moderate', 'Verbal', 'Partner', 30, 'Male', 'Architect', 'Yes', 'Yes', 'Victim faced verbal threats.', 'No', 'Library staff provided witness statements.'),
('da--014', 'Conflict in Public Park Neighborhood', '2024-05-10 21:30:00', 'Public Park, NY', 'Critical', 'Emotional', 'Family', 42, 'Male', 'Construction Worker', 'No', 'No', 'Victim was mentally and physically distressed.', 'Yes', 'Police arrived after a neighbor\'s call.'),
('da--015', 'Dispute at Central Park Apartments', '2024-04-15 22:15:00', 'Central Park, NY', 'Serious', 'Physical', 'Partner', 39, 'Female', 'Bank Teller', 'No', 'No', 'Victim reported years of abuse.', 'No', 'Perpetrator was taken into custody.');

INSERT INTO drug_offense_reports VALUES
('dg--001', 'Drug Trafficking in Industrial Area', '2024-09-01 14:30:00', 'Industrial Area, TX', 'Cocaine', 'Drug deal busted by police.', 'Critical', 37, 'Male', 'Construction Worker', 'Yes', 'Yes', 15.5, 'Two suspects arrested.'),
('dg--002', 'Possession of Marijuana at College Dorm', '2024-10-11 22:00:00', 'College Dorm, OH', 'Marijuana', 'Student caught during a routine check.', 'Moderate', 20, 'Male', 'Student', 'No', 'Yes', 1.2, 'Student has no prior offenses.'),
('dg--003', 'Drug Bust in Central Park', '2024-08-15 18:00:00', 'Central Park, NY', 'Heroin', 'Police found hidden stash in bushes.', 'Serious', 25, 'Female', 'Unemployed', 'Yes', 'No', 7.8, 'Operation was part of a larger crackdown.'),
('dg--004', 'Overdose Incident at Oakwood Apartments', '2024-07-20 02:30:00', 'Oakwood Apartments, IL', 'Fentanyl', 'Emergency services responded to an overdose.', 'Critical', 32, 'Male', 'Bartender', 'No', 'Yes', 0.5, 'Victim was revived using Narcan.'),
('dg--005', 'Illegal Substance Found in Public Park', '2024-06-30 14:00:00', 'Public Park, NY', 'Methamphetamine', 'Suspicious package discovered by jogger.', 'Serious', 42, 'Male', 'Teacher', 'Yes', 'No', 10.0, 'Police are investigating its source.'),
('dg--006', 'Cocaine Trafficking in Elm Street Residence', '2024-05-22 20:15:00', 'Elm Street, TX', 'Cocaine', 'Multiple kilos discovered during a raid.', 'Critical', 45, 'Male', 'Lawyer', 'Yes', 'Yes', 25.0, 'Suspect was taken into custody.'),
('dg--007', 'Meth Lab Discovered in University Campus Dorm', '2024-04-18 19:30:00', 'University Campus, CA', 'Methamphetamine', 'Illegal lab found in student housing.', 'Critical', 22, 'Male', 'Student', 'Yes', 'No', 12.3, 'Lab was dismantled by authorities.'),
('dg--008', 'Possession of LSD in Downtown Mall Parking Lot', '2024-03-10 23:45:00', 'Downtown Mall, NY', 'LSD', 'Suspect was searched during a routine patrol.', 'Moderate', 29, 'Female', 'Waitress', 'No', 'Yes', 0.3, 'Suspect claimed it was for personal use.'),
('dg--009', 'Drug Exchange in Smith Residence', '2024-02-05 21:00:00', 'Smith Residence, FL', 'Marijuana', 'Neighbors reported unusual activity.', 'Minor', 50, 'Male', 'Retired', 'Yes', 'No', 2.0, 'Suspect denied involvement.'),
('dg--010', 'Synthetic Drugs Found in Residential Area', '2024-01-25 14:20:00', 'Residential Area, IL', 'Synthetic drugs', 'Authorities seized large quantities.', 'Serious', 39, 'Female', 'Accountant', 'No', 'Yes', 18.0, 'Investigation is ongoing.'),
('dg--011', 'Drug Trafficking in Public Park Apartments', '2024-10-05 19:30:00', 'Public Park, NY', 'Ecstasy', 'Authorities intercepted a package delivery.', 'Critical', 33, 'Male', 'Courier', 'Yes', 'No', 3.5, 'Part of a larger trafficking network.'),
('dg--012', 'Possession of Cocaine in Apartment Complex', '2024-09-20 16:45:00', 'Apartment Complex, OH', 'Cocaine', 'Suspect was caught in possession.', 'Serious', 27, 'Female', 'Graphic Designer', 'No', 'Yes', 0.8, 'Suspect cooperated with the investigation.'),
('dg--013', 'Drug Storage in Library Complex', '2024-08-14 11:30:00', 'Library, CO', 'Heroin', 'Hidden stash found in locker.', 'Serious', 26, 'Male', 'Graduate Student', 'No', 'No', 5.0, 'Authorities believe it belonged to a local gang.'),
('dg--014', 'Cannabis Cultivation in Downtown Mall Basement', '2024-07-18 20:00:00', 'Downtown Mall, NY', 'Cannabis', 'Authorities found plants in an illegal grow room.', 'Moderate', 48, 'Male', 'Electrician', 'Yes', 'Yes', 50.0, 'Entire grow operation was shut down.'),
('dg--015', 'Drug Deal Intercepted in University Campus Parking Lot', '2024-06-12 21:30:00', 'University Campus, CA', 'Cocaine', 'Undercover officers arrested suspects.', 'Critical', 30, 'Female', 'Lab Assistant', 'Yes', 'No', 9.2, 'Arrests were part of a sting operation.');

INSERT INTO traffic_accident_reports 
(traffic_id, case_name, time_of_incident, location, injuries, property_damage, alcohol_drugs_involved, details_of_accident, crime_severity, victim_age, victim_gender, victim_occupation, witness, same_day_report, additional_comments) 
VALUES
('ta--001', 'Major Collision on Industrial Avenue', '2024-09-01 08:30:00', 'Industrial Avenue, TX', 'Yes', 'Yes', 'No', 'Two trucks collided head-on.', 'Critical', 45, 'Male', 'Truck Driver', 'Yes', 'No', 'Road was closed for six hours.'),
('ta--002', 'Car Accident near College Crossroads', '2024-10-11 18:45:00', 'College Crossroads, OH', 'No', 'Yes', 'No', 'Student hit a parked car.', 'Minor', 20, 'Female', 'Student', 'No', 'Yes', 'Driver apologized and exchanged insurance.'),
('ta--003', 'Cyclist Hit in Central Park Pathway', '2024-08-15 09:30:00', 'Central Park, NY', 'No', 'Yes', 'No', 'Biker collided with pedestrian.', 'Moderate', 32, 'Female', 'Photographer', 'Yes', 'No', 'Both parties received minor injuries.'),
('ta--004', 'Pile-Up on Oakwood Boulevard', '2024-07-20 07:15:00', 'Oakwood Boulevard, IL', 'Yes', 'Yes', 'No', 'Fog caused a six-car accident.', 'Critical', 38, 'Male', 'Accountant', 'No', 'Yes', 'Several people were hospitalized.'),
('ta--005', 'Hit-and-Run near Public Park Entrance', '2024-06-30 16:20:00', 'Public Park Entrance, NY', 'Yes', 'No', 'Yes', 'Driver fled after hitting a jogger.', 'Serious', 29, 'Female', 'Teacher', 'Yes', 'No', 'Police are searching for the suspect.'),
('ta--006', 'SUV Crash on Elm Street Junction', '2024-05-22 13:45:00', 'Elm Street Junction, TX', 'Yes', 'Yes', 'No', 'Driver lost control at a turn.', 'Serious', 50, 'Male', 'Retired', 'Yes', 'Yes', 'No fatalities reported.'),
('ta--007', 'Bike and Car Collision in University Parking', '2024-04-18 14:30:00', 'University Parking Lot, CA', 'Yes', 'No', 'No', 'Biker hit by reversing car.', 'Moderate', 21, 'Male', 'Student', 'Yes', 'No', 'Biker suffered a broken arm.'),
('ta--008', 'Rear-End Collision in Downtown Mall Garage', '2024-03-10 20:10:00', 'Downtown Mall Garage, NY', 'No', 'Yes', 'No', 'Car rear-ended in parking lot.', 'Minor', 28, 'Female', 'Sales Assistant', 'No', 'Yes', 'Minimal damage to vehicles.'),
('ta--009', 'Vehicle Rollover near Smith Lane', '2024-02-05 19:00:00', 'Smith Lane, FL', 'Yes', 'Yes', 'No', 'SUV rolled over due to speeding.', 'Serious', 40, 'Male', 'Business Owner', 'Yes', 'No', 'Driver was taken to hospital.'),
('ta--010', 'T-Bone Accident in Residential Area', '2024-01-25 12:50:00', 'Residential Street, IL', 'Yes', 'Yes', 'No', 'Car hit from the side at an intersection.', 'Moderate', 35, 'Female', 'Nurse', 'No', 'Yes', 'Both vehicles were severely damaged.'),
('ta--011', 'Motorcycle Skids on Public Park Road', '2024-10-05 15:30:00', 'Public Park Road, NY', 'No', 'Yes', 'No', 'Motorcycle skidded on wet surface.', 'Minor', 26, 'Male', 'Courier', 'Yes', 'No', 'Rider suffered minor abrasions.'),
('ta--012', 'Head-On Collision in Apartment Driveway', '2024-09-20 22:00:00', 'Apartment Driveway, OH', 'Yes', 'Yes', 'No', 'Car and SUV collided at night.', 'Serious', 44, 'Male', 'Teacher', 'No', 'Yes', 'Driver fatigue was suspected.'),
('ta--013', 'Pedestrian Hit in Library Parking Area', '2024-08-14 10:15:00', 'Library Parking, CO', 'No', 'Yes', 'No', 'Car reversed into pedestrian.', 'Moderate', 55, 'Female', 'Retired', 'Yes', 'No', 'Pedestrian was treated for a sprained ankle.'),
('ta--014', 'Minor Crash in Downtown Mall Basement', '2024-07-18 09:40:00', 'Downtown Mall Basement, NY', 'No', 'No', 'No', 'Car scraped another while parking.', 'Minor', 47, 'Male', 'Electrician', 'Yes', 'Yes', 'No injuries reported.'),
('ta--015', 'Two-Car Collision in University Drive', '2024-06-12 17:20:00', 'University Drive, CA', 'Yes', 'Yes', 'No', 'Cars collided at high speed.', 'Critical', 22, 'Female', 'Research Assistant', 'Yes', 'No', 'Drivers were taken to hospital.');
