package com.example.routes


import com.example.data.model.ProductResponse
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.FaalRout() {
    // create a mutable list of fruits
    val Products = listOf(
        ProductResponse("4000540000108"),
        ProductResponse("7622210100917"),
        ProductResponse("8410188012092"),
        ProductResponse("3182180012190"),
        ProductResponse("3560070614202"),
        ProductResponse("0043000201350"),
        ProductResponse("8480000168832"),
        ProductResponse("5053827184717"),
        ProductResponse("3498425591253"),
        ProductResponse("7613033687884"),

        )

    get("/Faal") {
        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products)
    }
    get("/Faal/{barcode?}") {
        // get the id from the parameters if no id is passed return the full list
        val id = call.parameters["barcode"] ?: return@get call.respond(HttpStatusCode.OK, Products)

        // define the status code we would like to return, and return the list which will be converted automatically to Json
        call.respond(HttpStatusCode.OK, Products.filter { it.barcode == id })
    }
}