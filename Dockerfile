FROM docker

WORKDIR /workdir

RUN apk --no-cache update && apk --no-cache upgrade \
    && apk --no-cache add --upgrade make zip git curl python3 openssl openssh-client bash gettext \
    && apk --no-cache --virtual build-deps add gcc python3-dev openssl-dev libffi-dev musl-dev \
    && pip3 install --no-cache-dir --upgrade pip3 docker-compose awscli \
    && apk del build-deps

COPY ci ci
COPY compose compose
COPY make make

CMD [ "make" ]
