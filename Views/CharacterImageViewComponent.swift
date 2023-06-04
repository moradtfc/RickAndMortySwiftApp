import SwiftUI
import SDWebImageSwiftUI

struct CharacterImageViewComponent: View {
    let url: String
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
        
    }
    
}
