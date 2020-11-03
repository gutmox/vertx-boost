package com.gutmox;

import io.reactivex.Single;
import io.vertx.core.json.JsonArray;
import io.vertx.junit5.VertxExtension;
import io.vertx.junit5.VertxTestContext;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.core.buffer.Buffer;
import io.vertx.reactivex.ext.web.client.HttpResponse;
import io.vertx.reactivex.ext.web.client.WebClient;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

@ExtendWith(VertxExtension.class)
public class RestClientTest {

	private static WebClient webClient;

	private final String value_added_services = "#the ab s URL";

	@BeforeAll
	static void setUp(){
		webClient = WebClient.create(Vertx.vertx());
	}


	//@Test
	void check_returned_rest_entity(VertxTestContext testContext){

		getCatalogueAVS().subscribe(res ->{
			final JsonArray objects = res.bodyAsJsonArray();
			System.out.println(objects);
			testContext.completeNow();
		});
	}

	synchronized Single<HttpResponse<Buffer>> getCatalogueAVS() {

		return webClient.getAbs(value_added_services)
			.putHeader("Accept", "application/json")
			.rxSend()
			.doOnError(Throwable::printStackTrace);
	}

}
