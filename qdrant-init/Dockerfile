FROM python:3.11-slim

WORKDIR /app

# Install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy initialization script
COPY init.py .

# Make script executable
RUN chmod +x init.py

# Run the initialization script
CMD ["python", "init.py"]
