#!/bin/bash

URL="https://github.com/fasca23/shvirtd-example-python"
DIR="/opt/app"


if ! command -v git &> /dev/null; then
    echo "Установливаю Git"
    sudo apt update && sudo apt install -y git
else
    echo "Git уже установлен"
fi

if [ ! -d $DIR ]; then
  echo "Создаю его каталог..."
  sudo mkdir -p  $DIR 
fi

cd $DIR || { echo "Не удалось перейти в каталог  $DIR"; exit 1; }

if [ ! -d "$DIR/.git" ]; then
    echo "Клонирование репозитория..."
    sudo git clone "$URL" $DIR
    echo "Репозиторий склонирован"
fi

if [ -f "compose.yaml" ]; then
  echo "Запуск проекта docker compose..."
  docker compose up -d --build
else
  echo "Файл compose.yaml не найден"
fi