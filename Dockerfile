FROM python:3.9-slim

WORKDIR /app
COPY . /app
COPY requirements.txt .
RUN apt-get update && apt-get install -y gcc python3-dev
RUN pip install --upgrade pip
RUN pip install --default-timeout=100 --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]
