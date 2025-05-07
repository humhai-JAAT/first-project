import streamlit as st
import openai

def chat_bot():
    # ✅ Load your API key securely
    openai.api_key = st.secrets["OPENAI_API_KEY"]

    # ✅ Title
    st.title("🤖 ChatGPT-like Chatbot")

    # ✅ Session state to store chat
    if "chat_history" not in st.session_state:
        st.session_state.chat_history = []

    # ✅ Display chat history
    for msg in st.session_state.chat_history:
        with st.chat_message(msg["role"]):
            st.markdown(msg["content"])

    # ✅ Input from user
    user_prompt = st.chat_input("Type your message...")

    if user_prompt:
        # Store and display user's message
        st.session_state.chat_history.append({"role": "user", "content": user_prompt})
        with st.chat_message("user"):
            st.markdown(user_prompt)

        # Call OpenAI Chat API (v1.0+ format)
        try:
            client = openai.OpenAI()
            response = client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=st.session_state.chat_history,
                temperature=0.7,
            )
            bot_reply = response.choices[0].message.content
        except Exception as e:
            bot_reply = f"❌ Error: {e}"

        # Display assistant's reply
        st.session_state.chat_history.append({"role": "assistant", "content": bot_reply})
        with st.chat_message("assistant"):
            st.markdown(bot_reply)
