#SIMPLE MLOps pipeline

MLOps Pipeline Overview
This pipeline automates the deployment of a Flask app hosted on AWS EC2 using GitHub Actions for CI/CD.

Workflow
Version Control: Code is pushed to GitHub repository.
CI Process:
Test: Runs unit tests and code quality checks (using unittest and flake8).
CD Process:
Deploy: On push/merge to the main branch, GitHub Actions:
SSHs into the EC2 instance.
Pulls the latest changes.
Restarts the Flask app.
GitHub Actions Workflow
Trigger: Runs on push/pull_request to main.
Steps:
Checkout: Fetches latest code.
Test: Runs tests (unittest).
Deploy: Pulls changes to EC2 and restarts the app.
Outcome
Code changes are automatically deployed to the EC2-hosted Flask app, reflected on the website after each update.


