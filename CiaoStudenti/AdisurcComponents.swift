import SwiftUI

// --- MASTER REUSABLE COMPONENTS ---

struct SharedOfficeHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold)) // Large Icon
                .foregroundColor(.blue)
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded)) // Large Header
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
    }
}

struct SharedOfficeCard: View {
    let locationName: String
    let address: String
    let details: String
    
    var body: some View {
        Button(action: {
            let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let url = URL(string: "maps://?address=\(encodedAddress)") {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(locationName)
                        .font(.system(size: 17, weight: .bold)) // Large, readable font
                        .foregroundColor(.primary)
                    Text(address)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(details)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .font(.title3)
                    .foregroundColor(.gray.opacity(0.3))
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

struct SharedProTip: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 12)) // Small icon
                    .foregroundColor(.orange)
                Text(title)
                    .font(.system(size: 12, weight: .black, design: .rounded)) // Small title
                    .foregroundColor(.orange)
            }
            Text(text)
                .font(.system(size: 11)) // Smallest font for the tip content
                .lineSpacing(2)
                .foregroundColor(.primary.opacity(0.8))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.08))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
        )
    }
}
