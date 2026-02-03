import SwiftUI
import CoreLocation
import Combine

// --- 1. LOCATION MANAGER ---
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var addressString: String = "Fetching location..."
    @Published var coordinatesString: String = ""

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            if let place = placemarks?.first {
                self.addressString = "\(place.name ?? ""), \(place.locality ?? "")"
                self.coordinatesString = "\(String(format: "%.4f", location.coordinate.latitude)), \(String(format: "%.4f", location.coordinate.longitude))"
            }
        }
    }
}

// --- 2. MAIN VIEW ---
struct EmergencyView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // --- UNIVERSAL 112 BUTTON ---
                Button(action: { callNumber("112") }) {
                    HStack {
                        Image(systemName: "phone.fill.badge.plus")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text("Universal Emergency")
                                .font(.headline)
                            Text("Police, Fire, or Medical")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("112")
                            .font(.title2.bold())
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                .padding(.horizontal)

                // --- CURRENT LOCATION CARD (Integrated with Copy Button) ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                        Text("Your Current Location")
                            .font(.headline)
                        Spacer()
                        
                        // Added the Copy Button here inside the card
                        Button(action: {
                            UIPasteboard.general.string = locationManager.addressString
                        }) {
                            Image(systemName: "doc.on.doc")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(locationManager.addressString)
                            .font(.title3.bold())
                            
                        if !locationManager.coordinatesString.isEmpty {
                            Text(locationManager.coordinatesString)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Text("Read this to the operator or tap the icon to copy.")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .padding(.top, 2)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)

                // --- DIRECT EMERGENCY LINES ---
                EmergencySection(title: "Direct Emergency Lines") {
                    VStack(spacing: 12) {
                        EmergencyCallRow(label: "Ambulance / Medical", number: "118", icon: "cross.case.fill", color: .red)
                        EmergencyCallRow(label: "State Police", number: "113", icon: "shield.fill", color: .blue)
                        EmergencyCallRow(label: "Fire Department", number: "115", icon: "flame.fill", color: .orange)
                    }
                }

                // --- STUDENT & SOCIAL SUPPORT ---
                EmergencySection(title: "Student & Social Support", icon: "person.2.fill") {
                    VStack(spacing: 12) {
                        EmergencyCallRow(label: "Women's Anti-Violence", number: "1522", icon: "hand.raised.fill", color: .purple)
                        EmergencyCallRow(label: "Child Protection", number: "114", icon: "figure.and.child.holdinghands", color: .pink)
                        EmergencyCallRow(label: "Roadside Assistance (ACI)", number: "803116", icon: "car.fill", color: .gray)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("EMERGENCY")
        .navigationBarTitleDisplayMode(.inline)
    }

    func callNumber(_ number: String) {
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }
}

// --- 3. SUPPORTING COMPONENTS ---

struct EmergencySection<Content: View>: View {
    var title: String
    var icon: String? = nil
    let content: Content
    
    init(title: String, icon: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if let iconName = icon { Image(systemName: iconName).foregroundColor(.blue) }
                Text(title).font(.headline)
            }
            content
        }
        .padding(.horizontal)
    }
}

struct EmergencyCallRow: View {
    let label: String
    let number: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 30)
                Text(label).foregroundColor(.primary)
                Spacer()
                HStack(spacing: 8) {
                    Text(number).foregroundColor(color).bold()
                    Image(systemName: "phone.fill").font(.caption2).foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
    }
}
