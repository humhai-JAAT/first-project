import streamlit as st
from db_utils import check_credentials
from tab_profile import show_profile
from tab_marks import show_marks
from tab_graph import show_graph
from chat_bot import chat_bot
from tab_notification import show_notifications
from tab_attendance import show_attendance  # New import
from tab_help_box import show_help_box
from tab_exam_assignment import show_exam_assignments
from tab_library import show_library
from tab_fee import show_fee_tab

def login_page():
    st.title("🔐 Student Login")
    username = st.text_input("Username")
    password = st.text_input("Password", type="password")

    if st.button("Login"):
        if check_credentials(username, password):
            st.session_state.logged_in = True
            st.session_state.username = username
            st.rerun()
        else:
            st.error("❌ Invalid credentials. Please try again.")


def dashboard():
    st.sidebar.title("📋 Navigation")
    selection = st.sidebar.radio("Go to", [
        "👤 Profile", 
        "📄 Marks", 
        "📊 Graph", 
        "📈 Attendance",  # Added Attendance
        "💬 Chat Bot",
        "🔔 Notifications",
        "📦 Help Box",
        "📚 Assignments",
        "📚 Library",
        "💰 Fee Portal"
    ])

    st.title("🎓 Student Dashboard")

    if selection == "👤 Profile":
        show_profile(st.session_state.username)
    elif selection == "📄 Marks":
        show_marks(st.session_state.username)
    elif selection == "📊 Graph":
        show_graph(st.session_state.username)
    elif selection == "📈 Attendance":  # Handle new tab
        show_attendance(st.session_state.username)
    elif selection == "💬 Chat Bot":
        chat_bot()
    elif selection == "🔔 Notifications":
        show_notifications(st.session_state.username)
    elif selection == "📦 Help Box":
        show_help_box()
    elif selection == "📚 Assignments":
        show_exam_assignments(st.session_state.username)
    elif selection == "📚 Library":
        show_library(st.session_state.username)
    elif selection == "💰 Fee Portal":
        show_fee_tab(st.session_state.username)  


    if st.sidebar.button("🚪 Logout"):
        st.session_state.clear()  # Clears all session keys
        st.rerun()  # Refresh the app

# Initialize session state if not already
if 'logged_in' not in st.session_state:
    st.session_state.logged_in = False

# Show dashboard or login based on login status
if st.session_state.logged_in:
    dashboard()
else:
    login_page()
