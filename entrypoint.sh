#!/bin/bash

EXTRA_ARGS=""
BUILDKITE_INTERVAL="${BUILDKITE_INTERVAL:-30s}"
BUILDKITE_BACKEND="${BUILDKITE_BACKEND:-prometheus}"

if [ "${BUILDKITE_QUEUE}" != "" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} -queue='${BUILDKITE_QUEUE}'"
fi

exec /buildkite-agent-metrics -token="${BUILDKITE_AGENT_TOKEN}" \
                              -backend="${BUILDKITE_BACKEND}" \
                              -interval="${BUILDKITE_INTERVAL}" \
                              $EXTRA_ARGS
