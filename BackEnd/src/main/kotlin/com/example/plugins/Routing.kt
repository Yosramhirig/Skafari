package com.example.plugins



import com.example.routes.AlorubaRoute
import com.example.routes.FaalRout
import com.example.routes.JehadMallRoute
import com.example.routes.MamashRoute
import io.ktor.server.routing.*
import io.ktor.server.application.*

fun Application.configureRouting() {
    routing {
        JehadMallRoute()
        AlorubaRoute()
        FaalRout()
        MamashRoute()


    }
}
