#!/bin/sh

# Define the path to the global git hooks directory
GIT_HOOKS_DIR="$HOME/global_git_hooks"

# Ensure the global git hooks directory exists
mkdir -p "$GIT_HOOKS_DIR"

# Define the path to the pre-commit hook within the global git hooks directory
GIT_HOOKS_PATH="$GIT_HOOKS_DIR/pre-commit"

# Use a here-document to provide the content of the pre-commit hook script
cat << 'EOF' > "$GIT_HOOKS_PATH"
#!/bin/sh

# Check local user configuration
echo "Global Hooks: Local user checking..."

local_user="$(git config --local user.name)"
local_email="$(git config --local user.email)"

global_user="$(git config --global user.name)"
global_email="$(git config --global user.email)"

if [ -z "$local_user" ] || [ -z "$local_email" ]; then
    echo "Warning: Git local user configuration is not set."
    echo "Using global Git user information for all repositories and projects may not be safe."
    echo "This could potentially expose personal or sensitive information in certain work environments, or when client requirements necessitate specific user information for each project."
    echo "Recommendation: Configure Git local user information for each project to enhance security and comply with client requirements."
    echo ""
    echo "You have the following options to set up Git user information:"
    echo "1. Use the current global Git user information."
    echo "2. Enter new information for the Git local user configuration."
    echo ""
    echo "To use the global Git user information, run the following commands:"
    echo "git config --local user.name "\"$global_user\"
    echo "git config --local user.email "\"$global_email\"
    echo ""
    echo "To enter new information, run the following commands and replace 'Your Name' and 'email@example.com' with your information:"
    echo "git config --local user.name \"Your Name\""
    echo "git config --local user.email \"email@example.com\""
    exit 1
fi
EOF

# Set execute permission for the pre-commit hook
chmod +x "$GIT_HOOKS_PATH"

echo "Git hook script has been installed at $GIT_HOOKS_PATH"

# Set the global Git configuration to use the global git hooks directory
git config --global core.hooksPath "$HOME/global_git_hooks"

echo "Global Git hooks path has been set to $HOME/global_git_hooks"
