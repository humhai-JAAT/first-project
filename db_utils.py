import mysql.connector
import pandas as pd

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="project"
    )

def check_credentials(username, password):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query1 = """SELECT * FROM student_credential WHERE user_name = %s AND user_pass = %s ;"""
    cursor.execute(query1 , (username, password))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result

def get_student_profile(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query2 = """SELECT student_credential.user_name,
                 student_details.roll_number,
                 student_details.address,
                 student_details.contact_number,
                 student_details.mail_id,
                 student_details.class
                 FROM student_details
                 RIGHT JOIN student_credential 
                 ON student_details.roll_number = student_credential.roll_number 
                 WHERE user_name = %s;"""
    cursor.execute(query2, (username,))
    profile = cursor.fetchone()
    cursor.close()
    conn.close()
    return profile

def get_student_marks(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Major Marks
    query_major = """SELECT maths, english, hindi, science, social_science
                     FROM major_marks 
                     JOIN student_credential 
                     ON major_marks.roll_number = student_credential.roll_number
                     WHERE user_name = %s"""
    cursor.execute(query_major, (username,))
    major_marks = pd.DataFrame(cursor.fetchall())
    major_marks["Exam"] = "Major"

    # Unit 1 Marks
    query_unit1 = """SELECT maths, english, hindi, science, social_science
                     FROM unit_1_marks 
                     JOIN student_credential 
                     ON unit_1_marks.roll_number = student_credential.roll_number
                     WHERE user_name = %s"""
    cursor.execute(query_unit1, (username,))
    unit_1_marks = pd.DataFrame(cursor.fetchall())
    unit_1_marks["Exam"] = "Unit 1"

    # Unit 2 Marks
    query_unit2 = """SELECT maths, english, hindi, science, social_science
                     FROM unit_2_marks 
                     JOIN student_credential 
                     ON unit_2_marks.roll_number = student_credential.roll_number
                     WHERE user_name = %s"""
    cursor.execute(query_unit2, (username,))
    unit_2_marks = pd.DataFrame(cursor.fetchall())
    unit_2_marks["Exam"] = "Unit 2"

    # Combine all
    all_marks = pd.concat([unit_1_marks, unit_2_marks, major_marks], ignore_index=True)

    cursor.close()
    conn.close()
    return all_marks


def notification(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query_noti = """SELECT notification.notification
                     FROM notification
                     JOIN student_credential
                     ON notification.roll_number = student_credential.roll_number
                     WHERE student_credential.user_name = %s;"""
    
    cursor.execute(query_noti, (username,))
    notifications = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return notifications
