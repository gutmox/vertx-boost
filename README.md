# vertx-boost

vertx simple boost 

## Building and running using Bazel

```
bazel run :service
```

## Passing unit tests using Bazel

```
bazel test :tests
```  

## Running from an IDE

Simply run `com.gutmox.Main`  

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

