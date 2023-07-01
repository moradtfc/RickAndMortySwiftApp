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
                                NavigationLink(destination: CharacterDetailView(viewModelCharacter: characterViewModel, viewModel: CharacterDetailViewModel(character: character, characterViewModel: characterViewModel), character: character)) {
                                    CharacterCellViewComponent(character: character)
                                }
                                .onAppear(){
                                    if characterViewModel.characters.last == character {
                                        characterViewModel.loadMoreCharacters()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical, 40)
                        .padding(.horizontal,20)
                        
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
