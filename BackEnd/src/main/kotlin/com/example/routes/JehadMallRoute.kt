package com.example.routes


import com.example.data.model.ProductResponse
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.JehadMallRoute() {
    // create a mutable list of fruits
    val Products = listOf(
        ProductResponse("3073781099324"),
        ProductResponse("3228857000869"),
        ProductResponse("3760020506605"),
        ProductResponse("8000500309469"),
        ProductResponse("3240931545066"),
        ProductResponse("7622300719302"),
        ProductResponse("5010029219241"),
        ProductResponse("7613033687884"),
        ProductResponse("3083680025881"),
        ProductResponse("3033491350795"),

    )

    get("/Jehadmall") {
        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products)
    }
    get("/Jehad/{barcode?}") {
        // get the id from the parameters if no id is passed return the full list
        val id = call.parameters["barcode"] ?: return@get call.respond(HttpStatusCode.OK, Products)

        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products.filter { it.barcode == id })
    }
}