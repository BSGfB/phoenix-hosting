FROM python:3.5-alpine

ADD ./src /src
WORKDIR /

RUN pip3 install -r /src/requirements.txt

EXPOSE 5000

CMD ["python3", "/src/app.py"]
