FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN pip install -r requirements.txt

COPY . /app/backend
# Set working directory for frontend
WORKDIR /app/frontend

# Install frontend dependencies
COPY mynotes/package.json mynotes/package-lock.json /app/frontend/
RUN npm install

# Build ReactJS frontend
RUN npm run build

EXPOSE 8000

CMD python /app/backend/manage.py runserver 0.0.0.0:8000
