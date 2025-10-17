FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY .github .github

EXPOSE 7860

CMD ["flask", "run", "--host=0.0.0.0", "--port=7860"]

