#!/bin/bash

if command -v xclip >/dev/null 2>&1; then
    clipboard=$(xclip -selection clipboard -o 2>/dev/null)
elif command -v xsel >/dev/null 2>&1; then
    clipboard=$(xsel --clipboard --output 2>/dev/null)
elif command -v wl-paste >/dev/null 2>&1; then
    clipboard=$(wl-paste 2>/dev/null)
elif command -v pbpaste >/dev/null 2>&1; then
    clipboard=$(pbpaste 2>/dev/null)
else
    echo "No clipboard utility found" >&2
    exit 1
fi

if [ -z "$clipboard" ]; then
    echo "Clipboard is empty"
    exit 0
fi

echo "Raw:"
echo "$clipboard"

# Extract user-like values (from both 'key: value' and 'key=value')
user=$(echo "$clipboard" | \
grep -Eio '(username|login_user|PGADMIN_DEFAULT_EMAIL|POSTGRES_DB|POSTGRES_USER|MYSQL_DB|MYSQL_USER|DB_USER|DB_USERNAME)[=:][[:space:]]*[^[:space:]]*' | \
tail -n1 | sed -E 's/.*[=:][[:space:]]*//')

# Extract password-like values (from both 'key: value' and 'key=value')
pass=$(echo "$clipboard" | grep -Eio '(password|login_password|PGADMIN_DEFAULT_PASSWORD|POSTGRES_PASSWORD|MYSQL_PASSWORD|DB_PASS|DB_PASSWORD)[=:][[:space:]]*[^[:space:]]*' | \
tail -n1 | sed -E 's/.*[=:][[:space:]]*//')

echo "User: $user"
echo "Pass: $pass"
