# Use uma imagem base do Python
FROM python:3.12

# Instale pacotes necessários (PostgreSQL client, RabbitMQ e dependências do Celery)
RUN apt-get update && apt-get install -y \
    libpq-dev gcc rabbitmq-server \
    && rm -rf /var/lib/apt/lists/*

# Configure o diretório de trabalho
WORKDIR /code

# Copie o requirements.txt
COPY requirements.txt requirements.txt

# Instale as dependências do projeto, incluindo Celery
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Exponha as portas do RabbitMQ e do servidor Django
EXPOSE 5672 15672 8000

# Copie o código do projeto
COPY . .

# Script de inicialização para RabbitMQ, Django e Celery
COPY stash.sh /start.sh

RUN chmod +x /start.sh

# Comando para rodar o script de inicialização
CMD ["/bin/bash", "start.sh"]