import streamlit as st
import openai
import io

def chat_bot():
    st.title("🤖 ChatGPT-like Chatbot")

    tab_chat, tab_settings, tab_upload, tab_resources = st.tabs([
        "💬 Chat", "⚙️ Settings", "📎 Upload File", "📚 Study Resources"
    ])

    # Initialize session state
    if "chat_history" not in st.session_state:
        st.session_state.chat_history = []
    if "use_stream" not in st.session_state:
        st.session_state.use_stream = True
    if "file_content" not in st.session_state:
        st.session_state.file_content = ""
    if "pending_response" not in st.session_state:
        st.session_state.pending_response = None

    # ⚙️ Settings Tab
    with tab_settings:
        st.session_state.use_stream = st.toggle("Stream responses", value=st.session_state.use_stream)

        if st.button("🧹 Clear Chat"):
            st.session_state.chat_history = []
            st.session_state.pending_response = None

        if st.button("📤 Export Chat as Text File"):
            if st.session_state.chat_history:
                chat_text = "\n\n".join(
                    [f"{msg['role'].capitalize()}:\n{msg['content']}" for msg in st.session_state.chat_history]
                )
                st.download_button("Download Chat", data=chat_text, file_name="chat_history.txt")

    # 📎 Upload Tab
    with tab_upload:
        uploaded_file = st.file_uploader("Upload TXT, PDF, or DOCX", type=["txt", "pdf", "docx"])
        if uploaded_file:
            try:
                if uploaded_file.type == "text/plain":
                    st.session_state.file_content = uploaded_file.read().decode()
                elif uploaded_file.type == "application/pdf":
                    from PyPDF2 import PdfReader
                    reader = PdfReader(uploaded_file)
                    st.session_state.file_content = "\n".join([p.extract_text() for p in reader.pages if p.extract_text()])
                elif uploaded_file.type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                    import docx
                    doc = docx.Document(uploaded_file)
                    st.session_state.file_content = "\n".join([para.text for para in doc.paragraphs])
                st.success("✅ File content extracted!")

                with st.expander("📄 Preview Extracted Content"):
                    st.text_area("Preview", st.session_state.file_content[:3000], height=300)
            except Exception as e:
                st.error(f"Failed to read file: {e}")

    # 💬 Chat Tab
    with tab_chat:
        openai.api_key = st.secrets["OPENAI_API_KEY"]
        client = openai.OpenAI()
        for msg in st.session_state.chat_history:
            with st.chat_message(msg["role"]):
                st.markdown(msg["content"])
        user_prompt = st.chat_input("Type your message or use mic 🎙️")
        if user_prompt:
            # Prepare prompt
            if st.session_state.file_content:
                user_prompt += f"\n\n[Attached File Content]:\n{st.session_state.file_content[:1500]}"
            st.session_state.chat_history.append({"role": "user", "content": user_prompt})

            # Generate assistant response
            try:
                if st.session_state.use_stream:
                    with st.chat_message("user"):
                        st.markdown(user_prompt)

                    with st.chat_message("assistant"):
                        stream_response = client.chat.completions.create(
                            model="gpt-3.5-turbo",
                            messages=st.session_state.chat_history,
                            temperature=0.7,
                            stream=True,
                        )
                        full_reply = ""
                        msg_container = st.empty()
                        for chunk in stream_response:
                            if chunk.choices[0].delta.content:
                                full_reply += chunk.choices[0].delta.content
                                msg_container.markdown(full_reply)
                        st.session_state.chat_history.append({"role": "assistant", "content": full_reply})
                else:
                    response = client.chat.completions.create(
                        model="gpt-3.5-turbo",
                        messages=st.session_state.chat_history,
                        temperature=0.7,
                    )
                    bot_reply = response.choices[0].message.content
                    st.session_state.chat_history.append({"role": "assistant", "content": bot_reply})

            except Exception as e:
                error_msg = f"❌ Error: {e}"
                st.session_state.chat_history.append({"role": "assistant", "content": error_msg})

        # Show full chat history
        #for msg in st.session_state.chat_history:
         #   with st.chat_message(msg["role"]):
         #       st.markdown(msg["content"])

    # 📚 Resources Tab
    with tab_resources:
        st.header("📚 Study Resources")
        st.markdown("### 📄 Recommended Materials")
        st.markdown("""
        - [Python Basics PDF](https://example.com/python_basics.pdf)
        - [Data Structures Notes](https://example.com/data_structures)
        - [Sample Exam Questions](https://example.com/sample_exams)
        """)
        st.markdown("### ✍️ Tips")
        st.info("🕒 Revise at least 30 mins daily.\n📌 Practice coding 3 times a week.\n✅ Focus on understanding, not memorizing.")
        st.download_button("📥 Download Full Syllabus", data="Sample syllabus content", file_name="syllabus.txt")



