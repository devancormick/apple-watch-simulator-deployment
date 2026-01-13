import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "applewatch")
                .imageScale(.large)
                .foregroundColor(.blue)
            Text("Hello, Watch!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
