import SwiftUI

struct CharacterDetailsViewComponent: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    let characterViewModel: CharacterViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.details) { item in
                HStack(spacing: 5) {
                    Text(item.title)
                        .font(.headline)
                        .padding(.leading)
                    
                    if item.title == "Status:" {
                        Circle()
                            .fill(characterViewModel.getCircleColor(for: item.value))
                            .frame(width: 10, height: 10)
                    }
                    
                    Text(item.value)
                        .fontWeight(.bold)
                }
                
                Divider().frame(height: 1).background(Color.white)
            }
        }
        .foregroundColor(.white)
    }
}
