#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if netcat is installed
if ! command -v nc &> /dev/null; then
    echo "Error: netcat (nc) is required but not installed."
    echo "Please install it with: brew install netcat"
    exit 1
fi

# Function to wait for PostgreSQL to be ready
wait_for_postgres() {
    echo "Waiting for PostgreSQL to be ready..."
    local max_attempts=30
    local attempt=1
    while ! nc -z localhost 5432; do
        if [ $attempt -ge $max_attempts ]; then
            echo "Error: PostgreSQL failed to start after $max_attempts attempts"
            exit 1
        fi
        echo "Attempt $attempt/$max_attempts: PostgreSQL not ready yet..."
        sleep 2
        ((attempt++))
    done
    echo "✅ PostgreSQL is ready!"
    sleep 2 # Give it a moment to complete initialization
}

# Function to wait for Zero server to be ready
wait_for_zero() {
    echo "Waiting for Zero server to be ready..."
    local max_attempts=15
    local attempt=1
    while ! nc -z localhost 4848; do
        if [ $attempt -ge $max_attempts ]; then
            echo "Error: Zero server failed to start after $max_attempts attempts"
            exit 1
        fi
        echo "Attempt $attempt/$max_attempts: Zero server not ready yet..."
        sleep 2
        ((attempt++))
    done
    echo "✅ Zero server is ready!"
    sleep 2
}

echo "🚀 Starting development environment..."
echo "📂 Working directory: $SCRIPT_DIR"

# Start Docker services in a new terminal
echo "1️⃣ Starting Docker services..."
osascript -e 'tell app "Terminal"
    do script "cd \"'$SCRIPT_DIR'\" && yarn docker up"
end tell'

# Wait for PostgreSQL to be ready
wait_for_postgres

# Start Zero server in a new terminal
echo "2️⃣ Starting Zero server..."
osascript -e 'tell app "Terminal"
    do script "cd \"'$SCRIPT_DIR'\" && yarn zero"
end tell'

# Wait for Zero server to be ready
wait_for_zero

# Start Tauri in a new terminal
echo "3️⃣ Starting Tauri development server..."
osascript -e 'tell app "Terminal"
    do script "cd \"'$SCRIPT_DIR'\" && yarn dev:tauri"
end tell'

echo "✨ All services started successfully!"
echo "📝 Development URLs:"
echo "   • Web interface: http://localhost:8081"
echo "   • Zero server: http://localhost:4848"
echo "   • PostgreSQL: localhost:5432"
echo "You can minimize this terminal now." 