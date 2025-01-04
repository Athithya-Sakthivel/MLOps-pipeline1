# Variables
PYTHON := python
PIP := pip
BRANCH := main

# List of dependencies
DEPENDENCIES := flask flake8 unittest black isort

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
	@echo "  make sync           Sync with the latest changes from GitHub"
	@echo "  make push           Commit and push changes to the repository"
	@echo "  make clean          Clean up temporary files"
	@echo "  make reset          Reset the environment"
	@echo "  make start          Install and run the application"

# Install dependencies
install:
	@echo "Installing dependencies..."
	@if [ ! -d "venv" ]; then $(PYTHON) -m venv venv; fi
	. venv/bin/activate && $(PIP) install --upgrade pip
	. venv/bin/activate && $(PIP) install $(DEPENDENCIES)

# Run tests
test:
	@echo "Running tests..."
	. venv/bin/activate && $(PYTHON) -m unittest discover -s . -p "test_*.py"

# Run linter
lint:
	@echo "Running linter..."
	. venv/bin/activate && flake8 app.py

# Format code
format:
	@echo "Formatting code..."
	. venv/bin/activate && black app.py
	. venv/bin/activate && isort app.py

# Run the application
run:
	@echo "Running the application..."
	. venv/bin/activate && $(PYTHON) app.py

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

# Clean temporary files
clean:
	@echo "Cleaning up temporary files..."
	find . -type d -name "__pycache__" -delete
	find . -type f -name "*.pyc" -delete

# Reset environment
reset:
	@echo "Resetting environment..."
	rm -rf venv
	$(PYTHON) -m venv venv
	. venv/bin/activate && $(PIP) install $(DEPENDENCIES)

# Install and start the application
start:
	@echo "Installing dependencies and starting the application..."
	make install
	make run
