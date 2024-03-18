# INIT VPS INSTANCE
```
curl https://raw.githubusercontent.com/nathando91/infra/main/init_instance | sh
```

# INSTALL NEOVIM
```
curl https://raw.githubusercontent.com/nathando91/infra/main/install_neovim | sh
```
# GIT HOOK
Git Pre-Commit Hook Installer This repository hosts a script designed to automate the installation of a pre-commit hook for Git projects. The pre-commit hook script included within ensures that Git local user configuration is set before allowing commits. This is crucial for maintaining security and compliance with project-specific user information requirements.

Purpose The pre-commit hook aims to:

Verify that Git local user information (name and email) is configured for each project. Promote best practices for security by discouraging the use of global Git user information across all projects. Provide an easy and automated way to ensure that commits meet the project's compliance and security standards. Features Automated Installation: A simple command allows the pre-commit hook to be installed into any local Git repository. User Verification: Before each commit, the script checks if the local Git user information is set, promoting project-specific configurations. Flexibility: Offers guidance on how to configure local user information if not already set, with options for using global settings or entering new information. How to Install To install the pre-commit hook in your local Git repository, run the following command:

```
curl -Ls https://github.com/nathando91/install-git-hook/blob/main/install-script.sh | sh
```

Usage Once installed, the pre-commit hook automatically runs each time git commit is executed. If your local user information is not configured, the hook will halt the commit process and provide instructions for setting up your Git user information locally.

Contributing We welcome contributions to improve the installation script or the pre-commit hook functionality. Please feel free to fork the repository, make your changes, and submit a pull request.

# OTHERS
