import SwiftUI

struct CharacterSearchView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarComponent(text: $searchText)
                    .padding(.horizontal)
                
                List(characterViewModel.filteredCharactersName(for: searchText)) { character in
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, characterViewModel: characterViewModel))) {
                        Text(character.name)
                    }
                }
            }
            .navigationTitle("Search Characters")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}


struct CharacterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSearchView()
    }
}
