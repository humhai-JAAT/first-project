import streamlit as st

def show_help_box():
    st.subheader("📦 Help Box")

    # Leave Request
    st.markdown("### 📝 Leave Request")
    with st.form("leave_form"):
        leave_date = st.date_input("Leave Date")
        reason = st.text_area("Reason for Leave")
        if st.form_submit_button("Submit Leave Request"):
            st.success("Your leave request has been submitted!")

    # Upcoming Classes
    st.markdown("### 🕒 Upcoming Classes / Time Table")
    timetable = {
        "Monday": ["Maths", "Science", "English"],
        "Tuesday": ["Hindi", "Social Science", "Maths"],
        "Wednesday": ["English", "Science", "Hindi"],
        "Thursday": ["Social Science", "Maths", "English"],
        "Friday": ["Hindi", "Science", "Maths"],
    }
    for day, subjects in timetable.items():
        st.markdown(f"**{day}:** {', '.join(subjects)}")

    # Important Links
    st.markdown("### 🔗 Important Links")
    st.markdown("- [📱 WhatsApp Group](https://chat.whatsapp.com/your-link)")
    st.markdown("- [📧 School Website](https://your-school-website.com)")

    # 📚 Syllabus Section
    st.markdown("### 📚 Syllabus")
    syllabus = {
        "Maths": "Algebra, Geometry, Trigonometry, Statistics",
        "Science": "Physics (Motion, Force), Chemistry (Atoms), Biology (Cells)",
        "English": "Grammar, Comprehension, Essay Writing",
        "Hindi": "व्याकरण, निबंध लेखन, साहित्य",
        "Social Science": "History, Geography, Civics, Economics"
    }
    for subject, topics in syllabus.items():
        st.markdown(f"**{subject}:** {topics}")
