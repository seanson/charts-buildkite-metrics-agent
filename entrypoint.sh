#!/bin/bash

EXTRA_ARGS=""
BUILDKITE_INTERVAL="${BUILDKITE_INTERVAL:-30s}"
BUILDKITE_BACKEND="${BUILDKITE_BACKEND:-prometheus}"
BUILDKITE_STACKDRIVER_PROJECTID="${BUILDKITE_STACKDRIVER_PROJECTID:-}"
BUILDKITE_CLOUDWATCH_DIMENSIONS="${BUILDKITE_CLOUDWATCH_DIMENSIONS:-}"

if [ "${BUILDKITE_QUEUE}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -queue='${BUILDKITE_QUEUE}'"
fi

if [ "${BUILDKITE_STACKDRIVER_PROJECTID}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -stackdriver-projectid='${BUILDKITE_STACKDRIVER_PROJECTID}'"
fi

if [ "${BUILDKITE_CLOUDWATCH_DIMENSIONS}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -stackdriver-projectid='${BUILDKITE_CLOUDWATCH_DIMENSIONS}'"
fi

if [ "${BUILDKITE_QUEUE}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -queue='${BUILDKITE_QUEUE}'"
fi

exec /buildkite-agent-metrics -token="${BUILDKITE_AGENT_TOKEN}" \
                              -backend="${BUILDKITE_BACKEND}" \
                              -interval="${BUILDKITE_INTERVAL}" \
                              $EXTRA_ARGS
