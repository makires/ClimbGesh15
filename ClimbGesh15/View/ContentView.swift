//
//  ContentView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 29.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Guidbook"
    var body: some View {
        TabView(selection: $selectedTab) {
            
           
            GuidbookView()
                .environmentObject(GuidbookVM())
                .tabItem {
                    Text("Гайдбук")
                    Image(systemName: "triangle")
                }
                .tag("Guidbook")
            MapViewAll()
                .ignoresSafeArea(edges: .top)
                .tabItem {
                    Text("Карта")
                    Image(systemName: "map")
                }
                .tag("Map")
            AboutAppView()
                .tabItem {
                    Text("Инфо")
                    Image(systemName: "info.circle")
                }
                .tag("Info")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
