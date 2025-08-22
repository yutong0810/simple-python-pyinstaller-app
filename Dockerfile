# Use official Python base image
FROM python:3.10

# Set working directory inside the container
WORKDIR /app

# Copy your source code and requirements (if any)
COPY sources/ ./sources/
COPY requirements.txt ./

# Install dependencies (adjust if you have requirements.txt)
RUN pip install --no-cache-dir -r requirements.txt

# Install pytest and pyinstaller globally
RUN pip install pytest pyinstaller

# Copy tests if they are outside sources/
COPY sources/test_calc.py ./sources/

# Default command (optional)
CMD ["bash"]

