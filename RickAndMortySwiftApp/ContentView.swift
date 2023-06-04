import SwiftUI

struct ContentView: View {
    @State private var showWelcomeView = true
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            if showWelcomeView {
                WelcomeAppView()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3)
                        {
                            withAnimation(.interpolatingSpring(stiffness: 50, damping: 25)) {
                                showWelcomeView = false
                            }
                        }
                    }
                    .opacity(showWelcomeView ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: showWelcomeView)
            }
            
            
            else {
                TabView {
                    CharacterListView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    CharacterSearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                }
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

