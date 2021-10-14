//
//  GuidbookView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 29.09.2021.
//

import SwiftUI

struct GuidbookView: View {
    @EnvironmentObject var guidbook: GuidbookVM
    @State private var isShowClimbingArea = false
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    var body: some View {
        NavigationView {
            List {
                ForEach(guidbook.locations) { location in
                    Section(header: Text(location.locationName)) {
                       
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                
                                ForEach(location.climbAreas) { climbArea in
                                    
                                    NavigationLink(destination: ListOfCragsView(climbAreaName: climbArea.nameClimbArea, crags: climbArea.crags )) {
                                        ClimbAreaView(climbArea: climbArea)
                                            
                                    }
                                    .buttonStyle(.plain)
                                }
                                
                                .onTapGesture {
                                    isShowClimbingArea = true
                                }
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle("ClimbGesh")
//            .navigationBarTitleDisplayMode(.inline)
            
            .listStyle(.grouped)
//            .listStyle(.sidebar)

        .onAppear(perform: guidbook.loadJSON)
        }
    }
}

struct GuidbookView_Previews: PreviewProvider {
    static var previews: some View {
        GuidbookView()
            
            .environmentObject(GuidbookVM())
    }
}

struct ClimbAreaView: View {
    let climbArea: ClimbArea
    var body: some View {
        VStack {
//            Color.gray
//                .frame(width: 200, height: 150)
//                .cornerRadius(15)
            Image(climbArea.imageClimbArea)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .cornerRadius(15)
            Text(climbArea.nameClimbArea)
        }
        
    }
}

