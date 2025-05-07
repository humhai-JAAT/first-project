import streamlit as st
from db_utils import get_student_profile
import os

def show_profile(username):
    st.subheader("👤 Student Profile")
    profile = get_student_profile(username)
    img_path = os.path.join("C:/Users/pc/Desktop/project/testing folder/", f"{username}.jpeg")
    st.image(img_path,width=300)

    if profile:
        for key, value in profile.items():
            st.write(f"**{key.capitalize()}**: {value}")        
        
    else:
        st.warning("No profile found.")
