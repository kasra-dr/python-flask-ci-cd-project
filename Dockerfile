# 1. Base Image: Start from a official Python image
FROM python:3.9-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy the rest of the application code
COPY . . 

# Expose the port the app runs on
EXPOSE 5000

# 6. Command to run the application
CMD ["python3", "app.py"]

