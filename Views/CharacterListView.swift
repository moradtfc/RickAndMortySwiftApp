import SwiftUI

struct CharacterListView: View {
    @StateObject var characterViewModel = CharacterViewModel()
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var isShowingFilters = false
    let filters: [Filter] = [
        Filter(title: "Gender", options: ["", "Male", "Female", "Genderless", "Unknown"]),
        Filter(title: "Status", options: ["", "Alive", "Dead", "Unknown"])
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if characterViewModel.characters.isEmpty {
                    ProgressView()
                } else {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridItems, spacing: 20) {
                            ForEach(characterViewModel.filteredCharacters()) { character in
                                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, characterViewModel: characterViewModel))) {
                                    CharacterCellViewComponent(character: character)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical, 40)
                        .padding(.horizontal,20)
                        
                        HStack {
                            
                            if characterViewModel.hasMorePages {
                                Spacer()
                                Button(action: {
                                    characterViewModel.loadMoreCharacters()
                                }) {
                                    Text("Load More")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(.orange)
                                        .cornerRadius(5)
                                        .fontWeight(.bold)
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarTitle("Characters List", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                isShowingFilters = true
            }) {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
            }
            )
            .sheet(isPresented: $isShowingFilters) {
                FilterSelectionView(
                    selectedGender: $characterViewModel.selectedGender,
                    selectedStatus: $characterViewModel.selectedStatus,
                    isShowing: $isShowingFilters,
                    onApply: {
                        isShowingFilters = false
                    }
                )
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

