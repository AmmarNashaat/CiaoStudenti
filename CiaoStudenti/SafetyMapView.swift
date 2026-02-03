import SwiftUI
import MapKit

// 1. DATA MODEL
// Conforming to Identifiable is what prevents the 'Trailing Closure' error.
struct LocalSafetyArea: Identifiable {
    let id = UUID()
    let name: String
    let risk: LocalRiskLevel // Uses the enum defined below
    let description: String
    let coordinates: [CLLocationCoordinate2D]
}

enum LocalRiskLevel: String {
    case safe = "Safe Haven"
    case caution = "Exercise Caution"
    case highRisk = "High Risk"
    case environmental = "Environmental Risk"
    
    var tintColor: Color {
        switch self {
        case .safe: return .green
        case .caution: return .yellow
        case .highRisk: return .red
        case .environmental: return .orange
        }
    }
}

// 2. MAIN VIEW
struct SafetyMapView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.8518, longitude: 14.2681),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        )
    )
    
    @State private var selectedArea: LocalSafetyArea?

    var body: some View {
        NavigationStack {
            Map(position: $position, selection: .constant(nil)) {
                ForEach(campaniaZones) { area in
                    // Draw the physical zone
                    MapPolygon(coordinates: area.coordinates)
                        .foregroundStyle(area.risk.tintColor.opacity(0.35))
                        .stroke(area.risk.tintColor, lineWidth: 2)
                    
                    // Add an invisible button in the center for interaction
                    Annotation(area.name, coordinate: calculateCenter(area.coordinates)) {
                        Button {
                            selectedArea = area
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .background(Circle().fill(.white))
                                .font(.title3)
                        }
                    }
                }
                UserAnnotation()
            }
            .navigationTitle("City Safety Map")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                SafetyLegendView()
            }
            .sheet(item: $selectedArea) { area in
                SafetyDetailSheet(area: area)
            }
        }
    }

    // Helper: Finds the middle of the coordinates to place the info button
    private func calculateCenter(_ coords: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        let lats = coords.map { $0.latitude }
        let lons = coords.map { $0.longitude }
        return CLLocationCoordinate2D(
            latitude: (lats.min()! + lats.max()!) / 2,
            longitude: (lons.min()! + lons.max()!) / 2
        )
    }
}

// 3. SUPPORTING VIEWS
struct SafetyDetailSheet: View {
    let area: LocalSafetyArea
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Capsule().fill(.secondary).frame(width: 40, height: 5).padding(.top)
            
            Text(area.name).font(.title.bold())
            
            Text(area.risk.rawValue)
                .font(.headline)
                .padding(.horizontal, 12).padding(.vertical, 4)
                .background(area.risk.tintColor.opacity(0.2))
                .foregroundColor(area.risk.tintColor)
                .cornerRadius(8)
            
            Text(area.description)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Done") { dismiss() }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            
            Spacer()
        }
        .presentationDetents([.height(300)])
    }
}

struct SafetyLegendView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                LegendItem(color: .green, text: "Safe")
                LegendItem(color: .yellow, text: "Caution")
                LegendItem(color: .red, text: "High Risk")
                LegendItem(color: .orange, text: "Nature")
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
        }
        .padding()
    }
}

struct LegendItem: View {
    let color: Color
    let text: String
    var body: some View {
        HStack {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(text).font(.caption).bold()
        }
    }
}

// 4. DATA ARRAY
private let campaniaZones = [
    LocalSafetyArea(name: "Vomero", risk: .safe, description: "Highly recommended; minimal risk.", coordinates: [
        CLLocationCoordinate2D(latitude: 40.835, longitude: 14.215),
        CLLocationCoordinate2D(latitude: 40.850, longitude: 14.215),
        CLLocationCoordinate2D(latitude: 40.850, longitude: 14.240),
        CLLocationCoordinate2D(latitude: 40.835, longitude: 14.240)
    ]),
    LocalSafetyArea(name: "Scampia", risk: .highRisk, description: "High social distress; avoid after dark.", coordinates: [
        CLLocationCoordinate2D(latitude: 40.895, longitude: 14.225),
        CLLocationCoordinate2D(latitude: 40.915, longitude: 14.225),
        CLLocationCoordinate2D(latitude: 40.915, longitude: 14.255),
        CLLocationCoordinate2D(latitude: 40.895, longitude: 14.255)
    ]),
    LocalSafetyArea(name: "Campi Flegrei", risk: .environmental, description: "Active volcanic zone; monitor INGV alerts.", coordinates: [
        CLLocationCoordinate2D(latitude: 40.810, longitude: 14.080),
        CLLocationCoordinate2D(latitude: 40.840, longitude: 14.080),
        CLLocationCoordinate2D(latitude: 40.840, longitude: 14.160),
        CLLocationCoordinate2D(latitude: 40.810, longitude: 14.160)
    ])
]

