FROM python:3

RUN apt-get update -y && \
    pip install --no-cache-dir "uvicorn[standard]" gunicorn && \
    pip install --no-cache-dir fastapi

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./app /app
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 8080
ENV BIND="0.0.0.0:8080"

CMD ["/start.sh"]