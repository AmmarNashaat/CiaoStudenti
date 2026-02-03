import SwiftUI
import MapKit

// This file now contains the "Blueprints" for your UI.
// You can use these anywhere in your app without writing them again!

struct OfficeSectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

struct OfficeLocationCard: View {
    let locationName: String
    let address: String
    let details: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(locationName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(details)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                    Text(address)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // --- MAPS BUTTON ---
                Button(action: openInMaps) {
                    HStack(spacing: 4) {
                        Text("Directions")
                        Image(systemName: "arrow.up.right.circle.fill")
                    }
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    // Function to trigger Apple Maps
    func openInMaps() {
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "http://maps.apple.com/?address=\(encodedAddress)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
