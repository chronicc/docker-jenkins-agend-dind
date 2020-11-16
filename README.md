Jenkins Agent Docker-in-Docker
==============================

Ready to use Jenkins Docker-in-Docker Agent docker image.

## Base Image

As base image the [Jenkins Inbound Agent](https://github.com/jenkinsci/docker-inbound-agent) is used and thus supports the same environment variables.

## Build

To get a general understanding of what the Makefile provides, run `make`. For more indept understanding of how the parameters and targets interconnect, inspect the `Makefile`.

### Local

To create an image based on the latest parent image run `make build`.

To create an image for a specific parent image version and publish it to the docker hub run `VERSION=X.Y.Z make publish IMAGE_VERSION=$VERSION PARENT_VERSION=$VERSION`. The make target uses your local configured docker login to push the image to the registry. If you want to use another login specify the `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` variables in the make command.

### Continuous Integration

For continuous integration all targets are written to not explicitly state dependencies. That way they can be used in custom build steps inside your CI tool. If you do this, ensure the artifacts of the single build steps are available for following steps. The `publish` target contains the order of build dependencies.

## Knowledge

* [Automation and Make](https://swcarpentry.github.io/make-novice/reference)

## License

* Docker Image: MIT
* Base Image: MIT

