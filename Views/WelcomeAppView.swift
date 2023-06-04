import SwiftUI

struct WelcomeAppView: View {
    var body: some View {
        VStack{
            Image("rick-and-morty-31013")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
            Text("Made by Jesús Mora")
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text("[https://github.com/moradtfc](https://github.com/moradtfc)")
        }
       
    }
}

struct WelcomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeAppView()
    }
}
