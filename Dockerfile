FROM ubuntu:20.04

RUN apt update && apt install --yes curl

ENV BUILDKITE_AGENT_METRICS_VERSION="v5.2.0"

RUN curl -L -o /buildkite-agent-metrics https://github.com/buildkite/buildkite-agent-metrics/releases/download/${BUILDKITE_AGENT_METRICS_VERSION}/buildkite-agent-metrics-linux-amd64 \
    && chmod +x /buildkite-agent-metrics

COPY entrypoint.sh /

EXPOSE 8080
ENTRYPOINT /entrypoint.sh
