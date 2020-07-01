# buildkite-agent-metrics

- Chart can be found at github [seanson/charts-buildkite-agent-metrics](https://github.com/seanson/charts-buildkite-agent-metrics)
- Installs Buildkite Agent Metrics [buildkite/buildkite-agent-metrics](https://github.com/buildkite/buildkite-agent-metrics)

Current chart version is `0.1.7`

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| buildkite.backend | string | `"prometheus"` | The name of the backend to use (e.g. cloudwatch, statsd, prometheus or stackdriver). |
| buildkite.cloudwatchDimensions | string | `""` |  |
| buildkite.queue | string | `""` | A comma separated list of Buildkite queues to process (e.g. backend-deploy,ui-deploy). All queues are published if no queue is specified. |
| buildkite.quiet | string | `"false"` | A boolean specifying that only ERROR log lines must be printed. (e.g. 1, true). |
| buildkite.token | string | `""` | The Buildkite agent API token to use. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"seanson/buildkite-metrics-agent"` |  |
| image.tag | string | `"v5.2.0"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"chart-example.local"` |  |
| ingress.path | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `10` |  |
| livenessProbe.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.httpGet.port | int | `8080` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| podAnnotations."prometheus.io/port" | string | `"8080"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| readinessProbe.httpGet.path | string | `"/metrics"` |  |
| readinessProbe.httpGet.port | int | `8080` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| service.enabled | bool | `false` |  |
| service.port | int | `80` |  |
| service.targetport | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.path | string | `"/metrics"` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| tolerations | list | `[]` |  |

## Development

### Requirements

Install the Helm plugin for managing versions:

```bash
helm plugin install https://github.com/mbenabda/helm-local-chart-version
```

### Helm Development

Charts should be developed with Helm3 compatability in mind with Kubernetes 1.14 as the target for API versioning.

Terratest based tests are stored in [tests](./tests) with a public golang Docker container used as a testing basis. Tests can be run with

```bash
make docker-test
```

Or if you have the golang libraries locally:

```bash
make test
```

### Chart Versioning

All charts should share the same semantic versioning with backwards compatability based on users having to change their `values.yaml` structures. Versions should be changed in `Chart.yaml`, the header of this `README.md`, given a git tag. Changes should be documented in `CHANGELOG.md`.

Please use one of the following `make` targets to bump versions:

Backwards compatible change:

```bash
make bump-patch
```

Backwards compatible but minor changes required (Please add to CHANGELOG.md!)

```bash
make bump-minor
```

Major incomaptible changes, expectation to uninstall and reinstall (Please add to CHANGELOG.md!)

```bash
make bump-major
```

### Documentation

Chart documentation is generated via [helm-docs](https://github.com/norwoodj/helm-docs) and templated via README.md.gotmpl. Once generated they are then formatted with the VS Code default markdown formatter.
