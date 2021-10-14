//
//  RouteDetailsView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 01.10.2021.
//

import SwiftUI

struct RouteDetailsView: View {
    var route: Route
    var body: some View {
            VStack {
                Text("Детали о маршруте \(route.name)")
            }
    }
}

struct RouteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailsView(route: MockData().response[0].climbAreas[0].crags[0].routes[0])
    }
}
