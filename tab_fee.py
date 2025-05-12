import streamlit as st
import pandas as pd
from db_utils import get_fee_status, get_payment_history
import io
from datetime import datetime

def show_fee_tab(username):
    st.header("💸 Fee Details")

    fee_df = get_fee_status(username)
    payment_df = get_payment_history(username)

    if fee_df.empty:
        st.info("No fee records found.")
        return

    st.subheader("📋 Fee Status")
    st.dataframe(fee_df, use_container_width=True)

    st.subheader("💳 Payment History")
    if payment_df.empty:
        st.info("No payments made yet.")
    else:
        st.dataframe(payment_df, use_container_width=True)

        st.markdown("---")

        # Let user select a payment to download receipt for
        selected_payment = st.selectbox(
            "Select Payment for Receipt",
            payment_df["payment_id"].astype(str)
        )

        if selected_payment:
            selected_row = payment_df[payment_df["payment_id"].astype(str) == selected_payment].iloc[0]

            receipt_content = f"""
            -------- Fee Payment Receipt --------

            Student Username : {username}
            Roll Number      : {selected_row['roll_number']}
            Payment ID       : {selected_row['payment_id']}
            Payment Date     : {selected_row['payment_date']}
            Amount Paid      : ₹{selected_row['amount']}
            Payment Method   : {selected_row['method']}
            Reference ID     : {selected_row['reference_id']}

            -------------------------------------
            Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
            """

            receipt_bytes = io.BytesIO(receipt_content.encode())

            st.download_button(
                label="📄 Download Receipt",
                data=receipt_bytes,
                file_name=f"receipt_{selected_payment}.txt",
                mime="text/plain"
            )
