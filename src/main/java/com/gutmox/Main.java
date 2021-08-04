package com.gutmox;

import io.netty.channel.DefaultChannelId;
import io.reactivex.Single;
import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.VertxOptions;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.reactivex.core.Vertx;

public class Main {

	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class.getName());

	@SuppressWarnings("CheckReturnValue")
	public static void main(String[] args) {
		DeploymentOptions deploymentOptions = new DeploymentOptions();
		deploymentOptions.setInstances(1);
		start(deploymentOptions)
			.subscribe(res -> LOGGER.info("Verticle running with id " + res.toLowerCase()),
				error -> {
					error.printStackTrace();
					LOGGER.error("Error starting !!!!!!!! " + error.getMessage());
				});
	}

	public static Single<String> start(DeploymentOptions deploymentOptions) {
		DefaultChannelId.newInstance();
		VertxOptions vertxOptions = new VertxOptions();
		vertxOptions.setEventLoopPoolSize(5);
		vertxOptions.setWorkerPoolSize(1);
		vertxOptions.setInternalBlockingPoolSize(1);
		return run(MainVerticle.class, vertxOptions, deploymentOptions).map(id -> {
			LOGGER.info("Main verticle ready and started <<<<<<<<<<<<<<<<<<<<<< " + id);
			return id;
		});
	}

	private static Single<String> run(Class<? extends AbstractVerticle> verticle, VertxOptions options,
		DeploymentOptions deploymentOptions) {
		final Vertx vertx = Vertx.vertx(options);
		return vertx.rxDeployVerticle(verticle.getName(), deploymentOptions);
	}
}
