import streamlit as st
import pandas as pd
from db_utils import get_db_connection

def fetch_available_books():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM books WHERE available_copies > 0;")
    books = cursor.fetchall()
    cursor.close()
    conn.close()
    return pd.DataFrame(books)

def fetch_my_books(username):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT b.title, b.author, bb.borrow_date, bb.due_date, bb.return_date
        FROM borrowed_books bb
        JOIN books b ON bb.book_id = b.book_id
        JOIN student_credential s ON bb.roll_number = s.roll_number
        WHERE s.user_name = %s
        ORDER BY bb.borrow_date DESC;
    """
    cursor.execute(query, (username,))
    my_books = cursor.fetchall()
    cursor.close()
    conn.close()
    return pd.DataFrame(my_books)

def borrow_book(username, book_id):
    from datetime import datetime, timedelta
    conn = get_db_connection()
    cursor = conn.cursor()

    # Get roll_number
    cursor.execute("SELECT roll_number FROM student_credential WHERE user_name = %s", (username,))
    roll = cursor.fetchone()[0]

    borrow_date = datetime.now().date()
    due_date = borrow_date + timedelta(days=14)

    # Insert into borrowed_books
    cursor.execute("""
        INSERT INTO borrowed_books (roll_number, book_id, borrow_date, due_date)
        VALUES (%s, %s, %s, %s)
    """, (roll, book_id, borrow_date, due_date))

    # Decrement book availability
    cursor.execute("UPDATE books SET available_copies = available_copies - 1 WHERE book_id = %s", (book_id,))
    conn.commit()
    cursor.close()
    conn.close()
    st.success("📚 Book borrowed successfully!")

def return_book(username, title):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Get roll_number and book_id
    cursor.execute("""
        SELECT s.roll_number, b.book_id 
        FROM student_credential s 
        JOIN books b ON b.title = %s 
        WHERE s.user_name = %s
    """, (title, username))
    result = cursor.fetchone()
    if not result:
        st.error("❌ Invalid book or user.")
        return

    roll, book_id = result

    # Mark as returned and update inventory
    cursor.execute("""
        UPDATE borrowed_books 
        SET return_date = NOW() 
        WHERE book_id = %s AND roll_number = %s AND return_date IS NULL
        LIMIT 1
    """, (book_id, roll))

    cursor.execute("UPDATE books SET available_copies = available_copies + 1 WHERE book_id = %s", (book_id,))
    conn.commit()
    cursor.close()
    conn.close()
    st.success("✅ Book returned!")

def show_library(username):
    st.subheader("📚 Library System")

    tab1, tab2 = st.tabs(["🆕 Borrow Book", "📖 My Borrowed Books"])

    with tab1:
        st.markdown("### Available Books")
        books_df = fetch_available_books()

        if not books_df.empty:
            # Search input
            search_query = st.text_input("🔍 Search by Book ID, Title, Author, or Subject")

            # Filter books based on search query
            if search_query:
                search_query_lower = search_query.lower()
                filtered_books = books_df[
                    books_df.apply(lambda row: search_query_lower in str(row['book_id']).lower() 
                                   or search_query_lower in str(row['title']).lower() 
                                   or search_query_lower in str(row['author']).lower() 
                                   or search_query_lower in str(row['subject']).lower(), axis=1)
                ]
            else:
                filtered_books = books_df

            if not filtered_books.empty:
                st.dataframe(filtered_books[["book_id", "title", "author", "subject", "available_copies"]], use_container_width=True)
                selected_book_id = st.selectbox("Choose a book to borrow (by ID):", filtered_books["book_id"])
                if st.button("📥 Borrow"):
                    borrow_book(username, selected_book_id)
            else:
                st.warning("No books match your search.")
        else:
            st.info("No books available at the moment.")

    with tab2:
        st.markdown("### Your Borrowed Books")
        my_books_df = fetch_my_books(username)
        if not my_books_df.empty:
            st.dataframe(my_books_df, use_container_width=True)
            return_title = st.selectbox("Return a book:", my_books_df[my_books_df["return_date"].isna()]["title"].unique())
            if st.button("📤 Return"):
                return_book(username, return_title)
        else:
            st.info("You haven't borrowed any books.")
