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
            VStack {
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
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                    Section(header: HStack { Image(systemName: "info.circle").font(.title2)}) {
//                        ScrollView {
                            VStack {
                                Text("Скалолазные районы Шерегеша это ") + Text("гранитные ")
                                    .fontWeight(.bold)
                                + Text("скалы-останцы с маршрутами от ") + Text("5а до 8а ").fontWeight(.bold) + Text("категории сложности.") + Text(" Есть маршруты ") + Text("без прохождения, ").fontWeight(.bold) + Text("их категория обозначена знаком ❓.") + Text(" Если количество болтов на трассе точно неизвестно, то используется этот же символ. ")
                                   
                        }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .font(.body)
//                        }
                        
                    }
                }
               
                
            }
            .navigationTitle("ClimbGesh")
            .listStyle(.grouped)
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
            Image(climbArea.imageClimbArea)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .cornerRadius(15)
            Text(climbArea.nameClimbArea)
        }
    }
}

