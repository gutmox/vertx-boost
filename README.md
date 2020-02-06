# vertx-boost
vertx simple boost

## Building and running using Bazel

```
bazel run :service
```  

## Running from IntelliJ

![IntelliJ](https://github.com/gutmox/vertx-boost/raw/master/docs/intellij.png)  

### Building docker container

```
bazel build :container
```
#### Publishing docker image

```
bazel run :container
```

### Generating fat jar

```
bazel build :run_deploy.jar
```

