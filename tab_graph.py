import streamlit as st
import pandas as pd
import plotly.graph_objects as go
from db_utils import get_student_marks

def show_graph(username):
    st.subheader("📊 Marks Graph (Interactive)")

    # Step 1: Select semesters
    selected_sems = st.multiselect(
        "Select Semester(s):",
        options=[f"Semester {i}" for i in range(1, 10)],
        default=["Semester 2"]
    )

    if not selected_sems:
        st.warning("Please select at least one semester to continue.")
        return

    # Step 2: Get marks based on semester selection
    df = get_student_marks(username, selected_sems)

    if df.empty:
        st.info("No data to display for the selected semester(s).")
        return

    # Step 3: Exam selection
    exam_options = df['Exam'].unique().tolist()
    selected_exams = st.multiselect("Select exam(s) to display:", exam_options, default=exam_options)

    # Step 4: Graph type selection
    graph_type = st.selectbox("Select graph type:", ["Bar Chart", "Line Chart", "Both"])

    if not selected_exams:
        st.warning("Please select at least one exam to display the graph and report.")
        return

    # Step 5: Filter and reshape data
    filtered_df = df[df['Exam'].isin(selected_exams)]
    melted_df = filtered_df.melt(id_vars=["Exam"], var_name="Subject", value_name="Marks")

    # Step 6: Create interactive figure
    fig = go.Figure()

    for exam in selected_exams:
        exam_data = melted_df[melted_df['Exam'] == exam]
        subjects = exam_data["Subject"]
        marks = exam_data["Marks"]

        if graph_type in ["Bar Chart", "Both"]:
            fig.add_trace(go.Bar(x=subjects, y=marks, name=f"{exam} (Bar)", opacity=0.6))

        if graph_type in ["Line Chart", "Both"]:
            fig.add_trace(go.Scatter(x=subjects, y=marks, name=f"{exam} (Line)", mode="lines+markers"))

    fig.update_layout(
        title="Subject-wise Marks",
        xaxis_title="Subjects",
        yaxis_title="Marks",
        barmode='group',
        template='plotly_white'
    )

    st.plotly_chart(fig, use_container_width=True)

    # Step 7: Report Summary
    st.subheader("📝 Performance Summary")
    report = ""
    for exam in selected_exams:
        exam_data = df[df["Exam"] == exam].drop(columns=["Exam"])
        avg = exam_data.mean(axis=1).values[0]
        highest = exam_data.max(axis=1).values[0]
        lowest = exam_data.min(axis=1).values[0]

        remark = "Excellent" if avg >= 80 else "Good" if avg >= 60 else "Needs Improvement"

        report += f"**{exam}**:\n"
        report += f"- Average Marks: {avg:.2f}\n"
        report += f"- Highest Marks: {highest}\n"
        report += f"- Lowest Marks: {lowest}\n"
        report += f"- Performance: {remark}\n\n"

    st.markdown(report)
