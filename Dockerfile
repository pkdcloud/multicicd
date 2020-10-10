FROM docker

WORKDIR /workdir

RUN apk --no-cache update 
RUN apk --no-cache upgrade
RUN apk --no-cache add --upgrade py3-pip make zip git curl python3 openssl openssh-client bash gettext
RUN apk --no-cache --virtual build-deps add gcc python3-dev openssl-dev libffi-dev musl-dev
RUN pip3 install --no-cache-dir --upgrade pip docker-compose awscli
RUN apk del build-deps

COPY ci ci
COPY compose compose
COPY make make

CMD [ "make" ]
