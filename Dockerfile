FROM asyrafduyshart/go-reverse-proxy:1.0.0  as builder

FROM asyrafduyshart/nginx-ddos-redirect:1.2.0

RUN apt-get update

RUN apt-get install musl

RUN apt -y install nano

RUN apt -y install supervisor

COPY --from=builder /root/app /usr/local/bin/app

ADD service_script.conf /src/supervisor/service_script.conf

# Initializing Redis server and Gunicorn server from supervisors
CMD ["supervisord","-c","/src/supervisor/service_script.conf"]