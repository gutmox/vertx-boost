load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "7d453450e1eb70e238eea6b31f4115607ec1200e91afea01c25f9804f37e39c8",
    strip_prefix = "rules_docker-0.10.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.10.0/rules_docker-v0.10.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
    "container_image",
    "container_push",
)

container_pull(
    name = "openjdk",
    registry = "registry.hub.docker.com",
    repository = "library/openjdk",
    digest = "sha256:31e765618b9d37e3e73aab362f5b867729007d87f473d26a1aa0a789a1cfea21",
)

load("//3rdparty:workspace.bzl", "maven_dependencies")
maven_dependencies()
load("//3rdparty:target_file.bzl", "build_external_workspace")
build_external_workspace(name = "third_party")