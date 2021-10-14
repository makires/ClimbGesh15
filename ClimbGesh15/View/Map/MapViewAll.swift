//
//  MapView+.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 12.10.2021.
//

import SwiftUI

struct MapViewAll: View {
    @State var isShowListOfRoutes = false
    @State var crag: Crag? = nil
    var body: some View {
        if isShowListOfRoutes {
            
            NavigationView {
                
                ListOfRoutesView(imagesOfCrag: crag?.imagesOfCrag ?? ["empty"],
                                 routes: crag?.routes,
                                 nameOfCrag: crag?.nameCrag)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isShowListOfRoutes = false
                            } label: {
                                Text("Назад")
                            }

                        }
                    }
                
            }
            
        } else {
            
            MapUI(isShowListOfRoutes: $isShowListOfRoutes, crag: $crag)
        }
        
    }
}

struct MapView__Previews: PreviewProvider {
    static var previews: some View {
        MapViewAll()
    }
}
