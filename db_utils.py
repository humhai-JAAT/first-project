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

def get_student_marks(username, selected_sems):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    all_marks = []

    for sem in selected_sems:
        sem_num = sem.split()[-1]  # Extract number from "Semester X"

        table_prefix = f"sem_{sem_num}"

        for table_suffix, exam_label in [
            ("unit_1_marks", "Unit 1"),
            ("unit_2_marks", "Unit 2"),
            ("major_marks", "Major")
        ]:
            table_name = f"{table_prefix}_{table_suffix}"

            query = f"""
                SELECT maths, english, hindi, science, social_science
                FROM {table_name}
                JOIN student_credential 
                ON {table_name}.roll_number = student_credential.roll_number
                WHERE user_name = %s
            """
            try:
                cursor.execute(query, (username,))
                data = cursor.fetchall()
                if data:
                    df = pd.DataFrame(data)
                    df["Exam"] = f"{exam_label} (Sem {sem_num})"
                    all_marks.append(df)
            except Exception:
                # Table might not exist, skip it
                continue

    cursor.close()
    conn.close()

    return pd.concat(all_marks, ignore_index=True) if all_marks else pd.DataFrame()



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

def get_student_attendance(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = (
        """SELECT subject, date, status 
            FROM subject_attendance 
            JOIN student_credential 
            ON subject_attendance.roll_number = student_credential.roll_number 
            WHERE student_credential.user_name = %s 
            ORDER BY date DESC;"""
    )

    cursor.execute(query, (username,))
    attendance_records = cursor.fetchall()

    cursor.close()
    conn.close()

    return pd.DataFrame(attendance_records)

def get_all_students_attendance():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT student_credential.user_name, subject_attendance.subject, subject_attendance.date, subject_attendance.status
                 FROM subject_attendance
                 JOIN student_credential ON subject_attendance.roll_number = student_credential.roll_number; """
    cursor.execute(query)
    records = cursor.fetchall()

    cursor.close()
    conn.close()

    return pd.DataFrame(records)

def get_student_exams(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT exam_name, exam_date, subject
                FROM exam_schedule
                JOIN student_credential
                ON exam_schedule.roll_number = student_credential.roll_number
                WHERE student_credential.user_name = %s
                ORDER BY exam_date ASC;"""
    
    cursor.execute(query, (username,))
    exams = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return pd.DataFrame(exams)

def get_student_assignments(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT assignment_id, assignment_name, due_date, submitted
                 FROM assignments
                 JOIN student_credential
                 ON assignments.roll_number = student_credential.roll_number
                 WHERE student_credential.user_name = %s
                 ORDER BY due_date ASC;"""
    
    cursor.execute(query, (username,))
    assignments = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return pd.DataFrame(assignments)

def submit_assignment(username, assignment_id, file):
    # Save the assignment file (file handling depends on your setup, e.g., save to the database or filesystem)
    file_path = f"assignments/{username}/{assignment_id}/{file.name}"
    with open(file_path, "wb") as f:
        f.write(file.getbuffer())

    # Update database to mark assignment as submitted
    conn = get_db_connection()
    cursor = conn.cursor()
    
    query = """UPDATE assignments
               SET submitted = 1, submission_date = NOW(), file_path = %s
               WHERE assignment_id = %s AND roll_number = (SELECT roll_number FROM student_credential WHERE user_name = %s);"""
    
    cursor.execute(query, (file_path, assignment_id, username))
    conn.commit()
    
    cursor.close()
    conn.close()

def get_exam_assignments(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT a.assignment_id, a.assignment_name, a.subject, a.due_date, a.submitted, a.submission_date, a.file_path
               FROM assignments a
               JOIN student_credential s ON a.roll_number = s.roll_number
               WHERE s.user_name = %s
               ORDER BY a.due_date ASC"""
    cursor.execute(query, (username,))
    records = cursor.fetchall()

    cursor.close()
    conn.close()

    return pd.DataFrame(records)

def get_fee_status(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT s.roll_number, f.fee_type, f.total_amount, f.paid_amount, (f.total_amount - f.paid_amount) AS due_amount, f.due_date
                 FROM student_fees f
                 JOIN student_credential s ON f.roll_number = s.roll_number
                 WHERE s.user_name = %s; """
    cursor.execute(query, (username,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return pd.DataFrame(result)


def get_payment_history(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT p.payment_id, p.roll_number, p.payment_date, p.amount, p.method, p.reference_id
                 FROM fee_payments p
                 JOIN student_credential s ON p.roll_number = s.roll_number
                 WHERE s.user_name = %s
                 ORDER BY p.payment_date DESC;"""
    cursor.execute(query, (username,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return pd.DataFrame(result)



