//
//  AboutAppView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 30.09.2021.
//

import SwiftUI

struct AboutAppView: View {
    @StateObject var vm = AboutAppVM()
    @State private var isShowPDFCamels = false
    @State private var isShowPDFMundybash = false
    
   // ????????????
//    @State private var valueForProgressCamels = 0.5
//    @State private var valueForProgressMundybash = 0.2

    @State private var isStartDownloadingCamels = false
    @State private var isStartDownloadingMundybash = false

    var body: some View {
        NavigationView {
                List {
                    Section(header: Text("Гайдбуки-pdf"), footer: VStack {
                        Text("Можно скачать и посмотреть печатный вариант гайдбуков, с дополнительной информацией по районам, транспорту, местам для кемпинга и пр.").font(.caption)
                    }) {
                        if vm.isShowOpenButtonCamels {
                            Button {
                                isShowPDFCamels.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("Открыть Верблюды")
                                }
                            }
                            .onAppear {
                                isStartDownloadingCamels = false
                                vm.downloadedData = 0.0

                            }
                        } else {
                            VStack {
                                HStack {
                                    Button {
                                        vm.downloadPDF(name: "camels2020.pdf")
                                        isStartDownloadingCamels = true
                                    } label: {
                                        HStack {
                                            Image(systemName: "tray.and.arrow.down.fill")
                                            Text("Скачать Верблюды")
                                        }
                                }
                                    Spacer()
                                }
                                if isStartDownloadingCamels {
                                    HStack {
                                        ProgressView(value: vm.downloadedData)
                                    }
                                }
                            }
                        }
                        
                        if vm.isShowOpenButtonMundybash {
                            Button {
                                isShowPDFMundybash.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("Открыть Mундыбаш")
                                }
                            }
                            .onAppear {
                                isStartDownloadingMundybash = false
                                vm.downloadedData = 0.0
                            }
                        } else {
                            
                            VStack {
                                HStack {
                                    Button {
                                        vm.downloadPDF(name: "mundybash.pdf")
                                        isStartDownloadingMundybash = true
                                    } label: {
                                        HStack {
                                            Image(systemName: "tray.and.arrow.down.fill")

                                            Text("Скачать Мундыбаш")
                                        }
                                }
                                    Spacer()
                                }
                                if isStartDownloadingMundybash {
                                    HStack {
                                        ProgressView(value: vm.downloadedData)
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("web-сайт"), footer: VStack {
                        Text("Посмотреть новости или оставить ваши предложения можно в телеграм-канале. Ссылка на сайте").font(.caption)
                    }) {
                        
                        Link("climbgesh.ru", destination: URL(string: "https://climbgesh.ru")!)
                    }
                    Section(header: Text("О приложении")) {
                        
                        Text("Версия 1.0")
                    }
                }
                .navigationTitle(Text("📚 Дополнительно"))
                .sheet(isPresented: $isShowPDFCamels) {
                    let urlForCamels = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("camels2020.pdf")
                    ShowPDFView(url: urlForCamels)
                }
                .sheet(isPresented: $isShowPDFMundybash) {
                    let urlForMundybash = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("mundybash.pdf")
                    ShowPDFView(url: urlForMundybash)
                }
                    
                
                .onAppear {
                    vm.checkIsDownloadedCamelsPDF()
                    vm.checkIsDownloadedMundybashPDF()
                }
            
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
