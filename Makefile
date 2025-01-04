# Variables
PYTHON := python
PIP := pip
REQUIREMENTS := requirements.txt
BRANCH := main

# Default target
.DEFAULT_GOAL := help

# Help command
help:
	@echo "Available commands:"
	@echo "  make install        Install dependencies"
	@echo "  make test           Run tests"
	@echo "  make lint           Run linter (flake8)"
	@echo "  make run            Run the application"
	@echo "  make sync           Sync with the latest changes from GitHub"
	@echo "  make push           Commit and push changes to the repository"
	@echo "  make clean          Clean up temporary files"

# Install dependencies
install:
	@echo "Installing dependencies..."
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)

# Run tests
test:
	@echo "Running tests..."
	$(PYTHON) -m unittest discover -s . -p "test_*.py"

# Run linter
lint:
	@echo "Running linter..."
	$(PIP) install flake8
	flake8 app.py

# Run the application
run:
	@echo "Running the application..."
	$(PYTHON) app.py

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
	. venv/bin/activate && $(PIP) install -r $(REQUIREMENTS)
clear-cache:
	@echo "Clearing GitHub Actions caches..."
	curl -X DELETE \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer $(GITHUB_TOKEN)" \
	"https://api.github.com/repos/REPO_OWNER/REPO_NAME/actions/caches"
