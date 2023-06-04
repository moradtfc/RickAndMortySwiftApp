import SwiftUI

struct SearchBarComponent: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .disableAutocorrection(true)
                .foregroundColor(.black)
            
            Button(action: {
                text = ""
                
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}

struct SearchBarComponent_Previews: PreviewProvider {
    @State static var searchText: String = ""
    
    static var previews: some View {
        SearchBarComponent(text: $searchText)
    }
}
