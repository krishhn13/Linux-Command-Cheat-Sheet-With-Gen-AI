#!/bin/bash

# ---------------------------------------------------------
# Gemini-Powered Linux Command Reference Tool
# Author: Prashant Singh Gautam
# Description:
#   Shell-based utility to explain Linux commands using
#   Google Gemini AI with Linux facts and elegant display.
# ---------------------------------------------------------

# === CONFIGURATION ===
API_KEY="AIzaSyCg4F7b787Z7uTIZckafqdE914daFE8W10"
GEMINI_URL="https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro-001:generateContent?key=$API_KEY"
TMP_OUTPUT="/tmp/gemini_command_output.txt"

# === DEPENDENCY CHECK ===
for tool in dialog jq curl; do
    if ! command -v $tool &> /dev/null; then
        echo "Error: '$tool' is not installed."
        echo "Install it using: sudo apt install $tool -y"
        exit 1
    fi
done

# === FUNCTION: Show Linux Fact While Waiting ===
show_waiting_message() {
    local facts=(
        "The first Linux kernel had only 10,239 lines of code!"
        "Linus Torvalds initially wanted to call it 'Freax'."
        "Linux powers over 90% of the world’s supercomputers."
        "Tux, the mascot, was inspired by a penguin Linus saw at a zoo."
        "Android, the world’s most popular mobile OS, is Linux-based."
        "NASA uses Linux in their space missions and ground stations."
        "The Bash shell stands for 'Bourne Again SHell'."
        "The GNU in GNU/Linux means 'GNU’s Not Unix'."
        "Facebook, Google, and Amazon rely heavily on Linux servers."
        "Linux runs the backbone of the internet."
        "Major stock exchanges like NYSE run on Linux infrastructure."
        "Tiny Core Linux can fit into a single floppy disk."
        "The entire Google infrastructure is built on Linux."
        "Supercomputers in weather forecasting use Linux."
        "Linux supports more hardware platforms than any other OS."
        "You can boot Linux from USB, CD, network, or floppy disk!"
        "Red Hat was the first billion-dollar Linux company."
        "Ubuntu means 'humanity to others' in Zulu."
        "There are thousands of active Linux distributions."
        "The Linux kernel is mostly written in C."
    )
    local random_index=$((RANDOM % ${#facts[@]}))
    local fact="${facts[$random_index]}"
    dialog --title "Please Wait – Gemini Is Thinking..." --infobox "\n💡 $fact\n\nFetching response from Gemini API..." 15 60
    sleep 25  # Now it will wait for 25 seconds while showing the fact
}

# === FUNCTION: Query Gemini API and Clean Output ===
query_gemini() {
    local cmd="$1"
    local prompt="Explain the Linux command: $cmd with usage, flags, and real-world examples. Keep it beginner-friendly and well-structured."

    local response=$(curl -s --max-time 25 -X POST "$GEMINI_URL" \
        -H "Content-Type: application/json" \
        -d "{
              \"contents\": [{
                \"parts\": [{\"text\": \"$prompt\"}]
              }]
            }")

    local output=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text' 2>/dev/null)

    # Check for empty or null output
    if [ -z "$output" ] || [[ "$output" == "null" ]]; then
        # Fallback to 'man' page if Gemini fails
        if man "$cmd" > /dev/null 2>&1; then
            man "$cmd" | col -bx | fold -s -w 80 > "$TMP_OUTPUT"
            echo "[📚 Fallback to man page]" >> "$TMP_OUTPUT"
        else
            echo "❌ No response from Gemini and no man page available for '$cmd'." > "$TMP_OUTPUT"
        fi
    else
        echo "$output" | \
            sed 's/^```.*$//g' | \
            sed 's/```//g' | \
            sed 's/`//g' | \
            sed 's/\*\*\*//g' | \
            sed 's/\*\*/ /g' | \
            sed 's/\*//g' | \
            sed 's/^### \(.*\)$/\n\1\n$(printf "%0.s-" {1..80})\n/' | \
            sed 's/^## \(.*\)$/\n\1\n$(printf "%0.s=" {1..80})\n/' | \
            sed 's/^# \(.*\)$/\n\1\n$(printf "%0.s=" {1..80})\n/' | \
            sed 's/^[-+*] /* • /' | \
            sed 's/^\s*$//' | \
            fold -s -w 80 > "$TMP_OUTPUT"
    fi
}

# === FUNCTION: Display Command Output ===
show_command_info() {
    local cmd="$1"
    show_waiting_message
    query_gemini "$cmd"
    dialog --title "📘 Explanation of: $cmd" --textbox "$TMP_OUTPUT" 25 90
}

# === FUNCTION: Welcome Screen ===
show_welcome_screen() {
    dialog --title "👋 Welcome to Gemini Command Tool" \
    --msgbox "\nWelcome to the ultimate Linux learning companion!\n\nThis tool explains any Linux command using Google Gemini AI.\n\nType a command, and let the learning begin. 🚀" 15 60
}

# === MAIN LOOP ===
show_welcome_screen

while true; do
    command=$(dialog --clear \
        --title "🔍 Gemini Linux Command Search" \
        --inputbox "Enter a Linux command (or type 'exit' to quit):" 10 60 \
        3>&1 1>&2 2>&3)

    [ $? -ne 0 ] && break

    if [ -z "$command" ]; then
        dialog --msgbox "⚠️ Please enter a command." 6 40
        continue
    fi

    if [[ "$command" == "exit" ]]; then
        break
    fi

    show_command_info "$command"
done

# === EXIT MESSAGE ===
clear
echo -e "\n👋 Thank you for using the Gemini Command Search Tool."
echo -e "Keep exploring, keep learning. Linux is love. 🐧\n"
