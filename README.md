### Introduction

This Dockerfile runs Metal as a Service (MAAS) from Canonical in a Docker container.

To build:

```
  docker build --rm -t maas:latest .
```

To run:

```
  ./run.sh
```

Finish configuration by creating the admin account and finishing the setup in the Web UI.

