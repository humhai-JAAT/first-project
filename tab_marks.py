import streamlit as st
from db_utils import get_student_marks

def show_marks(username):
    st.subheader("📄 Subject-wise Marks")

    # Semester selection
    selected_sems = st.multiselect(
        "Select Semester(s)",
        options=[f"Semester {i}" for i in range(1, 10)],
        default=["Semester 2"]
    )

    if selected_sems:
        marks_df = get_student_marks(username, selected_sems)

        if not marks_df.empty:
            # Reorder columns: move 'Exam' to front
            cols = ["Exam"] + [col for col in marks_df.columns if col != "Exam"]
            marks_df = marks_df[cols]

            # Capitalize column headers
            marks_df.columns = [col.capitalize().replace("_", " ") for col in marks_df.columns]

            st.dataframe(marks_df, use_container_width=True)
        else:
            st.info("No marks available for the selected semester(s).")
    else:
        st.warning("Please select at least one semester to view marks.")

