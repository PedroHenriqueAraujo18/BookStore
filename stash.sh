#!/bin/bash

# Inicie o RabbitMQ
service rabbitmq-server start

# Inicie o Celery como worker
celery  -A django_project worker --loglevel=info

# Inicie o servidor Django
python manage.py runserver 0.0.0.0:8000