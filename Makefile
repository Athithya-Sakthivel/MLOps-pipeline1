# Variables
PYTHON := python
PIP := pip
VENV := venv
ACTIVATE := .\venv\Scripts\activate  # Adjusted for Windows

# List of dependencies
DEPENDENCIES := flask flake8 black isort unittest

# Default target
.DEFAULT_GOAL := help

# Help command
help:
	@echo "Available commands:"
	@echo "  make install        Install dependencies"
	@echo "  make test           Run tests"
	@echo "  make lint           Run linter (flake8)"
	@echo "  make format         Format code (black & isort)"
	@echo "  make run            Run the application"
	@echo "  make clean          Clean up temporary files"
	@echo "  make reset          Reset the environment"
	@echo "  make sync           Sync with the latest changes from GitHub"
	@echo "  make push           Commit and push changes to the repository"

# Install dependencies
install:
	@echo "Setting up virtual environment and installing dependencies..."
	@if not exist "$(VENV)" ($(PYTHON) -m venv $(VENV))
	$(ACTIVATE) && $(PIP) install --upgrade pip
	$(ACTIVATE) && $(PIP) install $(DEPENDENCIES)

# Run tests
test:
	@echo "Running tests..."
	$(ACTIVATE) && $(PYTHON) -m unittest discover -s . -p "test_*.py"

# Run linter
lint:
	@echo "Running linter..."
	$(ACTIVATE) && flake8 .

# Format code
format:
	@echo "Formatting code..."
	$(ACTIVATE) && black .
	$(ACTIVATE) && isort .

# Run the application
run:
	@echo "Running the application..."
	$(ACTIVATE) && $(PYTHON) app.py

# Clean temporary files
clean:
	@echo "Cleaning up temporary files..."
	if exist "__pycache__" (rmdir /S /Q __pycache__)
	del /S /Q *.pyc

# Reset the environment
reset:
	@echo "Resetting environment..."
	if exist $(VENV) (rmdir /S /Q $(VENV))
	$(PYTHON) -m venv $(VENV)
	$(ACTIVATE) && $(PIP) install --upgrade pip
	$(ACTIVATE) && $(PIP) install $(DEPENDENCIES)

# Sync with GitHub
sync:
	@echo "Pulling latest changes from GitHub..."
	git fetch origin
	git pull origin main

# Commit and push changes
push:
	@echo "Committing and pushing changes..."
	git add .
	git commit -m "Update: $(shell date '+%Y-%m-%d %H:%M:%S')"
	git push origin main
