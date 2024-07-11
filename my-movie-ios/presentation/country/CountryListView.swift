//
//  ContentView.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

import SwiftUI

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                HStack {
//                    Image(country.imageName)
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    AsyncImage(url: URL(string: country.imageName)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(width: 50, height: 50)
                        case .success(let image):
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        case .failure(_):
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading, content: {
                        Text(country.name)
                            .font(.headline)
                        Text(country.population)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    })
                }
            }
            .navigationTitle("Countries")
            .onAppear() {
                viewModel.loadCountries()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

//let repository = CountryRepositoryImpl()
//let useCase = FetchCountriesUseCase(repository: repository)
//let viewModel = CountryListViewModel(fetchCountriesUseCase: useCase)
//#Preview {
//    CountryListView(viewModel: viewModel)
//}
