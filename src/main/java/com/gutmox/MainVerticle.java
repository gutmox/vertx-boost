package com.gutmox;

import com.gutmox.soap.SoapParser;
import com.gutmox.soap.model.GetOrdersHistoryResponse;
import com.gutmox.soap.model.OrderStatus;
import io.reactivex.Completable;
import io.reactivex.Single;
import io.vertx.core.json.JsonObject;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.reactivex.core.AbstractVerticle;
import io.vertx.reactivex.core.http.HttpServer;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;
import io.vertx.reactivex.ext.web.handler.BodyHandler;
import java.util.Arrays;
import java.util.List;

public class MainVerticle extends AbstractVerticle {

	private static final String HEALTH_CHECK = "/health";
	private static final String HELLO = "/hello";
	private static final String SOAP = "/soap";
	private static final String ROOT = "/";

	private static final Logger LOGGER = LoggerFactory.getLogger(MainVerticle.class.getName());
	private final String HOST = "0.0.0.0";
	private final Integer PORT = 8080;
	private SoapParser soapParser = new SoapParser();

	@Override
	public Completable rxStart() {
		vertx.exceptionHandler(error -> LOGGER.info(
			error.getMessage() + error.getCause() + Arrays.toString(error.getStackTrace()) + error
				.getLocalizedMessage()));

		return createRouter().flatMap(router -> startHttpServer(HOST, PORT, router))
			.flatMapCompletable(httpServer -> {
				LOGGER.info("HTTP server started on http://{0}:{1}", HOST, PORT.toString());
				return Completable.complete();
			});
	}

	private Single<Router> createRouter() {
		Router router = Router.router(vertx);
		router.post().handler(BodyHandler.create());
		router.get(HEALTH_CHECK).handler(this::healthCheck);
		router.get(HELLO).handler(this::hello);
		router.post(SOAP).handler(this::soap);
		router.get(ROOT).handler(this::hello);
		return Single.just(router);
	}

	private void soap(RoutingContext context) {
		String bodyAsString = context.getBodyAsString();
		GetOrdersHistoryResponse result = soapParser.getResult(bodyAsString, GetOrdersHistoryResponse.class);
		final List<OrderStatus> orderStatuses = result.getOrderStatuses();
		for (OrderStatus orderStatus : orderStatuses) {
			System.out.println(orderStatus);
		}
		System.out.println(bodyAsString);
		context.response().putHeader("content-type", "application/json")
			.end(new JsonObject().put("hello", "world").encode());
	}

	private void hello(RoutingContext context) {
		context.response().putHeader("content-type", "application/json")
			.end(new JsonObject().put("hello", "world").encode());
	}

	private void healthCheck(RoutingContext context) {
		context.response().putHeader("content-type", "application/json")
			.end(new JsonObject().put("status", "Show must go on").encode());
	}

	private Single<HttpServer> startHttpServer(String httpHost, Integer httpPort, Router router) {
		return vertx.createHttpServer().requestHandler(router).rxListen(httpPort, httpHost);
	}
}
