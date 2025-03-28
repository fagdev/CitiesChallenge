//
//  ChallengeMapView.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import SwiftUI
import MapKit

struct ChallengeMapView: View {
    @Binding var lat: Double?
    @Binding var lon: Double?
    
    @State private var position: MapCameraPosition
    
    init(lat: Binding<Double?>, lon: Binding<Double?>) {
        _lat = lat
        _lon = lon
        
        let defaultLat = -34.3525611
        let defaultLon = -58.9128669
        let initialLat = lat.wrappedValue ?? defaultLat
        let initialLon = lon.wrappedValue ?? defaultLon
        
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: initialLat, longitude: initialLon),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        ))
    }
    
    var body: some View {
        Map(position: $position, interactionModes: [.zoom])
            .mapStyle(.standard)
            .onChange(of: lat) { newLat in
                updatePosition()
            }
            .onChange(of: lon) { newLon in
                updatePosition()
            }
    }
    
    private func updatePosition() {
        let updatedLat = lat ?? -34.3525611
        let updatedLon = lon ?? -58.9128669
        
        position = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: updatedLat, longitude: updatedLon),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
    }
}

