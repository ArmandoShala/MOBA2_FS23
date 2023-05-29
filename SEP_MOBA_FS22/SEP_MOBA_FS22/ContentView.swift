//
//  ContentView.swift
//  SEP_MOBA_FS22
//
//  Created by Armando Shala on 29.05.23.
//
//

import SwiftUI

struct ContentView: View {
    @State private var shoes = [ShoeRepresentation]()
    @State private var favorites = [ShoeRepresentation]()
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Text("Guten Tag Armando Shala").font(.title)
                    // add buttons to filter the list based on the prise. The buttons should be in a HStack. The buttons should be named "<100", "100 - 120", "120 - 150", "150 - 170", ">170"
                    HStack {
                        Button("<100") {
                            filterData(lowerPriceRange: "0", upperPriceRange: "100")
                        }
                        Button("100 - 120") {
                            filterData(lowerPriceRange: "100", upperPriceRange: "120")
                        }
                        Button("120 - 150") {
                            filterData(lowerPriceRange: "120", upperPriceRange: "150")
                        }
                        Button("150 - 170") {
                            filterData(lowerPriceRange: "150", upperPriceRange: "170")
                        }
                        Button(">170") {
                            filterData(lowerPriceRange: "170", upperPriceRange: "99999")
                        }
                        Button("Alle") {
                            loadData()
                        }
                    }
                            .buttonStyle(ToggleButton())
                    List {
                        ForEach(shoes) {
                            shoe in
                            HStack(alignment: .center) {
                                AsyncImage(url: URL(string: shoe.bild)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 100)
                                        .border(Color.black, width: 1)
                                        .padding(10)
                                Spacer()
                                Text(shoe.name).font(.headline)
                                Spacer()
                                Text(shoe.preis + " CHF").font(.subheadline)
                                        .padding(.trailing, 10)
                                // add a button to mark as favorite
                                Button(action: {
                                    addToFavorites(shoe: shoe)
                                }) {
                                    Image(systemName: "heart.fill")
                                            .foregroundColor(favorites.contains(where: { $0.name == shoe.name }) ? .red : .gray)
                                            .padding(.trailing, 10)
                                }
                            }
                                    .border(Color.black, width: 1)
                        }
                    }
                }
            }
                    .onAppear(perform: loadData)
                    .refreshable(action: loadData)
                    .tabItem {
                        Label("Produkte", systemImage: "cart")
                    }
            NavigationView {
                VStack {
                    List {
                        ForEach(favorites) {
                            shoe in
                            HStack(alignment: .center) {
                                AsyncImage(url: URL(string: shoe.bild)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 100)
                                        .border(Color.black, width: 1)
                                        .padding(10)
                                Spacer()
                                Text(shoe.name).font(.headline)
                                Spacer()
                                Text(shoe.preis + " CHF").font(.subheadline)
                                        .padding(.trailing, 10)
                                // add a button to mark as favorite
                                Button(action: {
                                    addToFavorites(shoe: shoe)
                                }) {
                                    Image(systemName: "heart.fill")
                                            .foregroundColor(favorites.contains(where: { $0.name == shoe.name }) ? .red : .gray)
                                            .padding(.trailing, 10)
                                }
                            }
                                    .border(Color.black, width: 1)
                        }
                    }
                            .frame(maxHeight: 600)
                            .listStyle(PlainListStyle())
                    if favorites.isEmpty {
                        Text("Keine Favoriten").font(.title)
                    } else {
                        HStack {
                            Text("Total").font(.title)
                            Spacer()
                            Text("\(favorites.reduce(0, { $0 + Int($1.preis)! })) CHF").font(.title)
                                    .font(Font.custom("Serif", size: 30))
                                    .italic()
                                    .bold()
                        }
                                .padding(30)
                    }

                }
            }
                    .tabItem {
                        Label("Wunschliste", systemImage: "heart")
                    }
        }
    }

    func loadData() {
        DispatchQueue.global().async {
            guard let file = Bundle.main.url(forResource: "shoes", withExtension: "json") else {
                fatalError("Couldn't find json in main bundle.")
            }
            do {
                let jsonData = try Data(contentsOf: file)
                // check the structure of the json file: the results
                let shoes = try JSONDecoder().decode(JsonRepresentation.self, from: jsonData).results
                DispatchQueue.main.async {
                    self.shoes = shoes
                }
            } catch {
                fatalError("Couldn't load file from main bundle:\n\(error)")
            }
        }
    }

    func filterData(lowerPriceRange: String, upperPriceRange: String) {
        DispatchQueue.global().async {
            guard let file = Bundle.main.url(forResource: "shoes", withExtension: "json") else {
                fatalError("Couldn't find json in main bundle.")
            }
            do {
                let jsonData = try Data(contentsOf: file)
                // check the structure of the json file: the results
                let shoes = try JSONDecoder().decode(JsonRepresentation.self, from: jsonData).results
                DispatchQueue.main.async {
                    self.shoes = shoes.filter({ Int($0.preis)! >= Int(lowerPriceRange)! && Int($0.preis)! < Int(upperPriceRange)! })
                }
            } catch {
                fatalError("Couldn't load file from main bundle:\n\(error)")
            }
        }
    }

    func addToFavorites(shoe: ShoeRepresentation) {
        if favorites.contains(where: { $0.name == shoe.name }) {
            favorites.remove(at: favorites.firstIndex(where: { $0.name == shoe.name })!)
        } else {
            favorites.append(shoe)
        }
    }

    struct JsonRepresentation: Decodable {
        // this represents the outermost level of the json file. Each variable name and type must match the corresponding key in the json
        let resultCount: Int
        let results: [ShoeRepresentation]
    }

    struct ShoeRepresentation: Identifiable, Decodable {
        // this represents the level of the results array. Each variable name and type must match the corresponding key in the json
        let id = UUID()
        let name: String
        let preis: String
        let bild: String
    }

    struct ToggleButton: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                    .foregroundColor(.black)
                    .background(configuration.isPressed ? Color.blue : Color.white)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
