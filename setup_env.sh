#!/bin/bash

set -e  # Останавливаем выполнение при ошибке

# Собираем кастомный образ для Ubuntu
echo "Строим кастомный Docker-образ для Ubuntu с Python..."
docker build -t custom_ubuntu -f ubuntu/Dockerfile .

# Собираем кастомный образ для CentOS
echo "Строим кастомный Docker-образ для CentOS с Python..."
docker build -t custom_centos -f centos/Dockerfile .

# Запускаем образ для Ubuntu с кастомным образом
echo "Запуск Docker-контейнера Ubuntu..."
docker run -d --name ubuntu --rm --privileged custom_ubuntu sleep infinity

# Запускаем образ для CentOS
echo "Запуск Docker-контейнера CentOS 7..."
docker run -d --name centos7 --rm --privileged custom_centos sleep infinity

# Запускаем образ для Fedora
echo "Запуск Docker-контейнера Fedora..."
docker run -d --name fedora --rm --privileged pycontribs/fedora sleep infinity

# Запускаем Ansible playbook
echo "Запуск Ansible playbook..."
ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-pass

# Остонавливаем все контейнеры
echo "Остановка контейнеров..."
docker stop ubuntu centos7 fedora

echo "Готово!"
