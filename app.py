from flask import Flask, request, session, redirect, url_for, render_template, flash, jsonify
import mysql.connector


from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'your_secret_key'

def get_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",  
        password="dbmsproject101", 
        database="crime_reports_db"
    )



db = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="dbmsproject101",
    database="crime_reports_db"
)


@app.route('/')
def home():
    return render_template('index.html')

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])

        try:
            cursor = db.cursor()
            cursor.execute("INSERT INTO users (username, password_hash) VALUES (%s, %s)", (username, password))
            db.commit()
            cursor.close()
            flash('You have successfully signed up!', 'success')
            return redirect(url_for('login'))
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        except Exception as e:
            flash(f'An error occurred: {str(e)}', 'danger')

    return render_template('signup.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        cursor = db.cursor()
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        cursor.close()

        if user:  
            if check_password_hash(user[2], password):  # Assuming user[2] is the password hash
                session['user_id'] = user[0]  
                flash('Login successful!', 'success')
                return redirect(url_for('dashboard'))
            else:
                flash('Error: Invalid password.', 'danger')  # Incorrect password
        else:
            flash('Error: Username not found.', 'danger')  # Username doesn't exist

    return render_template('login.html')


@app.route('/add_report')
def add_report():
    if 'user_id' in session:
        return render_template('add_report.html')
    return redirect(url_for('login'))

@app.route('/murder_form')
def murder_form():
    return render_template('murder_form.html')

@app.route('/assault_form')
def assault_form():
    return render_template('assault_form.html')

@app.route('/theft_form')
def theft_form():
    return render_template('theft_form.html')

@app.route('/sexual_assault_form')
def sexual_assault_form():
    return render_template('sexual_assault_form.html')

@app.route('/domestic_violence_form')
def domestic_violence_form():
    return render_template('domestic_violence_form.html')

@app.route('/drug_offense_form')
def drug_offense_form():
    return render_template('drug_offense_form.html')

@app.route('/traffic_accidents_form')
def traffic_accidents_form():
    return render_template('traffic_accidents_form.html')



def generate_murder_id():
    connection = get_db_connection()
    cursor = connection.cursor()

   
    cursor.execute("SELECT murder_id FROM murder_reports ORDER BY murder_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()

    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    
    return f"md--{next_num:02}"

@app.route('/submit_murder_report', methods=['POST'])
def submit_murder_report():
    if request.method == 'POST':
        
        murder_id = generate_murder_id()
        
        
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        weapon_used = request.form['weapon_used']
        victim_known = request.form['victim_known']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness_present = request.form['witness_present']
        reported_immediately = request.form['reported_immediately']
        reported_same_day = request.form['reported_same_day']
        details_of_incident = request.form['details_of_incident']
        case_status = request.form['case_status']
        additional_comments = request.form.get('additional_comments')

        
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO murder_reports (murder_id, case_name, time_of_incident, location, weapon_used, 
            victim_known, crime_severity, victim_age, victim_gender, victim_occupation, 
            witness_present, reported_immediately, reported_same_day, details_of_incident, case_status, additional_comments)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (murder_id, case_name, time_of_incident, location, weapon_used, victim_known, 
              crime_severity, victim_age, victim_gender, victim_occupation, witness_present, 
              reported_immediately, reported_same_day, details_of_incident, case_status, additional_comments))
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

def generate_assault_id():
    connection = get_db_connection()
    cursor = connection.cursor()


    cursor.execute("SELECT assault_id FROM assault_reports ORDER BY assault_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()

    
    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    
    return f"as--{next_num:02}"

@app.route('/submit_assault_report', methods=['POST'])
def submit_assault_report():
    if request.method == 'POST':
        # Generate the assault ID automatically
        assault_id = generate_assault_id()
        
        # Collect the rest of the form data
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness_present = request.form['witness_present']
        reported_immediately = request.form['reported_immediately']
        reported_same_day = request.form['reported_same_day']
        type_of_assault = request.form['type_of_assault']
        injuries_reported = request.form['injuries_reported']
        weapon_involved = request.form['weapon_involved']
        details_of_incident = request.form['details_of_incident']
        additional_comments = request.form.get('additional_comments')

        # Insert into the database
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO assault_reports (assault_id, case_name, time_of_incident, location, crime_severity,
            victim_age, victim_gender, victim_occupation, witness_present, reported_immediately,
            reported_same_day, type_of_assault, injuries_reported, weapon_involved, details_of_incident,
            additional_comments)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (assault_id, case_name, time_of_incident, location, crime_severity, victim_age,
              victim_gender, victim_occupation, witness_present, reported_immediately,
              reported_same_day, type_of_assault, injuries_reported, weapon_involved,
              details_of_incident, additional_comments))
        connection.commit()
        cursor.close()
        connection.close()

        # Redirect to the view reports page
        return redirect(url_for('view_reports'))


def generate_theft_id():
    connection = get_db_connection()
    cursor = connection.cursor()

    # Query to get the last theft_id in descending order
    cursor.execute("SELECT theft_id FROM theft_reports ORDER BY theft_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()

    # Extract and increment the number part
    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    # Format the new theft_id as "th--01", "th--02", etc.
    return f"th--{next_num:02}"

@app.route('/submit_theft_report', methods=['POST'])
def submit_theft_report():
    if request.method == 'POST':
        # Generate the theft ID automatically
        theft_id = generate_theft_id()
        
        # Collect the rest of the form data
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        weapon_involved = request.form['weapon_involved']
        robbery_violent = request.form['robbery_violent']
        stolen_items = request.form['stolen_items']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness_present = request.form['witness_present']
        report_immediate = request.form['report_immediate']
        reported_same_day = request.form['reported_same_day']
        additional_comments = request.form.get('additional_comments')

        # Insert into the database
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO theft_reports (theft_id, case_name, time_of_incident, location, weapon_involved, 
                                       robbery_violent, stolen_items, crime_severity, victim_age, victim_gender, 
                                       victim_occupation, witness_present, report_immediate, reported_same_day, 
                                       additional_comments)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (theft_id, case_name, time_of_incident, location, weapon_involved, robbery_violent, stolen_items, 
              crime_severity, victim_age, victim_gender, victim_occupation, witness_present, report_immediate, 
              reported_same_day, additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        # Redirect to the view reports page
        return redirect(url_for('view_reports'))

def generate_fraud_id():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("SELECT fraud_id FROM fraud_reports ORDER BY fraud_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()

    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    return f"fr--{next_num:02}"

@app.route('/submit_fraud_reports', methods=['GET', 'POST'])
def fraud_form():
    if request.method == 'POST':
        # Generate fraud_id automatically
        fraud_id = generate_fraud_id()
        
        # Collect the rest of the form data
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        type_of_fraud = request.form['type_of_fraud']
        details_of_incident = request.form['details_of_incident']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness = request.form['witness']
        reported_same_day = request.form['reported_same_day']
        additional_comments = request.form.get('additional_comments')

        # Insert into the database
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO fraud_reports (fraud_id, case_name, time_of_incident, location, type_of_fraud, 
                                       details_of_incident, crime_severity, victim_age, victim_gender, 
                                       victim_occupation, witness, reported_same_day, additional_comments) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (fraud_id, case_name, time_of_incident, location, type_of_fraud, details_of_incident,
              crime_severity, victim_age, victim_gender, victim_occupation, witness, reported_same_day,
              additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

    return render_template('fraud_form.html')

def generate_sa_id():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("SELECT sa_id FROM sexual_assault_reports ORDER BY sa_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()

    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    return f"sa--{next_num:02}"

@app.route('/submit_sa_report', methods=['GET', 'POST'])
def submit_sa_report():
    if request.method == 'POST':
        # Generate sa_id automatically
        sa_id = generate_sa_id()
        
        # Collect the rest of the form data
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        relationship_to_perpetrator = request.form['relationship_to_perpetrator']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        was_witness = request.form['was_witness']
        reported_same_day = request.form['reported_same_day']
        details_of_incident = request.form['details_of_incident']
        additional_comments = request.form.get('additional_comments')

        # Insert into the database
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO sexual_assault_reports (sa_id, case_name, time_of_incident, location, relationship_to_perpetrator, 
                                                crime_severity, victim_age, victim_gender, victim_occupation, was_witness, 
                                                reported_same_day, details_of_incident, additional_comments) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (sa_id, case_name, time_of_incident, location, relationship_to_perpetrator, crime_severity,
              victim_age, victim_gender, victim_occupation, was_witness, reported_same_day, details_of_incident, 
              additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

    return render_template('sa_form.html')

def generate_da_id():
    connection = get_db_connection()
    cursor = connection.cursor()
    
    cursor.execute("SELECT da_id FROM domestic_violence_reports ORDER BY da_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()
    
    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    return f"da--{next_num:02}"

@app.route('/submit_dv_report', methods=['GET', 'POST'])
def submit_dv_report():
    if request.method == 'POST':
        da_id = generate_da_id()
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        crime_severity = request.form['crime_severity']
        type_of_abuse = request.form['type_of_abuse']
        relationship_to_perpetrator = request.form['relationship_to_perpetrator']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness = request.form['witness']
        reported_same_day = request.form['reported_same_day']
        details_of_incident = request.form['details_of_incident']
        victim_previously_harmed = request.form['victim_previously_harmed']
        additional_comments = request.form.get('additional_comments')

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO domestic_violence_reports (da_id, case_name, time_of_incident, location, 
            crime_severity, type_of_abuse, relationship_to_perpetrator, victim_age, victim_gender, 
            victim_occupation, witness, reported_same_day, details_of_incident, victim_previously_harmed, 
            additional_comments) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (da_id, case_name, time_of_incident, location, crime_severity, type_of_abuse, relationship_to_perpetrator,
              victim_age, victim_gender, victim_occupation, witness, reported_same_day, details_of_incident, 
              victim_previously_harmed, additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

    return render_template('domestic_violence_form.html')
def generate_drug_id():
    connection = get_db_connection()
    cursor = connection.cursor()
    
    cursor.execute("SELECT drug_id FROM drug_offense_reports ORDER BY drug_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()
    
    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    return f"dg--{next_num:02}"

@app.route('/submit_drug_offense_report', methods=['GET', 'POST'])
def submit_drug_offense_report():
    if request.method == 'POST':
        drug_id = generate_drug_id()
        case_name = request.form['case_name']
        incident_time = request.form['incident_time']
        location = request.form['location']
        drug_type = request.form['drug_type']
        details = request.form['details']
        severity = request.form['severity']
        criminal_age = request.form['criminal_age']
        criminal_gender = request.form['criminal_gender']
        criminal_occupation = request.form['criminal_occupation']
        witness = request.form['witness']
        reported_same_day = request.form['reported_same_day']
        quantity_seized = request.form['quantity_seized'] if request.form['quantity_seized'] else None
        additional_comments = request.form.get('additional_comments')

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO drug_offense_reports (drug_id, case_name, incident_time, location, drug_type, details, severity, 
            criminal_age, criminal_gender, criminal_occupation, witness, reported_same_day, quantity_seized, 
            additional_comments) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (drug_id, case_name, incident_time, location, drug_type, details, severity, criminal_age, criminal_gender, 
              criminal_occupation, witness, reported_same_day, quantity_seized, additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

    return render_template('drug_offense_form.html')

def generate_traffic_id():
    connection = get_db_connection()
    cursor = connection.cursor()
    
    cursor.execute("SELECT traffic_id FROM traffic_accident_reports ORDER BY traffic_id DESC LIMIT 1")
    last_id_row = cursor.fetchone()
    
    if last_id_row:
        last_id = last_id_row[0]
        last_num = int(last_id.split('--')[1])
        next_num = last_num + 1
    else:
        next_num = 1

    cursor.close()
    connection.close()

    return f"tr--{next_num:02}"

@app.route('/submit_traffic_accident_report', methods=['GET', 'POST'])
def submit_traffic_accident_report():
    if request.method == 'POST':
        traffic_id = generate_traffic_id()
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        injuries = request.form['injuries']
        property_damage = request.form['property_damage']
        alcohol_drugs_involved = request.form['alcohol_drugs_involved']
        details_of_accident = request.form['details_of_accident']
        crime_severity = request.form['crime_severity']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness = request.form['witness']
        same_day_report = request.form['same_day_report']
        additional_comments = request.form.get('additional_comments')

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO traffic_accident_reports (traffic_id, case_name, time_of_incident, location, injuries, 
            property_damage, alcohol_drugs_involved, details_of_accident, crime_severity, victim_age, victim_gender, 
            victim_occupation, witness, same_day_report, additional_comments) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (traffic_id, case_name, time_of_incident, location, injuries, property_damage, alcohol_drugs_involved, 
              details_of_accident, crime_severity, victim_age, victim_gender, victim_occupation, witness, same_day_report, 
              additional_comments))
        
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('view_reports'))

    return render_template('traffic_accident_form.html')



@app.route('/view_reports', methods=['GET'])
def view_reports():
    connection = get_db_connection()
    cursor = connection.cursor()

    search_query = request.args.get('search', '')

    
    if search_query:
        search_query = f"%{search_query}%"
        
        
        cursor.execute("""
            SELECT murder_id, case_name FROM murder_reports 
            WHERE murder_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        murder_reports = cursor.fetchall()

        cursor.execute("""
            SELECT assault_id, case_name FROM assault_reports 
            WHERE assault_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        assault_reports = cursor.fetchall()

        cursor.execute("""
            SELECT theft_id, case_name FROM theft_reports 
            WHERE theft_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        theft_reports = cursor.fetchall()

        cursor.execute("""
            SELECT fraud_id, case_name FROM fraud_reports 
            WHERE fraud_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        fraud_reports = cursor.fetchall()

        cursor.execute("""
            SELECT sa_id, case_name FROM sexual_assault_reports 
            WHERE sa_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        sa_reports = cursor.fetchall()

        cursor.execute("""
            SELECT da_id, case_name FROM domestic_violence_reports 
            WHERE da_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        dv_reports = cursor.fetchall()

        cursor.execute("""
            SELECT drug_id, case_name FROM drug_offense_reports 
            WHERE drug_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        drug_reports = cursor.fetchall()

        cursor.execute("""
            SELECT traffic_id, case_name FROM traffic_accident_reports 
            WHERE traffic_id LIKE %s OR case_name LIKE %s
        """, (search_query, search_query))
        traffic_reports = cursor.fetchall()

    else:
        # Fetch all reports if no search query is present
        cursor.execute("SELECT murder_id, case_name FROM murder_reports")
        murder_reports = cursor.fetchall()

        cursor.execute("SELECT assault_id, case_name FROM assault_reports")
        assault_reports = cursor.fetchall()

        cursor.execute("SELECT theft_id, case_name FROM theft_reports")
        theft_reports = cursor.fetchall()

        cursor.execute("SELECT fraud_id, case_name FROM fraud_reports")
        fraud_reports = cursor.fetchall()

        cursor.execute("SELECT sa_id, case_name FROM sexual_assault_reports")
        sa_reports = cursor.fetchall()

        cursor.execute("SELECT da_id, case_name FROM domestic_violence_reports")
        dv_reports = cursor.fetchall()

        cursor.execute("SELECT drug_id, case_name FROM drug_offense_reports")
        drug_reports = cursor.fetchall()

        cursor.execute("SELECT traffic_id, case_name FROM traffic_accident_reports")
        traffic_reports = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template(
        'view_reports.html',
        murder_reports=murder_reports,
        assault_reports=assault_reports,
        theft_reports=theft_reports,
        fraud_reports=fraud_reports,
        sa_reports=sa_reports,
        dv_reports=dv_reports,
        drug_reports=drug_reports,
        traffic_reports=traffic_reports
    )



@app.route('/murder_details/<murder_id>')
def murder_details(murder_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM murder_reports WHERE murder_id = %s", (murder_id,))
    report = cursor.fetchone()
    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('murder_details.html', report=report)

@app.route('/assault_details/<assault_id>')
def assault_details(assault_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM assault_reports WHERE assault_id = %s", (assault_id,))
    report = cursor.fetchone()
    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('assault_details.html', report=report)

@app.route('/theft_details/<theft_id>')
def theft_details(theft_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM theft_reports WHERE theft_id = %s", (theft_id,))
    report = cursor.fetchone()
    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('theft_details.html', report=report)

@app.route('/fraud_details/<fraud_id>')
def fraud_details(fraud_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    
    cursor.execute("SELECT * FROM fraud_reports WHERE fraud_id = %s", (fraud_id,))
    report = cursor.fetchone()
    
    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('fraud_details.html', report=report)

@app.route('/sa_details/<sa_id>')
def sa_details(sa_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    
    cursor.execute("SELECT * FROM sexual_assault_reports WHERE sa_id = %s", (sa_id,))
    report = cursor.fetchone()
    
    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('sa_details.html', report=report)

@app.route('/dv_details/<da_id>')
def dv_details(da_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetching details for the domestic violence report by ID
    cursor.execute("SELECT * FROM domestic_violence_reports WHERE da_id = %s", (da_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404  

    return render_template('dv_details.html', report=report)

@app.route('/drug_details/<drug_id>')
def drug_details(drug_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetching details for the drug offense report by ID
    cursor.execute("SELECT * FROM drug_offense_reports WHERE drug_id = %s", (drug_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    return render_template('drug_offense_details.html', report=report)


@app.route('/traffic_details/<traffic_id>')
def traffic_details(traffic_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetching details for the traffic accident report by ID
    cursor.execute("SELECT * FROM traffic_accident_reports WHERE traffic_id = %s", (traffic_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    return render_template('traffic_accident_details.html', report=report)

@app.route('/edit_murder/<murder_id>')
def edit_murder(murder_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    
    # Fetch the existing data for the murder report
    cursor.execute("SELECT * FROM murder_reports WHERE murder_id = %s", (murder_id,))
    report = cursor.fetchone()
    
    cursor.close()
    connection.close()
    
    if report is None:
        return "Report not found", 404
    
    return render_template('edit_murder.html', report=report, murder_id=murder_id)

@app.route('/update_murder/<murder_id>', methods=['POST'])
def update_murder(murder_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    weapon_used = request.form['weapon_used']
    victim_known = request.form['victim_known']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    witness_present = request.form['witness_present']
    reported_immediately = request.form['reported_immediately']  # Updated to match form
    reported_same_day = request.form['reported_same_day']
    details_of_incident = request.form['details_of_incident']
    case_status = request.form['case_status']
    additional_comments = request.form['additional_comments']

    # Update the murder report in the database
    cursor.execute("""
        UPDATE murder_reports
        SET case_name = %s, time_of_incident = %s, location = %s, weapon_used = %s, victim_known = %s,
            crime_severity = %s, victim_age = %s, victim_gender = %s, victim_occupation = %s, witness_present = %s,
            reported_immediately = %s, reported_same_day = %s, details_of_incident = %s, case_status = %s, additional_comments = %s
        WHERE murder_id = %s
    """, (case_name, time_of_incident, location, weapon_used, victim_known, crime_severity, victim_age, victim_gender,
          victim_occupation, witness_present, reported_immediately, reported_same_day, details_of_incident, case_status, additional_comments, murder_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('murder_details', murder_id=murder_id))

@app.route('/edit_assault/<assault_id>')
def edit_assault(assault_id):
    connection = get_db_connection()
    cursor = connection.cursor()
    
    # Fetch the existing data for the assault report
    cursor.execute("SELECT * FROM assault_reports WHERE assault_id = %s", (assault_id,))
    report = cursor.fetchone()
    
    cursor.close()
    connection.close()
    
    if report is None:
        return "Report not found", 404
    
    return render_template('edit_assault.html', report=report, assault_id=assault_id)

@app.route('/update_assault/<assault_id>', methods=['POST'])
def update_assault(assault_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    witness_present = request.form['witness_present']
    reported_immediately = request.form['reported_immediately']
    reported_same_day = request.form['reported_same_day']
    type_of_assault = request.form['type_of_assault']
    injuries_reported = request.form['injuries_reported']
    weapon_involved = request.form['weapon_involved']
    details_of_incident = request.form['details_of_incident']
    additional_comments = request.form['additional_comments']

    # Update the assault report in the database
    cursor.execute("""
        UPDATE assault_reports
        SET case_name = %s, time_of_incident = %s, location = %s, crime_severity = %s, victim_age = %s, victim_gender = %s,
            victim_occupation = %s, witness_present = %s, reported_immediately = %s, reported_same_day = %s, 
            type_of_assault = %s, injuries_reported = %s, weapon_involved = %s, details_of_incident = %s, additional_comments = %s
        WHERE assault_id = %s
    """, (case_name, time_of_incident, location, crime_severity, victim_age, victim_gender, victim_occupation, 
          witness_present, reported_immediately, reported_same_day, type_of_assault, injuries_reported, weapon_involved, 
          details_of_incident, additional_comments, assault_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('assault_details', assault_id=assault_id))

@app.route('/edit_theft/<theft_id>')
def edit_theft(theft_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch the existing data for the theft report
    cursor.execute("SELECT * FROM theft_reports WHERE theft_id = %s", (theft_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    return render_template('edit_theft.html', report=report, theft_id=theft_id)

@app.route('/update_theft/<theft_id>', methods=['POST'])
def update_theft(theft_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    weapon_involved = request.form['weapon_involved']
    robbery_violent = request.form['robbery_violent']
    stolen_items = request.form['stolen_items']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    witness_present = request.form['witness_present']
    report_immediate = request.form['report_immediate']
    reported_same_day = request.form['reported_same_day']
    additional_comments = request.form['additional_comments']

    # Update the theft report in the database
    cursor.execute("""
        UPDATE theft_reports
        SET case_name = %s, time_of_incident = %s, location = %s, weapon_involved = %s, robbery_violent = %s,
            stolen_items = %s, crime_severity = %s, victim_age = %s, victim_gender = %s, victim_occupation = %s,
            witness_present = %s, report_immediate = %s, reported_same_day = %s, additional_comments = %s
        WHERE theft_id = %s
    """, (case_name, time_of_incident, location, weapon_involved, robbery_violent, stolen_items, crime_severity, 
          victim_age, victim_gender, victim_occupation, witness_present, report_immediate, reported_same_day, 
          additional_comments, theft_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('theft_details', theft_id=theft_id))

@app.route('/edit_fraud/<fraud_id>')
def edit_fraud(fraud_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch the existing data for the fraud report
    cursor.execute("SELECT * FROM fraud_reports WHERE fraud_id = %s", (fraud_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    return render_template('edit_fraud.html', report=report, fraud_id=fraud_id)

@app.route('/update_fraud/<fraud_id>', methods=['POST'])
def update_fraud(fraud_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    type_of_fraud = request.form['type_of_fraud']
    details_of_incident = request.form['details_of_incident']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    witness = request.form['witness']
    reported_same_day = request.form['reported_same_day']
    additional_comments = request.form['additional_comments']

    # Update the fraud report in the database
    cursor.execute("""
        UPDATE fraud_reports
        SET case_name = %s, time_of_incident = %s, location = %s, type_of_fraud = %s, details_of_incident = %s,
            crime_severity = %s, victim_age = %s, victim_gender = %s, victim_occupation = %s, witness = %s,
            reported_same_day = %s, additional_comments = %s
        WHERE fraud_id = %s
    """, (case_name, time_of_incident, location, type_of_fraud, details_of_incident, crime_severity, victim_age,
          victim_gender, victim_occupation, witness, reported_same_day, additional_comments, fraud_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('fraud_details', fraud_id=fraud_id))

@app.route('/edit_sa/<sa_id>')
def edit_sa(sa_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch the existing data for the sexual assault report
    cursor.execute("SELECT * FROM sexual_assault_reports WHERE sa_id = %s", (sa_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    return render_template('edit_sa.html', report=report, sa_id=sa_id)

@app.route('/update_sa/<sa_id>', methods=['POST'])
def update_sa(sa_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from the form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    relationship_to_perpetrator = request.form['relationship_to_perpetrator']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    was_witness = request.form['was_witness']
    reported_same_day = request.form['reported_same_day']
    details_of_incident = request.form['details_of_incident']
    additional_comments = request.form['additional_comments']

    # Update the sexual assault report in the database
    cursor.execute("""
        UPDATE sexual_assault_reports
        SET case_name = %s, time_of_incident = %s, location = %s, relationship_to_perpetrator = %s, 
            crime_severity = %s, victim_age = %s, victim_gender = %s, victim_occupation = %s,
            was_witness = %s, reported_same_day = %s, details_of_incident = %s, additional_comments = %s
        WHERE sa_id = %s
    """, (case_name, time_of_incident, location, relationship_to_perpetrator, crime_severity, victim_age, victim_gender,
          victim_occupation, was_witness, reported_same_day, details_of_incident, additional_comments, sa_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('sa_details', sa_id=sa_id))

@app.route('/edit_dv/<da_id>', methods=['GET', 'POST'])
def edit_dv(da_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    if request.method == 'POST':
        # Get the updated form data
        case_name = request.form['case_name']
        time_of_incident = request.form['time_of_incident']
        location = request.form['location']
        crime_severity = request.form['crime_severity']
        type_of_abuse = request.form['type_of_abuse']
        relationship_to_perpetrator = request.form['relationship_to_perpetrator']
        victim_age = request.form['victim_age']
        victim_gender = request.form['victim_gender']
        victim_occupation = request.form['victim_occupation']
        witness = request.form['witness']
        reported_same_day = request.form['reported_same_day']
        details_of_incident = request.form['details_of_incident']
        victim_previously_harmed = request.form['victim_previously_harmed']
        additional_comments = request.form['additional_comments']

        # Update the database record
        cursor.execute(
            """
            UPDATE domestic_violence_reports
            SET case_name = %s, time_of_incident = %s, location = %s, crime_severity = %s, 
                type_of_abuse = %s, relationship_to_perpetrator = %s, victim_age = %s, victim_gender = %s, 
                victim_occupation = %s, witness = %s, reported_same_day = %s, details_of_incident = %s, 
                victim_previously_harmed = %s, additional_comments = %s
            WHERE da_id = %s
            """,
            (
                case_name, time_of_incident, location, crime_severity, type_of_abuse, relationship_to_perpetrator,
                victim_age, victim_gender, victim_occupation, witness, reported_same_day, details_of_incident,
                victim_previously_harmed, additional_comments, da_id
            )
        )
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('dv_details', da_id=da_id))

    # Fetch the current report details for pre-filling the form
    cursor.execute("SELECT * FROM domestic_violence_reports WHERE da_id = %s", (da_id,))
    report = cursor.fetchone()
    cursor.close()
    connection.close()

    return render_template('edit_dv.html', report=report)

@app.route('/edit_drug_offense/<drug_id>', methods=['GET', 'POST'])
def edit_drug_offense(drug_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    if request.method == 'POST':
        # Get the updated form data
        case_name = request.form['case_name']
        incident_time = request.form['incident_time']
        location = request.form['location']
        drug_type = request.form['drug_type']
        details = request.form['details']
        severity = request.form['severity']
        criminal_age = request.form['criminal_age']
        criminal_gender = request.form['criminal_gender']
        criminal_occupation = request.form['criminal_occupation']
        witness = request.form['witness']
        reported_same_day = request.form['reported_same_day']
        quantity_seized = request.form['quantity_seized']
        additional_comments = request.form['additional_comments']

        # Update the database record
        cursor.execute(
            """
            UPDATE drug_offense_reports
            SET case_name = %s, incident_time = %s, location = %s, drug_type = %s, details = %s,
                severity = %s, criminal_age = %s, criminal_gender = %s, criminal_occupation = %s,
                witness = %s, reported_same_day = %s, quantity_seized = %s, additional_comments = %s
            WHERE drug_id = %s
            """,
            (
                case_name, incident_time, location, drug_type, details, severity, criminal_age, criminal_gender,
                criminal_occupation, witness, reported_same_day, quantity_seized, additional_comments, drug_id
            )
        )
        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('drug_details', drug_id=drug_id))

    # Fetch the current report details for pre-filling the form
    cursor.execute("SELECT * FROM drug_offense_reports WHERE drug_id = %s", (drug_id,))
    report = cursor.fetchone()
    cursor.close()
    connection.close()

    return render_template('edit_drug_offense.html', report=report)

@app.route('/edit_traffic_accident/<traffic_id>')
def edit_traffic_accident(traffic_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch the existing data for the traffic accident report
    cursor.execute("SELECT * FROM traffic_accident_reports WHERE traffic_id = %s", (traffic_id,))
    report = cursor.fetchone()

    cursor.close()
    connection.close()

    if report is None:
        return "Report not found", 404

    # Pass the fetched report to the template for editing
    return render_template('edit_traffic_accident.html', report=report, traffic_id=traffic_id)

@app.route('/update_traffic_accident/<traffic_id>', methods=['POST'])
def update_traffic_accident(traffic_id):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get updated data from the form
    case_name = request.form['case_name']
    time_of_incident = request.form['time_of_incident']
    location = request.form['location']
    injuries = request.form['injuries']
    property_damage = request.form['property_damage']
    alcohol_drugs_involved = request.form['alcohol_drugs_involved']
    details_of_accident = request.form['details_of_accident']
    crime_severity = request.form['crime_severity']
    victim_age = request.form['victim_age']
    victim_gender = request.form['victim_gender']
    victim_occupation = request.form['victim_occupation']
    witness = request.form['witness']
    same_day_report = request.form['same_day_report']
    additional_comments = request.form['additional_comments']

    # Update the traffic accident report in the database
    cursor.execute("""
        UPDATE traffic_accident_reports
        SET case_name = %s, time_of_incident = %s, location = %s, injuries = %s,
            property_damage = %s, alcohol_drugs_involved = %s, details_of_accident = %s,
            crime_severity = %s, victim_age = %s, victim_gender = %s,
            victim_occupation = %s, witness = %s, same_day_report = %s,
            additional_comments = %s
        WHERE traffic_id = %s
    """, (case_name, time_of_incident, location, injuries, property_damage,
          alcohol_drugs_involved, details_of_accident, crime_severity, victim_age,
          victim_gender, victim_occupation, witness, same_day_report,
          additional_comments, traffic_id))

    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('traffic_details', traffic_id=traffic_id))

@app.route('/delete_murder/<murder_id>', methods=['POST'])
def delete_murder(murder_id):
    if 'user_id' in session:  # Ensure that the user is logged in
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the murder report
            cursor.execute("DELETE FROM murder_reports WHERE murder_id = %s", (murder_id,))
            connection.commit()
            flash('Murder report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_assault/<assault_id>', methods=['POST'])
def delete_assault(assault_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the assault report
            cursor.execute("DELETE FROM assault_reports WHERE assault_id = %s", (assault_id,))
            connection.commit()
            flash('Assault report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_theft/<theft_id>', methods=['POST'])
def delete_theft(theft_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the theft report
            cursor.execute("DELETE FROM theft_reports WHERE theft_id = %s", (theft_id,))
            connection.commit()
            flash('Theft report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_fraud/<fraud_id>', methods=['POST'])
def delete_fraud(fraud_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the fraud report
            cursor.execute("DELETE FROM fraud_reports WHERE fraud_id = %s", (fraud_id,))
            connection.commit()
            flash('Fraud report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_sa/<sa_id>', methods=['POST'])
def delete_sa(sa_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the sexual assault report
            cursor.execute("DELETE FROM sexual_assault_reports WHERE sa_id = %s", (sa_id,))
            connection.commit()
            flash('Sexual assault report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_dv/<da_id>', methods=['POST'])
def delete_dv(da_id):  # da_id as the parameter
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the domestic violence report using da_id
            cursor.execute("DELETE FROM domestic_violence_reports WHERE da_id = %s", (da_id,))
            connection.commit()
            flash('Domestic violence report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))



@app.route('/delete_drug/<drug_id>', methods=['POST'])
def delete_drug(drug_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the drug offense report
            cursor.execute("DELETE FROM drug_offense_reports WHERE drug_id = %s", (drug_id,))
            connection.commit()
            flash('Drug offense report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))

@app.route('/delete_traffic/<traffic_id>', methods=['POST'])
def delete_traffic(traffic_id):
    if 'user_id' in session:
        try:
            connection = get_db_connection()
            cursor = connection.cursor()
            # Delete the traffic accident report
            cursor.execute("DELETE FROM traffic_accidents_reports WHERE traffic_id = %s", (traffic_id,))
            connection.commit()
            flash('Traffic accident report deleted successfully!', 'success')
        except mysql.connector.Error as err:
            flash(f'Error: {err}', 'danger')
        finally:
            cursor.close()
            connection.close()

    return redirect(url_for('view_reports'))


@app.route('/search', methods=['GET', 'POST'])
def search():
    results = []
    if request.method == 'POST':
        # Existing filters
        crime_severity = request.form.get('crime_severity')
        location = request.form.get('location')
        witness_present = request.form.get('witness_present')

        # New filters
        start_age = request.form.get('start_age')
        end_age = request.form.get('end_age')
        same_day_report = request.form.get('same_day_report')
        weapon_used = request.form.get('weapon_used')
        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')

        filters = []

        # Base query with UNION ALL
        query = """
        SELECT 'murder' AS table_name, case_name, time_of_incident, location, crime_severity, witness_present, victim_age, reported_same_day, weapon_used
        FROM murder_reports
        UNION ALL
        SELECT 'assault', case_name, time_of_incident, location, crime_severity, witness_present, victim_age, reported_same_day, NULL AS weapon_used
        FROM assault_reports
        UNION ALL
        SELECT 'theft', case_name, time_of_incident, location, crime_severity, witness_present, victim_age, reported_same_day, weapon_involved AS weapon_used
        FROM theft_reports
        UNION ALL
        SELECT 'fraud', case_name, time_of_incident, location, crime_severity, 'N/A' AS witness_present, victim_age, reported_same_day, NULL AS weapon_used
        FROM fraud_reports
        UNION ALL
        SELECT 'sexual assault', case_name, time_of_incident, location, crime_severity, was_witness AS witness_present, victim_age, reported_same_day, NULL AS weapon_used
        FROM sexual_assault_reports
        UNION ALL
        SELECT 'domestic violence', case_name, time_of_incident, location, crime_severity, witness, victim_age, reported_same_day, NULL AS weapon_used
        FROM domestic_violence_reports
        UNION ALL
        SELECT 'drug offense', case_name, incident_time AS time_of_incident, location, severity AS crime_severity, witness, criminal_age AS victim_age, reported_same_day, NULL AS weapon_used
        FROM drug_offense_reports
        UNION ALL
        SELECT 'traffic accident', case_name, time_of_incident, location, crime_severity, witness, victim_age, same_day_report AS reported_same_day, NULL AS weapon_used
        FROM traffic_accident_reports
        """

        # Apply filters
        if crime_severity:
            filters.append(f"crime_severity = '{crime_severity}'")
        if location:
            filters.append(f"location LIKE '%{location}%'")
        if witness_present:
            filters.append(f"witness_present = '{witness_present}'")
        if start_age and end_age:
            filters.append(f"victim_age BETWEEN {start_age} AND {end_age}")
        if same_day_report:
            filters.append(f"reported_same_day = '{same_day_report}'")
        if weapon_used:
            filters.append(f"weapon_used = '{weapon_used}'")
        if start_date and end_date:
            filters.append(f"time_of_incident BETWEEN '{start_date}' AND '{end_date}'")

        # Combine filters into the query
        if filters:
            query = f"SELECT * FROM ({query}) AS combined_reports WHERE " + " AND ".join(filters)

        # Fetch results
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute(query)
        results = cursor.fetchall()
        connection.close()

    return render_template('search.html', results=results)

@app.route("/analytics")
def analytics():
    return render_template('analytics.html')

# Endpoint to fetch analytics
@app.route('/api/analytics', methods=['GET'])
def showanalytics():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Get table name and metric type from query parameters
        table = request.args.get('table')
        metric = request.args.get('metric')

        if not table or not metric:
            return jsonify({"error": "Please provide 'table' and 'metric' query parameters."}), 400

        # Example: Fetching count of reports per crime severity
        if metric == "crime_severity_distribution":
            query = f"SELECT crime_severity, COUNT(*) as count FROM {table} GROUP BY crime_severity"

        # Example: Fetching total cases for a table
        elif metric == "total_cases":
            query = f"SELECT COUNT(*) as total_cases FROM {table}"

        # Example: Fetching average victim age
        elif metric == "average_victim_age":
            query = f"SELECT AVG(victim_age) as average_age FROM {table}"

        else:
            return jsonify({"error": "Unsupported metric."}), 400

        cursor.execute(query)
        results = cursor.fetchall()
        
        return jsonify(results)

    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500

    finally:
        cursor.close()
        conn.close()

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('You have been logged out.', 'success')
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)