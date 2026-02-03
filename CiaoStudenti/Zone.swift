//
//  Zone.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 03/02/26.
//

import SwiftUI
import MapKit

struct SafetyZone: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let level: String
    let coordinates: [CLLocationCoordinate2D]
}

// Global data for the map
struct SafetyData {
    static let naplesZones = [
        // GREEN: Safe Areas (Vomero/Chiaia)
        SafetyZone(name: "Vomero & Chiaia", color: .green, level: "Safe", coordinates: [
            CLLocationCoordinate2D(latitude: 40.830, longitude: 14.210),
            CLLocationCoordinate2D(latitude: 40.845, longitude: 14.210),
            CLLocationCoordinate2D(latitude: 40.845, longitude: 14.250),
            CLLocationCoordinate2D(latitude: 40.830, longitude: 14.250)
        ]),
        
        // ORANGE: Caution Areas (Garibaldi/Central Station)
        SafetyZone(name: "Piazza Garibaldi", color: .orange, level: "Caution", coordinates: [
            CLLocationCoordinate2D(latitude: 40.848, longitude: 14.260),
            CLLocationCoordinate2D(latitude: 40.858, longitude: 14.260),
            CLLocationCoordinate2D(latitude: 40.858, longitude: 14.285),
            CLLocationCoordinate2D(latitude: 40.848, longitude: 14.285)
        ]),
        
        // RED: Higher Risk (Scampia/Peripheral North)
        SafetyZone(name: "Scampia Area", color: .red, level: "High Risk", coordinates: [
            CLLocationCoordinate2D(latitude: 40.885, longitude: 14.230),
            CLLocationCoordinate2D(latitude: 40.910, longitude: 14.230),
            CLLocationCoordinate2D(latitude: 40.910, longitude: 14.260),
            CLLocationCoordinate2D(latitude: 40.885, longitude: 14.260)
        ])
    ]
}
