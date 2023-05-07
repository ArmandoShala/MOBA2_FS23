//
// Created by Armando Shala on 07.05.23.
//

import Foundation

struct JsonResponseAlbum: Decodable {
    var resultCount: Int
    var results: [Album]
}

struct Album: Codable, Identifiable, Hashable {
    var id: Int {
        get {
            UUID().uuidString.hashValue
        }
    }
    let wrapperType: String
    let collectionType: String
    let artistId: Int
    let collectionId: Int
    let amgArtistId: Int?
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: String?
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String
    let country: String
    let currency: String
    var releaseDate: String

//    var releaseDate: String {
//        get {
    // format releaseDate from yyyy-MM-ddT00:00:00Z to yyyy
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//            let date = dateFormatter.date(from: self.releaseDate)
//            dateFormatter.dateFormat = "yyyy"
//            return dateFormatter.string(from: date!)
//            return String(self.releaseDate.prefix(4))
//        }
//
//    }

    let primaryGenreName: String
}
