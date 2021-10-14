//
//  ListOfRoutesView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 30.09.2021.
//

import SwiftUI

struct ListOfRoutesView: View {
    @State private var isShow3D = false
    @State private var currentSize: CGFloat = 0
    @State private var finalSize: CGFloat = 1
    
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
                                    .scaledToFit()
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .scaleEffect(finalSize + currentSize)
                                    
                                    .gesture(MagnificationGesture()
                                                .onChanged{ newScale in
                                        currentSize = newScale
                                    }
                                                .onEnded { scale in
                                        finalSize = currentSize
                                        currentSize = 0
                                    } )
                                    .onTapGesture(count: 2) {
                                        finalSize = 1
                                }
                            }
                            .background(Color.green)
                        }
                    }
                    
                    .tabViewStyle(.page)
                }
                HStack {
                    
                    let gridItems = [
                        GridItem(.fixed(60)),
                        GridItem(.fixed(200)),
                        GridItem(.flexible(minimum: 50), alignment: .leading),
                        GridItem(.flexible(minimum: 50))]
                    
                    LazyVGrid(columns: gridItems, alignment: .leading, spacing: 0) {
                        Text("#️⃣").padding(.horizontal)
                        Text("Трасса")
                            .font(.body).fontWeight(.bold)
                            .padding(.horizontal)
                        Text("🔝")
                        Text("🔩")
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 5, bottom: 10, trailing: 5))
//                .offset(y: -20)
                .background(Color.yellow)

                
                VStack {
                    List {
            ForEach(routes!.sorted { $0.number ?? 0 < $1.number ?? 0} ) { route in
                
                NavigationLink(destination: RouteDetailsView(route: route)) {
                    
                    HStack {
                        // FIXME: - в мультипитчах на три питча будет сбиваться выравнивание (продумать как отображать - Поднебесные зубья)
                        let gridItems = [
                            GridItem(.fixed(30)),
                            GridItem(.fixed(210)),
                            GridItem(.flexible(minimum: 50), alignment: .leading),
                            GridItem(.flexible(minimum: 50))]
                        
                        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 0) {
                            Text("\(route.number ?? 0)")
                            Text(route.name)
                            Text(route.grade)
                            Text(route.bolts)
                        }
                    }
                }
                
                
                
                
                
    //            .onTapGesture {
    //                isShowRouteDetailsView.toggle()
    //            }
                
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    .listStyle(.inset)
                }
//                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShow3D.toggle()
                    } label: {
                        Image(systemName: "move.3d")
                    }

                }
            }
            .sheet(isPresented: $isShow3D) {
                VirtualModelOfCragView()
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
