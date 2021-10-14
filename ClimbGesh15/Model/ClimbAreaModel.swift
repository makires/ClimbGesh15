//
//  ClimbAreaModel.swift
//  ClimbGesh
//
//  Created by Tatiana Ilvutikova on 04.09.2021.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

// MARK: - месторасположение скалолазного района (Шерегеш, Мундыбаш, Турочак и т.д)
class Location: Decodable, Identifiable {
    let id: Int
    let locationName: String
    let climbAreas: [ClimbArea]
}
// MARK: - скалолазный район (Верблюды, Сектор Е, Нижние Сарлыки и т.д.)
class ClimbArea: Identifiable, Decodable {
    let id : Int
    let nameClimbArea: String
    let imageClimbArea: String
    let crags: [Crag]
    let pdfGuidbookURL: String
    let coordinatesClimbArea: Coordinate
    
    var locationCoordinatesClimbArea: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinatesClimbArea.latitude, longitude: coordinatesClimbArea.longitude)
    }
}

struct Coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}

// MARK: - скала
class Crag: NSObject, Identifiable, Decodable {
    var id: Int
    let nameCrag: String
    let imageCrag: String
    let imagesOfCrag: [String]
    let coordinatesOfCrag: Coordinate
    let routes: [Route]
}

extension Crag: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinatesOfCrag.latitude, longitude: coordinatesOfCrag.longitude)
    }
    var title: String? { nameCrag }
}
// MARK: - трасса на скале
class Route: Decodable, Identifiable {
    let id = UUID()
    let number: Int?
    let name: String
    let grade: String
    let bolts: String
}


struct MockData {
    let response: [Location] = {
        guard let json = Bundle.main.url(forResource: "geshWork", withExtension: "json") else { fatalError() }
        do {
            let jsonData = try Data(contentsOf: json)
            return try JSONDecoder().decode([Location].self, from: jsonData)
        } catch {
            fatalError()
        }
    }()
}
