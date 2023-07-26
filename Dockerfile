FROM python:3.9
# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs && apt-get install -y npm

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN pip install -r requirements.txt

COPY . /app/backend
# Set working directory for frontend
WORKDIR /app/backend/mynotes

# Install frontend dependencies
COPY mynotes/package.json mynotes/package-lock.json /app/backend/mynotes/
RUN npm install

# Build ReactJS frontend
RUN npm run build

EXPOSE 8000
# Volume
VOLUME /app/backend/media
VOLUME /app/backend/static
VOLUME todo-db

CMD python /app/backend/manage.py runserver 0.0.0.0:8000
