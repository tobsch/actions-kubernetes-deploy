FROM ruby:latest

LABEL "name"="kubernetes-deploy"
LABEL "version"="1.0.0"
LABEL "maintainer"="Tobias Schlottke <ts@omr.com"

LABEL "com.github.actions.name"="GitHub Action for Kubernetes-Deploy"
LABEL "com.github.actions.description"="Wraps the Kubernetes-Deploy commands."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get update && apt-get -y --no-install-recommends install curl \
  && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && rm -rf /var/lib/apt/lists/*

RUN gem install kubernetes-deploy

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
