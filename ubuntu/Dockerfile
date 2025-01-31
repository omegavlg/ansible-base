# Используем официальный образ Ubuntu
FROM ubuntu:latest

# Устанавливаем Python и необходимые пакеты, а затем очищаем кеш
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Делаем Python3 доступным как "python"
RUN ln -s /usr/bin/python3 /usr/bin/python

# Запуск в фоновом режиме
CMD ["sleep", "infinity"]
