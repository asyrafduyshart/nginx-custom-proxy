FROM asyrafduyshart/go-reverse-proxy:1.0.0  as builder

FROM asyrafduyshart/nginx-ddos-redirect:normal

RUN apt-get update

RUN apt-get install musl

RUN apt -y install nano

RUN apt -y install supervisor

COPY --from=builder /root/app /usr/local/bin/app

ADD service_script.conf /etc/supervisor/conf.d/supervisord.conf

# Initializing Redis server and Gunicorn server from supervisors
CMD ["/usr/bin/supervisord"]