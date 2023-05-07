//
// Created by Armando Shala on 07.05.23.
//

import SwiftUI

struct DetailView: View {
    @State var track: [Track]
    var collectionName: String
    var releaseDate: String
    var artworkUrl100: String

    var body: some View {
        VStack {
            Text(collectionName)
            Text(releaseDate)
            AsyncImage(url: URL(string: artworkUrl100)) { image in
                image.fixedSize().frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            List {
                ForEach(track, id: \.self) { track in
                    HStack {
                        Text(track.trackName)
                        Spacer()
                    }
                }
            }
        }
                .onAppear {
                    Task {
                        do {
//                            https://itunes.apple.com/lookup?id=%3CcollectionId%3E&entity=song
                            track = try await loadData(url: "https://itunes.apple.com/lookup?id=\(track.collectionId)&entity=song")
                        } catch {
                            print(error)
                        }
                    }
                }
    }

    func loadData(url: String) async throws -> [Track] {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }

        let urlRequest = URLRequest(url: url)

        let (data, response): (Data, URLResponse)
        (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }

        let decodedResponse = try JSONDecoder().decode(JsonResponseTrack.self, from: data)
        return decodedResponse.results
    }

}