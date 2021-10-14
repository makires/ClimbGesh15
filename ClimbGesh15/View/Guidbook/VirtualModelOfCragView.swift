//
//  VirtualModelOfCragView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 13.10.2021.
//

import SwiftUI

struct VirtualModelOfCragView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
            ScrollView {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "move.3d")
                            .font(.system(size: 40, weight: .bold))
                            .padding()
                        Spacer()
                    }
                    Text("Данный раздел требует много внимания, концентрации и знаний. Переходите на сайт приложения и примите участие в проекте.")
                        .font(.title2)
                        .padding(.horizontal)
                    Color.gray
                        .frame(width: 370, height: 250)
                        .cornerRadius(15)
                    Text("Цель - создать виртуальную модель скалы и наслаждаться ментальной тренировкой с помощью современных технологий. ")
                        .font(.title2)
                        .padding(.horizontal)
                    Spacer()
                    HStack {
                        Spacer()
                        Link("climbgesh.ru", destination: URL(string: "https://climbgesh.ru")!)
                            .font(.title3)
                        Spacer()
                    }
                    .padding()
                }
                .foregroundColor(Color(.black))

                .background(LinearGradient(colors: [Color.orange, Color.white], startPoint: .topLeading, endPoint: .bottom))
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Назад")
                        }

                    }
            }
        }
    }
}

struct VirtualModelOfCragView_Previews: PreviewProvider {
    static var previews: some View {
        VirtualModelOfCragView()
    }
}
