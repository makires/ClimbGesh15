//
//  MapUI.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 30.09.2021.
//

import SwiftUI
import UIKit
import MapKit

struct MapUI: UIViewRepresentable {
    
    @Binding var isShowListOfRoutes: Bool
    @Binding var crag: Crag?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.addAnnotations(allCrags())
        mapView.mapType = .hybrid
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.964906, longitude: 87.911511), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapUI
        
        init(_ parent: MapUI) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            guard annotation is Crag else { return nil }
            
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "crag") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "crag")
            
            annotationView.glyphText = "🏔"
            annotationView.clusteringIdentifier = "crags"
            annotationView.markerTintColor = #colorLiteral(red: 1, green: 0.1730283201, blue: 0, alpha: 0.8961156728)
            annotationView.canShowCallout = true
            annotationView.titleVisibility = .visible
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let crag = view.annotation as? Crag else { return }
            print("вы нажали на \(crag.nameCrag)")
            DispatchQueue.main.async {
                self.parent.isShowListOfRoutes = true
                self.parent.crag = crag
            }
        }
    }
    
    
    
    func allCrags() -> [Crag] {
        var crags: [Crag] = []
        let arrayLocation = MockData().response
        for location in arrayLocation {
            for climbAreas in location.climbAreas {
                for crag in climbAreas.crags {
                    crags.append(crag)
                }
            }
        }
        return crags
    }
}

