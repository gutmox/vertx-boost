load("@rules_jvm_external//:defs.bzl", "maven_install")

def maven():
    maven_install(
        name = "maven",
        artifacts = [
            "io.vertx:vertx-web:3.8.5",
            "io.vertx:vertx-core:3.8.5",
            "io.vertx:vertx-rx-java2:3.8.5",
            "io.reactivex.rxjava2:rxjava:2.2.17",
        ],
        repositories = [
            "https://maven.google.com",
            "https://repo1.maven.org/maven2",
        ],
        fetch_sources = True,
    )