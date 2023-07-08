# docker-compose.production.yml
version: '3'

volumes:
  pg_data_production:
  static_volume:

# Всё отличие — заменяем build на image и указываем, какой образ использовать
services:
  db:
    image: postgres:13.10
    env_file: .env
    volumes:
      - pg_data_production:/var/lib/postgresql/data
  backend:
    image: qitoplu/taski_backend
    env_file: .env
    volumes:
      - static_volume:/backend_static
  frontend:
    image: qitoplu/taski_frontend  # Качаем с Docker Hub
    env_file: .env
    command: cp -r /app/build/. /frontend_static/
    volumes:
      - static_volume:/frontend_static
  gateway:
    image: qitoplu/taski_gateway  # Качаем с Docker Hub
    env_file: .env
    volumes:
      - static_volume:/staticfiles/
    ports:
      - 8000:80
