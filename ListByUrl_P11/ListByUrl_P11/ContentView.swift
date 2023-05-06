//
//  ContentView.swift
//  ListByUrl_P11
//
//  Created by Armando Shala on 06.05.23.
//
//

import SwiftUI


struct JsonResponse: Decodable {
    var resultCount: Int
    var results: [Album]
}

struct Album: Codable, Identifiable {
    var id: Int {
        get {
            UUID().uuidString.hashValue
        }
    }
    let wrapperType: String
    let collectionType: String
    let artistId: Int
    let collectionId: Int
    let amgArtistId: Int
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
}


struct ContentView: View {
    @State var data = [Album]()
    var body: some View {
        NavigationStack {
            List {
                ForEach(data) { album in
                    Text(album.collectionName)
                }
            }
                    .task {
                        await loadData()
                    }
        }
                .padding()
    }

    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=rolling+stones&entity=album") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(JsonResponse.self, from: data) {
                self.data = decodedResponse.results
            } else {
                print("Invalid response from server")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
