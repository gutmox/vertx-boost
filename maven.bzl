load("@rules_jvm_external//:defs.bzl", "maven_install")

def maven():
    maven_install(
        name = "maven",
        artifacts = [
            "io.vertx:vertx-web:3.9.1",
            "io.vertx:vertx-web-client:3.9.1",
            "io.vertx:vertx-core:3.9.1",
            "io.vertx:vertx-rx-java2:3.9.1",
            "io.vertx:vertx-rx-java2:3.9.1",
            "io.netty:netty-transport:4.1.49.Final",
            "javax.xml.soap:javax.xml.soap-api:1.4.0",
            "javax.xml.bind:jaxb-api:2.3.1",
            "com.sun.xml.messaging.saaj:saaj-impl:1.5.1",
            "javax.activation:activation:1.1",
            "org.glassfish.jaxb:jaxb-runtime:2.3.0"
        ],
        repositories = [
            "https://repo1.maven.org/maven2",
        ],
        fetch_sources = True,
    )

    maven_install(
	    name = "maven_test",
	    artifacts = [
		    "io.vertx:vertx-junit5:3.9.1",
		    "org.assertj:assertj-core:3.16.1",
		    "org.junit.jupiter:junit-jupiter-engine:5.6.2",
		    "org.junit.jupiter:junit-jupiter-api:5.6.2",
		    "org.junit.platform:junit-platform-console:1.5.2",
		    "org.apache.httpcomponents:httpclient:4.5.7",
		    "org.mockito:mockito-junit-jupiter:2.23.0",
		    "org.mockito:mockito-core:2.23.0",
	    ],
	    repositories = [
		    "https://repo1.maven.org/maven2",
	    ],
	    fetch_sources = True,
    )