#!/bin/bash

EXTRA_ARGS=""
BUILDKITE_INTERVAL="${BUILDKITE_INTERVAL:-30s}"
BUILDKITE_BACKEND="${BUILDKITE_BACKEND:-prometheus}"
BUILDKITE_STACKDRIVER_PROJECTID="${BUILDKITE_STACKDRIVER_PROJECTID:-}"
BUILDKITE_CLOUDWATCH_DIMENSIONS="${BUILDKITE_CLOUDWATCH_DIMENSIONS:-}"

if [ "${BUILDKITE_QUEUE}" != "" ]; then
    echo "Configuring run for single queue ${BUILDKITE_QUEUE}"
    EXTRA_ARGS="${EXTRA_ARGS} -queue ${BUILDKITE_QUEUE}"
fi

if [ "${BUILDKITE_STACKDRIVER_PROJECTID}" != "" ]; then
    echo "Configuring stackdriver project id: ${BUILDKITE_STACKDRIVER_PROJECTID}"
    EXTRA_ARGS="${EXTRA_ARGS} -stackdriver-projectid ${BUILDKITE_STACKDRIVER_PROJECTID}"
fi

if [ "${BUILDKITE_CLOUDWATCH_DIMENSIONS}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -cloudwatch-dimension ${BUILDKITE_CLOUDWATCH_DIMENSIONS}"
fi

exec /buildkite-agent-metrics -token="${BUILDKITE_AGENT_TOKEN}" \
                              -backend="${BUILDKITE_BACKEND}" \
                              -interval="${BUILDKITE_INTERVAL}" \
                              $(echo $EXTRA_ARGS)
