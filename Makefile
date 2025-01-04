# Variables
PYTHON := python
PIP := pip
VENV := venv
BRANCH := main

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
	@if [ ! -d "$(VENV)" ]; then $(PYTHON) -m venv $(VENV); fi
	. $(VENV)/bin/activate && $(PIP) install --upgrade pip
	. $(VENV)/bin/activate && $(PIP) install $(DEPENDENCIES)

# Run tests
test:
	@echo "Running tests..."
	. $(VENV)/bin/activate && $(PYTHON) -m unittest discover -s . -p "test_*.py"

# Run linter
lint:
	@echo "Running linter..."
	. $(VENV)/bin/activate && flake8 .

# Format code
format:
	@echo "Formatting code..."
	. $(VENV)/bin/activate && black .
	. $(VENV)/bin/activate && isort .

# Run the application
run:
	@echo "Running the application..."
	. $(VENV)/bin/activate && $(PYTHON) app.py

# Clean temporary files
clean:
	@echo "Cleaning up temporary files..."
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

# Reset the environment
reset:
	@echo "Resetting environment..."
	rm -rf $(VENV)
	$(PYTHON) -m venv $(VENV)
	. $(VENV)/bin/activate && $(PIP) install --upgrade pip
	. $(VENV)/bin/activate && $(PIP) install $(DEPENDENCIES)

# Sync with GitHub
sync:
	@echo "Pulling latest changes from GitHub..."
	git fetch origin
	git pull origin $(BRANCH)

# Commit and push changes
push:
	@echo "Committing and pushing changes..."
	git add .
	git commit -m "Update: $(shell date '+%Y-%m-%d %H:%M:%S')"
	git push origin $(BRANCH)
