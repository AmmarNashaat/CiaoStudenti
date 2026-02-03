import SwiftUI
import MapKit

// 1. Define the categories
enum RiskLevel: String {
    case safe = "Safe Haven"
    case caution = "Exercise Caution"
    case highRisk = "High Risk"
    case environmental = "Environmental Risk"
    
    var color: Color {
        switch self {
        case .safe: return .green
        case .caution: return .yellow
        case .highRisk: return .red
        case .environmental: return .orange
        }
    }
}

// 2. Define the Area Structure
struct SafetyArea: Identifiable {
    let id = UUID()
    let name: String
    let risk: RiskLevel
    let description: String
    let coordinates: [CLLocationCoordinate2D]
}

// 3. The Data
struct SafetyZonesData {
    static let campaniaZones = [
        // 🔴 HIGH RISK: Scampia
        SafetyArea(name: "Scampia & Secondigliano", risk: .highRisk, description: "Northern suburbs; avoid after dark.", coordinates: [
            CLLocationCoordinate2D(latitude: 40.895, longitude: 14.225),
            CLLocationCoordinate2D(latitude: 40.915, longitude: 14.225),
            CLLocationCoordinate2D(latitude: 40.915, longitude: 14.255),
            CLLocationCoordinate2D(latitude: 40.895, longitude: 14.255)
        ]),

        // 🌋 ENVIRONMENTAL: Campi Flegrei
        SafetyArea(name: "Campi Flegrei", risk: .environmental, description: "Seismic risk (bradiseismo); check local alerts.", coordinates: [
            CLLocationCoordinate2D(latitude: 40.815, longitude: 14.080),
            CLLocationCoordinate2D(latitude: 40.845, longitude: 14.080),
            CLLocationCoordinate2D(latitude: 40.845, longitude: 14.160),
            CLLocationCoordinate2D(latitude: 40.815, longitude: 14.160)
        ]),

        // 🌋 ENVIRONMENTAL: Vesuvius Red Zone
        SafetyArea(name: "Vesuvius Red Zone", risk: .environmental, description: "Volcanic evacuation zone (Ercolano, Torre del Greco).", coordinates: [
            CLLocationCoordinate2D(latitude: 40.750, longitude: 14.330),
            CLLocationCoordinate2D(latitude: 40.830, longitude: 14.330),
            CLLocationCoordinate2D(latitude: 40.830, longitude: 14.480),
            CLLocationCoordinate2D(latitude: 40.750, longitude: 14.480)
        ]),
        
        // 🟢 SAFE: Vomero
        SafetyArea(name: "Vomero & Chiaia", risk: .safe, description: "Safe residential and upscale areas.", coordinates: [
            CLLocationCoordinate2D(latitude: 40.835, longitude: 14.215),
            CLLocationCoordinate2D(latitude: 40.850, longitude: 14.215),
            CLLocationCoordinate2D(latitude: 40.850, longitude: 14.245),
            CLLocationCoordinate2D(latitude: 40.835, longitude: 14.245)
        ])
    ]
}

