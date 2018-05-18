FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache \
		uwsgi-python3 \
		uwsgi-http \
		python3

RUN pip3 install --no-cache-dir Django==2.0.5 pytz==2018.4

COPY  . .

RUN python3 pruebas/manage.py collectstatic

# RUN pip3 install --no-cache-dir -r requirements.txt 

VOLUME /logs
VOLUME /data
EXPOSE 80

CMD [ "uwsgi", "uwsgi.ini" ]
