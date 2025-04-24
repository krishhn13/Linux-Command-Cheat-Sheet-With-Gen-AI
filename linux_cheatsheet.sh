#!/bin/bash

# ---------------------------------------------------------
# Gemini-Powered Linux Command Reference Tool
# Author: Prashant Singh Gautam
# Description:
#   A shell-based interactive utility to explain Linux commands
#   using Google Gemini AI. Ideal for beginners, certification
#   prep, and quick reference.
# ---------------------------------------------------------

# === CONFIGURATION ===
API_KEY="AIzaSyCg4F7b787Z7uTIZckafqdE914daFE8W10"
GEMINI_URL="https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro-001:generateContent?key=$API_KEY"

# === DEPENDENCY CHECK ===
for tool in dialog jq curl; do
    if ! command -v $tool &> /dev/null; then
        echo "Error: '$tool' is not installed."
        echo "Install it using: sudo apt install $tool -y"
        exit 1
    fi
done

# === FUNCTION: Query Gemini API ===
query_gemini() {
    local cmd="$1"
    local prompt="Explain the Linux command: $cmd with usage, flags, and real-world examples. Keep it beginner-friendly and well-structured."

    local response=$(curl -s -X POST "$GEMINI_URL" \
        -H "Content-Type: application/json" \
        -d "{
              \"contents\": [{
                \"parts\": [{\"text\": \"$prompt\"}]
              }]
            }")

    local output=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text' 2>/dev/null)

    if [ -z "$output" ] || [[ "$output" == "null" ]]; then
        echo "No response from Gemini. Check your API key or network connection."
    else
        echo "$output"
    fi
}

# === FUNCTION: Display Search Box and Results ===
show_command_info() {
    local cmd="$1"
    local info=$(query_gemini "$cmd")
    dialog --title "Command Info: $cmd" --msgbox "$info" 20 80
}

# === MAIN LOOP ===
while true; do
    command=$(dialog --clear \
        --title "Gemini Command Search" \
        --inputbox "Enter a Linux command (or type 'exit' to quit):" 10 60 \
        3>&1 1>&2 2>&3)

    [ $? -ne 0 ] && break

    if [ -z "$command" ]; then
        dialog --msgbox "Please enter a command." 6 40
        continue
    fi

    if [[ "$command" == "exit" ]]; then
        break
    fi

    show_command_info "$command"
done

# === EXIT MESSAGE ===
clear
echo "Exited Gemini Command Search Tool."
