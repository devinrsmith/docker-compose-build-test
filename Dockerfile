FROM busybox
COPY . /
ENTRYPOINT ["/docker-entrypoint.sh"]
