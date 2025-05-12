import streamlit as st
import pandas as pd
import altair as alt
from db_utils import get_student_attendance, get_all_students_attendance

def show_attendance(username):
    st.subheader("📅 Attendance Record")

    df = get_student_attendance(username)

    if df.empty:
        st.info("No attendance data available.")
        return

    # Convert date column to datetime
    df["date"] = pd.to_datetime(df["date"])
    df["subject"] = df["subject"].str.capitalize()
    df["status"] = df["status"].str.capitalize()

    # 📌 --- Filter Section ---
    with st.expander("🔍 Filter Attendance"):
        subjects = sorted(df["subject"].unique())
        selected_subjects = st.multiselect("Select Subjects", subjects, default=subjects)

        min_date = df["date"].min()
        max_date = df["date"].max()
        date_range = st.date_input("Select Date Range", [min_date, max_date])

        filtered_df = df[
            (df["subject"].isin(selected_subjects)) &
            (df["date"].between(pd.to_datetime(date_range[0]), pd.to_datetime(date_range[1])))
        ]

    # Display filtered table
    st.dataframe(filtered_df, use_container_width=True)

    # 🧾 --- Download Button ---
    csv = filtered_df.to_csv(index=False).encode('utf-8')
    st.download_button("⬇️ Download CSV", csv, "attendance_report.csv", "text/csv")

    # 📊 --- Summary Table ---
    st.subheader("📊 Attendance Summary")
    summary = filtered_df.groupby(["subject", "status"]).size().unstack(fill_value=0)
    summary["Total"] = summary.sum(axis=1)
    summary["Attendance %"] = (summary.get("Present", 0) / summary["Total"] * 100).round(2)
    st.dataframe(summary, use_container_width=True)

    # 📈 --- Trend Chart ---
    st.subheader("📉 Attendance Trend")
    chart_data = filtered_df.groupby(["date", "status"]).size().reset_index(name="count")

    chart = alt.Chart(chart_data).mark_line(point=True).encode(
        x='date:T',
        y='count:Q',
        color='status:N',
        tooltip=["date", "status", "count"]
    ).properties(height=400)

    st.altair_chart(chart, use_container_width=True)

    # 🏆 --- Attendance Leaderboard ---
    st.subheader("🏆 Attendance Leaderboard")

    all_df = get_all_students_attendance()

    if not all_df.empty:
        leaderboard = all_df.copy()
        leaderboard["status"] = leaderboard["status"].str.capitalize()
        total = leaderboard.groupby("user_name").size()
        present = leaderboard[leaderboard["status"] == "Present"].groupby("user_name").size()
        leaderboard_df = pd.DataFrame({
            "Total Classes": total,
            "Present": present
        }).fillna(0)
        leaderboard_df["Attendance %"] = (leaderboard_df["Present"] / leaderboard_df["Total Classes"] * 100).round(2)
        leaderboard_df = leaderboard_df.sort_values(by="Attendance %", ascending=False).reset_index()

        st.dataframe(leaderboard_df, use_container_width=True)

        # Chart
        chart = alt.Chart(leaderboard_df.head(10)).mark_bar().encode(
            x=alt.X("Attendance %:Q", scale=alt.Scale(domain=[0, 100])),
            y=alt.Y("user_name:N", sort="-x"),
            color=alt.value("#4CAF50"),
            tooltip=["user_name", "Attendance %"]
        ).properties(height=400, title="Top 10 Students by Attendance")

        st.altair_chart(chart, use_container_width=True)
