FROM python:3.10-slim-trixie

LABEL org.opencontainers.image.source="https://github.com/sbOogway/internet_archive_downloader"
ARG APP_DIR=/usr/src/app

RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY . $APP_DIR

RUN pip install -r requirements.txt

ENTRYPOINT [ "python3", "archive-org-downloader.py" ]