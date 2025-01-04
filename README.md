MLOps Pipeline Overview
1. Purpose
This pipeline automates the deployment process for your Flask-based application hosted on an EC2 instance. It integrates Continuous Integration (CI) to test code changes and Continuous Deployment (CD) to automatically update the website whenever new code is pushed to the repository.

2. Architecture
Version Control: GitHub is used to host your source code.
CI/CD Tool: GitHub Actions automate testing, pulling changes, and restarting the application.
Hosting Environment: The Flask app is hosted on an AWS EC2 instance (Ubuntu).
Step-by-Step Workflow
1. Local Development
Code is developed on your local machine and pushed to the GitHub repository.
2. GitHub Actions (CI/CD)
Trigger: The pipeline is triggered automatically when:
A commit is pushed to the main branch.
A pull request is opened or merged into main.
Jobs Performed:
Checkout Code: GitHub Actions pulls the latest code from the repository.
Run Tests: The pipeline runs tests (e.g., unittest) and checks code quality (flake8).
Deploy Code:
SSH into the EC2 instance.
Pull the latest changes from the repository.
Restart the Flask application.
3. Hosting and Deployment
The Flask app is hosted on an AWS EC2 instance.
When changes are deployed, the Flask app reflects the updates on your website.
How GitHub Actions is Configured
GitHub Actions Workflow File
The pipeline is defined in a .github/workflows/deploy.yml file in your repository. Here’s an example workflow that matches your setup:

yaml
Copy code
name: CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Code
      uses: actions/checkout@v3

    - name: Run Tests
      run: |
        python3 -m unittest discover -s .

    - name: Deploy to EC2
      run: |
        ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ubuntu@<EC2_PUBLIC_IP> << 'EOF'
        cd /path/to/MLOps-pipeline1
        git pull
        pkill -f "python app.py"
        nohup python app.py --host=0.0.0.0 --port=8080 &
        EOF
Pipeline Details
Trigger

The pipeline is triggered on every push or pull_request event on the main branch.
CI Jobs

Checkout: Fetches the repository code.
Test: Runs unit tests to ensure the application behaves as expected.
Code Quality Check: Runs flake8 to ensure the code adheres to PEP8 standards.
CD Steps

Connects to the EC2 instance using SSH.
Pulls the latest code using git pull.
Restarts the Flask application with the updated code.
How it Reflects Changes in the Website
Push or merge code changes to GitHub.
GitHub Actions:
Runs tests.
Deploys the updated code to the EC2 instance.
Flask app on EC2:
Pulls the latest changes.
Restarts, making the updates live.
Diagram of the Pipeline
Here's how you can structure a diagram for your documentation:

css
Copy code
1. Developer Pushes Code
      ↓
2. GitHub Repository
      ↓
3. GitHub Actions Workflow
      ↓
4. EC2 Instance
      ↓
5. Flask App Restarts with Updated Code
      ↓
6. Updated Website
