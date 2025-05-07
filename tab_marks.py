import streamlit as st
from db_utils import get_student_marks

def show_marks(username):
    st.subheader("📄 Subject-wise Marks")

    marks_df = get_student_marks(username)

    if not marks_df.empty:
        # Reorder columns: move 'Exam' to front
        cols = ["Exam"] + [col for col in marks_df.columns if col != "Exam"]
        marks_df = marks_df[cols]

        # Capitalize column headers
        marks_df.columns = [col.capitalize().replace("_", " ") for col in marks_df.columns]

        st.dataframe(marks_df, use_container_width=True)

        # Optional: visualize marks
        #if st.checkbox("📊 Show Bar Chart"):
        #    subject_cols = [col for col in marks_df.columns if col != "Exam"]
         #   chart_data = marks_df.melt(id_vars="Exam", value_vars=subject_cols,
          #                             var_name="Subject", value_name="Marks")
        #    st.bar_chart(chart_data.pivot(index="Subject", columns="Exam", values="Marks"))

    else:
        st.info("No marks available.")
