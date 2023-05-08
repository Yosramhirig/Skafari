package com.example.routes


import com.example.data.model.ProductResponse
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.MamashRoute() {
    // create a mutable list of fruits
    val Products = listOf(
        ProductResponse("3245411253844"),
        ProductResponse("8000500023976"),
        ProductResponse("7613036443388"),
        ProductResponse("3032220061100"),
        ProductResponse("7613037059281"),
        ProductResponse("3083680025881"),
        ProductResponse("7622210100917"),
        ProductResponse("5060088707685"),
        ProductResponse("3168930009184"),
        ProductResponse("3228857000869"),
    )

    get("/Mamash") {
        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products)
    }
    get("/Mamash/{barcode?}") {
        // get the id from the parameters if no id is passed return the full list
        val id = call.parameters["barcode"] ?: return@get call.respond(HttpStatusCode.OK, Products)

        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products.filter { it.barcode == id })
    }
}