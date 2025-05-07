import streamlit as st
import matplotlib.pyplot as plt
import pandas as pd
from db_utils import get_student_marks

def show_graph(username):
    st.subheader("📊 Marks Graph")

    df = get_student_marks(username)

    if df.empty:
        st.info("No data to display.")
        return

    # Dropdown for exam selection
    exam_options = df['Exam'].unique().tolist()
    selected_exams = st.multiselect("Select exam(s) to display:", exam_options, default=exam_options)

    # Dropdown for graph type
    graph_type = st.selectbox("Select graph type:", ["Bar Chart", "Line Chart", "Both"])

    if not selected_exams:
        st.warning("Please select at least one exam to display the graph and report.")
        return

    # Filter data
    filtered_df = df[df['Exam'].isin(selected_exams)]

    # Reshape the data for plotting
    melted_df = filtered_df.melt(id_vars=["Exam"], var_name="Subject", value_name="Marks")

    # Plotting
    fig, ax = plt.subplots(figsize=(10, 5))

    for exam in selected_exams:
        exam_data = melted_df[melted_df['Exam'] == exam]

        if graph_type in ["Bar Chart", "Both"]:
            ax.bar(exam_data["Subject"], exam_data["Marks"], alpha=0.6, label=f"{exam} (Bar)")

        if graph_type in ["Line Chart", "Both"]:
            ax.plot(exam_data["Subject"], exam_data["Marks"], marker='o', label=f"{exam} (Line)")

    ax.set_title(f"Subject-wise Marks for {username}")
    ax.set_xlabel("Subjects")
    ax.set_ylabel("Marks")
    ax.legend()
    st.pyplot(fig)

    # Report Summary
    st.subheader("📝 Performance Summary")
    report = ""
    for exam in selected_exams:
        exam_data = df[df["Exam"] == exam].drop(columns=["Exam"])
        avg = exam_data.mean(axis=1).values[0]
        highest = exam_data.max(axis=1).values[0]
        lowest = exam_data.min(axis=1).values[0]

        remark = "Excellent" if avg >= 80 else "Good" if avg >= 60 else "Needs Improvement"

        report += f"**{exam} Exam**:\n"
        report += f"- Average Marks: {avg:.2f}\n"
        report += f"- Highest Marks: {highest}\n"
        report += f"- Lowest Marks: {lowest}\n"
        report += f"- Performance: {remark}\n\n"

    st.markdown(report)
