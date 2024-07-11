//
//  MovieListView.swift
//  my-movie-ios
//
//  Created by wira on 11/07/24.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel: MovieListViewModel
    @ObservedObject var viewModelFavorite: FavoriteListViewModel
    
    @State private var showingFavoriteList = false
    @State private var showingSuccessMessage = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Movie Catalog")
                        .font(.largeTitle)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                    Button(action: {
                        showingFavoriteList = true
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .padding(.top, 16)
                            .padding(.trailing, 16)
                    }
                    .sheet(isPresented: $showingFavoriteList) {
                        FavoriteListView(viewModel: viewModelFavorite)
                    }
                }
                
                SearchBar(text: $viewModel.searchQuery,
                          placeholder: "Search movies")
                .padding([.leading, .trailing], 16)
                
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                        .padding()
                }
                
                List(viewModel.movies) { movie in
                    HStack {
                        AsyncImage(url: URL(string: movie.imagePath)) { phase in
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
                            Text(movie.title)
                                .font(.headline)
                            Text(String(movie.rating))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.saveFavorite(movie: movie)
                            showingSuccessMessage = true
                        }) {
                            Image(systemName: "heart").foregroundColor(.red)
                        }
                        .alert(isPresented: $showingSuccessMessage) {
                            Alert(title: Text("Success"),
                                  message: Text(viewModel.successMessage),
                                  dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }
                .alert(item: .constant(viewModel.errorMessage)) { error in
                    Alert(title: Text("Error"),
                          message: Text(error.message),
                          dismissButton: .default(Text("OK"))
                    )
                }
                
            }
            
        }
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
