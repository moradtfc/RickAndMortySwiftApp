import SwiftUI
import SDWebImageSwiftUI

struct CharacterCellViewComponent: View {
    let character: Character
    var characterViewModel = CharacterViewModel()
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: character.image))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .indicator(.activity)
                .frame(width: 155, height: 150)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Circle()
                        .fill(characterViewModel.getCircleColor(for: character.status))
                        .frame(width: 10, height: 10)
                    Text(character.status)
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.white)
            .frame(width: 155, height: 110)
            .background(Color(red: 0.15, green: 0.17, blue: 0.20))
            .padding(.top, -8)
        }
    }
}
