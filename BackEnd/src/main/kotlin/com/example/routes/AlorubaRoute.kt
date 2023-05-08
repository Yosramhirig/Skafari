package com.example.routes



import com.example.data.model.ProductResponse
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.AlorubaRoute() {
    // create a mutable list of fruits
    val Products = listOf(
        ProductResponse("3366321052386"),
        ProductResponse("3033710065967"),
        ProductResponse("8715700407760"),
        ProductResponse("5010029219241"),
        ProductResponse("4008400260921"),
        ProductResponse("5000159492737"),
        ProductResponse("5060088707685"),
        ProductResponse("3017760038409"),
        ProductResponse("3168930009184"),
        ProductResponse("3073781149838"),



    )

    get("/Aloruba") {
        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products)
    }

    get("/Aloruba/{barcode?}") {
        // get the id from the parameters if no id is passed return the full list
        val id = call.parameters["barcode"] ?: return@get call.respond(HttpStatusCode.OK, Products)

        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products.filter { it.barcode == id })
    }
}