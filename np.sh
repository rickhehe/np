#!/bin/bash

# Check if the project name is passed as a parameter
if [ -z "$1" ]; then
    echo "Error: No project name provided."
    echo "Usage: ./create_project.sh <project_name>"
    exit 1
fi

# Set the project name from the first argument
projectName=$1

# Define the project structure
mkdir -p ./"$projectName"/{src,tests,docs}
touch ./"$projectName"/{Makefile,README.md,requirements.txt,setup.py,.gitignore,.pylintrc}
touch ./"$projectName"/src/{__init__.py,app.py,module1.py}
touch ./"$projectName"/tests/{__init__.py,test_module1.py}
touch ./"$projectName"/docs/index.md

# Populate basic Makefile content
cat <<EOL > $projectName/Makefile
.PHONY: install test lint format clean

install:
	pip install --updgrade pip &&
	    pip install -r requirements.txt

test:
    python -m pytest -vv test_app.py

format:
	black src/

lint:
    pylint --disable=R,C app.py

clean:
	# Remove Python cache files
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

all: install lint test clean
EOL

# Create a sample .gitignore
cat <<EOL > $projectName/.gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that don't work, or not
#   install all needed dependencies.
#Pipfile.lock

# PEP 582; used by e.g. github.com/David-OConnor/pyflow
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# Virtual environment
venv/
EOL

# Create a basic README.md
cat <<EOL > $projectName/README.md
# My Python Project

This is a basic Python project structure.

## Setup

1. Install dependencies:
    \`\`\`
    make install
    \`\`\`

2. Run tests:
    \`\`\`
    make test
    \`\`\`
EOL

# Output success message
echo "Project structure created successfully!"
