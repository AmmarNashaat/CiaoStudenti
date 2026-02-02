import SwiftUI

struct CodiceFiscaleView: View {
    var body: some View {
        ZStack {
            Image("codice_fiscale_full")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationTitle("Codice Fiscale")
        .navigationBarTitleDisplayMode(.inline)
    }
}
