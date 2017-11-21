//
//  BooksData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct AllBooks:Codable {
    var items: [Book]
}
struct Book: Codable {
    var volumeInfo: VolumeInfoWraper
    var saleInfo: SaleInfoWraper
}
struct VolumeInfoWraper: Codable {
    var title: String
    var authors: [String]
    var publisher: String
    var subtitle: String?
    var pageCount: Int?
    var description: String?
    var imageLinks: ImageWraper
    var averageRating: Double?
    var ratingsCount: Int?
    var categories: [String]?
    var industryIdentifiers: [industryIdentifiersWraper]

}
struct industryIdentifiersWraper: Codable {
    var type: String
    var identifier: String
}
struct SaleInfoWraper: Codable {
    var listPrice: PriceWraper
}
struct PriceWraper: Codable {
    var amount: Double
    var currencyCode: String
}
struct ImageWraper: Codable {
    var smallThumbnail: String
    var thumbnail: String
}







