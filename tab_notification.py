import streamlit as st
from db_utils import notification  # Ensure this import is present

def show_notifications(username):
    st.subheader("📢 General Notifications")
    
    # Static sample notifications
    sample_notifications = [
        "📝 Unit Test 2 results have been uploaded.",
        "📅 Parent-teacher meeting on 12th May at 10:00 AM.",
        "🎉 Annual function scheduled for 25th May.",
        "📢 Submit assignment on 'Climate Change' by 15th May.",
    ]

    for note in sample_notifications:
        st.markdown(note)

    st.markdown("---")
    st.subheader("🔔 Your Notifications")

    notis = notification(username)
    if notis:
        for note in notis:
            st.markdown(f" {note['notification']}")
    else:
        st.markdown("No personal notifications available.")
