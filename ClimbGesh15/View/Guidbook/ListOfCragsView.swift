//
//  ListOfCragsView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 30.09.2021.
//

import SwiftUI

struct ListOfCragsView: View {

    let climbAreaName: String
    let crags: [Crag]
    var body: some View {
            List {
                ForEach(crags) { crag in
// хочется убрать совсем подсветку ячейки при тапе
                   
                    ZStack {
                        NavigationLink(destination:
                                ListOfRoutesView(
                                    imagesOfCrag: crag.imagesOfCrag,
                                    routes: crag.routes,
                                    nameOfCrag: crag.nameCrag)
                        ) {
                            EmptyView()
                        }
                        CragRowView(crag: crag)
                    }
                    
                }
                
            }
            .navigationTitle(climbAreaName)
//            .listStyle(.grouped)
            .listStyle(.plain)
//            .listStyle(.inset)
            
    }
}

struct ListOfCragsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListOfCragsView(climbAreaName: "Верблюды", crags: MockData().response[0].climbAreas[0].crags)
        }
    }
}

struct CragRowView: View {
    let crag: Crag
    var body: some View {
//        ZStack {
//            Color.gray
//                .frame(width: 350, height: 200)
//                .cornerRadius(15)
//            Text(crag.nameCrag)
//        }
        ZStack {
            Image(crag.imageCrag)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 200)
                .cornerRadius(15)
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "triangle")
                            .foregroundColor(Color(.white))
                        Text(crag.nameCrag)
                            
                            .font(.title2)
                        .foregroundColor(Color(.white))
                        Spacer()
                    }
                    HStack {
                        Text("Маршрутов: \(crag.routes.count)")
                            .foregroundColor(Color(.white))
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}
