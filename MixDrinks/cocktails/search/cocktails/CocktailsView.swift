//
//  ContentView.swift
//  MixDrinks
//
//  Created by Vova Stelmashchuk on 09.06.2022.
//
//

import SwiftUI

struct CocktailsView: View {

    @EnvironmentObject var viewModel: CocktailsViewModel

    @State private var showingFilter = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Коктейлі")
                            .font(.body)
                            .padding()

                    Spacer()

                    Button(action: { showingFilter.toggle() }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                            .sheet(isPresented: $showingFilter) {
                                VStack {
                                    FilterView(close: { showingFilter.toggle() })
                                }
                            }
                            .preferredColorScheme(.light)
                }
                        .padding(.horizontal)

                CocktailsListContent(cocktails: viewModel.cocktails)
            }
                    .navigationBarHidden(true)
        }
                .navigationViewStyle(.stack)
    }
}

struct CocktailsListContent: View {

    var cocktails: [CocktailUiModel]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(cocktails) { cocktail in
                    NavigationLink {
                        CocktailDetails(cocktailId: cocktail.id, cocktailName: cocktail.name)
                    } label: {
                        CocktailCard(cocktail: cocktail)
                    }
                }
            }
        }
    }
}

struct CocktailCard: View {
    var cocktail: CocktailUiModel

    var body: some View {
        HStack {
            AsyncImage(
                    url: URL(string: "https://image.mixdrinks.org/cocktails/\(cocktail.id)/320/\(cocktail.id).jpg"),
                    content: { image in
                        image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                    },
                    placeholder: {
                        ProgressView()
                    }
            )
                    .frame(maxWidth: 100, alignment: .leading)

            Text(cocktail.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
        }
                .frame(height: 100)
                .padding(.horizontal)
    }
}
