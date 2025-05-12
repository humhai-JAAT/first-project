import streamlit as st
import pandas as pd
from db_utils import get_exam_assignments, submit_assignment

def show_exam_assignments(username):
    st.subheader("📚 Assignments Dashboard")

    # Fetch assignments
    assignments_df = get_exam_assignments(username)

    if assignments_df.empty:
        st.info("No assignments available.")
        return

    # Convert submission date to datetime
    assignments_df["submission_date"] = pd.to_datetime(assignments_df["submission_date"])

    # Submitted Assignments
    submitted = assignments_df[assignments_df["submitted"] == 1]
    if not submitted.empty:
        st.success("✅ Submitted Assignments")
        st.dataframe(
            submitted[["assignment_name", "subject", "due_date", "submission_date", "file_path"]],
            use_container_width=True
        )
    else:
        st.warning("No assignments submitted yet.")

    st.markdown("---")

    # Pending Assignments
    pending = assignments_df[assignments_df["submitted"] == 0]
    if not pending.empty:
        st.error("⏳ Pending Assignments")
        st.dataframe(
            pending[["assignment_id", "assignment_name", "subject", "due_date"]],
            use_container_width=True
        )

        st.markdown("### 📤 Upload Pending Assignments")

        for _, row in pending.iterrows():
            with st.expander(f"📌 Upload for: {row['assignment_name']} (Due: {row['due_date']})"):
                file = st.file_uploader(
                    f"Upload file for {row['assignment_name']}",
                    type=["pdf", "docx", "txt"],
                    key=row['assignment_name']
                )
                if file and st.button(f"Submit Assignment", key=f"submit_{row['assignment_id']}"):
                    try:
                        submit_assignment(username, row["assignment_id"], file)
                        st.success("✅ Assignment submitted successfully!")
                        st.rerun()
                    except Exception as e:
                        st.error(f"❌ Error submitting assignment: {str(e)}")

    else:
        st.success("🎉 No pending assignments!")

    st.markdown("---")
