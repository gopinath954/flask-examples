FROM python:3.9-slim

WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y gcc python3-dev
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]
