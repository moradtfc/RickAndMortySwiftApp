import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack { // Envolver en un ZStack
            Color.init(uiColor: UIColor(red: 0.23, green: 0.24, blue: 0.26, alpha: 1.00)) // Establecer color de fondo en el ZStack
                
            ScrollView {
                VStack {
                    Spacer(minLength: 0)
                    
                    CharacterImageViewComponent(url: viewModel.character.image)
                        .frame(height: UIScreen.main.bounds.height * 0.4)
                        .clipped()
                        .edgesIgnoringSafeArea(.top)
                        .aspectRatio(contentMode: .fill)
                    
                    CharacterDetailsViewComponent(viewModel: viewModel, characterViewModel: viewModel.characterViewModel)
                    
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
        )
    }
}





struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", origin: Location.init(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/3"), location: Location.init(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"))
        let characterViewModel = CharacterViewModel()
        let viewModel = CharacterDetailViewModel(character: character, characterViewModel: characterViewModel)
        CharacterDetailView(viewModel: viewModel)
    }
}

