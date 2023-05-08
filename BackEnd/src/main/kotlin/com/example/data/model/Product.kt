package com.example.data.model

import kotlinx.serialization.Serializable

@Serializable
data class ProductResponse(
    val barcode: String,
)