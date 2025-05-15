
# 🐧 Linux Command Cheat Sheet With Gen AI 🧠

A smart, AI-powered Linux command reference tool built in Bash, leveraging **Google's Gemini API** to provide **detailed explanations**, **usage**, **flags**, and **real-world examples** of Linux commands — all within your terminal.

> ✨ Learn Linux commands the intelligent way — with elegant formatting, interesting facts, and clean dialog UI.

---

## 📸 Preview

![image](https://github.com/user-attachments/assets/8bf120f3-87dc-47be-bb80-71460c3a0176)

![image](https://github.com/user-attachments/assets/637e2d74-f76c-47f1-92b9-400542206aa8)

![image](https://github.com/user-attachments/assets/c805969a-adb9-43c1-9316-9e8fb9d70402)


---

## 🔧 Features

- 🔍 **Explain any Linux command** using Google Gemini API.
- 📚 **Fallback to man pages** if Gemini response is unavailable.
- 🧠 **Interesting Linux facts** displayed while you wait.
- 💾 **Command history saved** in `~/.gemini_history`.
- 📑 **Structured formatting** of headings, flags, examples, and notes.
- 💬 Interactive UI using `dialog` for beautiful terminal prompts.
- 🛠️ Requires only Bash, `curl`, `jq`, and `dialog`.

---

## 🚀 Getting Started

### ✅ Prerequisites

Make sure the following tools are installed:

```bash
sudo apt update
sudo apt install curl jq dialog -y
````

---

### 📥 Installation

1. **Clone this repository**:

```bash
git clone https://github.com/krishhn13/Linux-Command-Cheat-Sheet-With-Gen-AI.git
cd Linux-Command-Cheat-Sheet-With-Gen-AI
```

2. **Make the script executable**:

```bash
chmod +x linuxCheatsheet.sh
```

3. **Add your Gemini API key**
   Open the script and update the `API_KEY` variable with your key:

```bash
API_KEY="your_gemini_api_key_here"
```

> 💡 Don’t have a Gemini API key? Get one from [Google AI Studio](https://aistudio.google.com/app/apikey).

---

### 🧪 Run the Script

```bash
./linuxCheatsheet.sh
```

Now just type a command like `ls` or `grep`, and see the magic unfold ✨

---

## 📂 File Structure

```bash
.
├── linuxCheatsheet.sh      # Main script            
├── README.md               # This file
```

---

## 🌟 Example Output

**Input:**

```
ls
```

**Output:**

```
Explanation of: ls

==========================
LS – LIST DIRECTORY CONTENTS
==========================

• Description:
  Lists files and directories in the current working directory.

• Usage:
  ls [OPTION]... [FILE]...

• Common Flags:
  -a : Show all files including hidden ones
  -l : Long listing format
  -h : Human-readable sizes

• Example:
  ls -alh
```

---

## 📒 What Makes This Special?

* Traditional command line tool with a **modern twist of AI**
* Perfect for **students, developers, and Linux learners**
* Works even when Gemini fails (fallback to good ol’ `man` pages)
* A handy **command knowledge base** that grows with your use

---

## 🤝 Contribution

Pull requests are welcome! Feel free to fork the repo and submit a PR.

If you have any ideas to improve formatting, UI, or functionality, let’s build it together 💻❤️

---

## 📜 License

This project is licensed under the MIT License. See [`LICENSE`](LICENSE) for more.

---
<div align = center>

## 👨‍💻 Author

**Krishn** – *Student @ Chitkara University* <br>
📷 Photographer | 💡 Tech Enthusiast | 🐧 Linux Lover <br>
[GitHub Profile](https://github.com/krishhn13)

---

## 👨‍💻👨‍💻 Collaborators

 [Abhinav Gupta](http://github.com/abhinavGupta-012) | [Adish Jain](https://github.com/adi01-codes) | [Driksha Thakur](https://github.com/drikshathakur786)

</div>

## 🙌 Acknowledgements

* [Google Gemini API](https://aistudio.google.com/)
* Open Source tools: Bash, curl, jq, dialog
* Your curiosity and love for Linux 🌿

---
<div align = center> 
  
> “Linux is love. Gemini is the light. Together, they illuminate the path of learning.”

</div>
<hr>
