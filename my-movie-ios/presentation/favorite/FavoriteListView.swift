//
//  FavoriteListView.swift
//  my-movie-ios
//
//  Created by wira on 11/07/24.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject var viewModel: FavoriteListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteMovies) { favorite in
                HStack {
                    AsyncImage(url: URL(string: favorite.imagePath)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(width: 50, height: 50)
                        case .success(let image):
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(favorite.title)
                            .font(.headline)
                        Text(String(favorite.rating))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear(perform: viewModel.fetchFavorites)
            .navigationTitle("Favorite Movies")
        }
    }
}

