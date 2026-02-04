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
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // --- 1. CURRENT LOCATION CARD ---
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.blue)
                            Text("Your Current Location")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                            Spacer()
                            
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
                                .font(.system(size: 19, weight: .bold, design: .rounded))
                            
                            if !locationManager.coordinatesString.isEmpty {
                                Text(locationManager.coordinatesString)
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Text("Read this to the operator or tap the icon to copy.")
                            .font(.system(size: 11))
                            .foregroundColor(.blue)
                            .padding(.top, 2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // --- 2. UNIVERSAL 112 BUTTON ---
                    Button(action: { callNumber("112") }) {
                        HStack {
                            Image(systemName: "phone.fill.badge.plus")
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text("Universal Emergency")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                Text("Police, Fire, or Medical")
                                    .font(.system(size: 13))
                            }
                            Spacer()
                            Text("112")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)

                    // --- 3. GUARDIA MEDICA SECTION ---
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "stethoscope")
                                .foregroundColor(.green)
                            Text("Guardia Medica")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("For non-emergencies when your GP is closed.")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                            
                            EmergencyCallRow(label: "Naples City Center", number: "081 254 9111", icon: "phone.fill", color: Color.green)
                        }
                        .padding(.horizontal)
                    }

                    // --- 4. DIRECT EMERGENCY LINES ---
                    EmergencySectionView(title: "Direct Emergency Lines", icon: "phone.circle.fill") {
                        VStack(spacing: 12) {
                            EmergencyCallRow(label: "Ambulance / Medical", number: "118", icon: "cross.case.fill", color: Color.red)
                            EmergencyCallRow(label: "State Police", number: "113", icon: "shield.fill", color: Color.blue)
                            EmergencyCallRow(label: "Fire Department", number: "115", icon: "flame.fill", color: Color.orange)
                        }
                    }

                    // --- 5. FIRST AID TIPS LINK ---
                    Link(destination: URL(string: "https://www.redcross.org.uk/first-aid/learn-first-aid")!) {
                        HStack {
                            Image(systemName: "heart.text.square.fill")
                                .font(.title2)
                            Text("Learn Basic First Aid Tips")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                            Spacer()
                            Image(systemName: "arrow.up.right")
                        }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.red)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("EMERGENCY")
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }

    func callNumber(_ number: String) {
        let cleanNumber = number.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(cleanNumber)") {
            UIApplication.shared.open(url)
        }
    }
}

// --- 3. SUPPORTING COMPONENTS (MUST BE AT THE BOTTOM) ---

struct EmergencySectionView<Content: View>: View {
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
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
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
            let cleanNumber = number.replacingOccurrences(of: " ", with: "")
            if let url = URL(string: "tel://\(cleanNumber)") {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 30)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 8) {
                    Text(number)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(color)
                    Image(systemName: "phone.fill")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}
