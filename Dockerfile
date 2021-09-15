FROM alpine/helm

ENV HELM_HOME /root/.helm

RUN apk add --update --no-cache git curl bash
RUN helm plugin install --debug https://github.com/xylene314/kubescan-helm


WORKDIR "/chart"

CMD ["kubesec", "scan", "."]
