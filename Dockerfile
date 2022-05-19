FROM --platform=linux/amd64 asyrafduyshart/go-reverse-proxy  as builder

FROM --platform=linux/amd64 asyrafduyshart/nginx-ddos-redirect:1.2.0

RUN apt-get install musl

RUN apt -y install supervisor

COPY --from=builder /root/app /usr/local/bin/app

ADD service_script.conf /src/supervisor/service_script.conf
    
# Initializing Redis server and Gunicorn server from supervisors
CMD ["supervisord","-c","/src/supervisor/service_script.conf"]