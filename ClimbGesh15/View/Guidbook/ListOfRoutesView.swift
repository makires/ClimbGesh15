//
//  ListOfRoutesView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 30.09.2021.
//

import SwiftUI

struct ListOfRoutesView: View {

    let imagesOfCrag: [String]
    let routes: [Route]?
    let nameOfCrag: String?
    
    var body: some View {

            VStack {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text(nameOfCrag!)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(EdgeInsets(top: -50, leading: -15, bottom: 0, trailing: 0))
                    
                   
                    TabView {
                        ForEach(imagesOfCrag, id: \.self) { nameImage in
                            VStack {
                                Image(nameImage)
                                    .resizable()
                                    .scaledToFill()
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    
                            }
                            .background(Color.green)
                        }
                    }
                    
                    .tabViewStyle(.page)
                }
                HStack {
                    
                    let gridItems = [
                        
                        GridItem(.fixed(240)),
                        GridItem(.flexible(minimum: 60), alignment: .leading),
                        GridItem(.flexible(minimum: 50))]
                    
                    LazyVGrid(columns: gridItems, alignment: .leading, spacing: 0) {
                        
                        Text("Трасса")
                            .font(.body).fontWeight(.bold)
                            .padding(.horizontal)
                        Text("🔝")
                        Text("🔩")
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 5, bottom: 10, trailing: 5))
                .background(Color.yellow)

                
                VStack {
                    List {
                        ForEach(routes! ) { route in
                
                    HStack {
                        let gridItems = [
                            
                            GridItem(.fixed(230)),
                            GridItem(.flexible(minimum: 60), alignment: .leading),
                            GridItem(.flexible(minimum: 50))]
                        
                        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 0) {
                            Text(route.name)
                            Text(route.grade)
                            Text(route.bolts)
                        }
                    }
                
                
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    .listStyle(.inset)
                }

            }

    }
}

struct ListOfRoutesView_Previews: PreviewProvider {
    static var previews: some View {
            NavigationView {
                ListOfRoutesView(imagesOfCrag: ["trapezoidEast", "trapezoidSouth", "trapezoidWest"], routes: MockData().response[0].climbAreas[0].crags[3].routes, nameOfCrag: "Тридесятое королевство")
            }
    }
}
