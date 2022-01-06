FROM python:3.10.0-slim
ENTRYPOINT ["python"]
ARG ENV

# install dependencies
WORKDIR /tmp
COPY linux-packages.txt linux-packages.txt
RUN apt-get update && \
  apt-get install -yq --no-install-recommends \
  $(grep -vE '^#' linux-packages.txt) && \
  rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --no-input && rm requirements.txt
COPY tests/requirements.txt requirements-test.txt
RUN if [ "$ENV" = "TEST" ] ; then pip install -r requirements-test.txt --no-input && rm requirements-test.txt ; fi

WORKDIR /app

COPY . .
RUN if [ "$ENV" = "TEST" ] ; then make install-test; else make install ; fi

# edit below this line
