//
//  ShowPDFView.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 09.10.2021.
//

import SwiftUI

struct ShowPDFView: View {
    @Environment(\.presentationMode) var presentationMode
    let url: URL
    
    var body: some View {
        NavigationView {
            
            PDFViewUI(url: url)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Назад")
                        }

                    }
                }
                .navigationTitle("\(url.lastPathComponent)")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ShowPDFView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPDFView(url: URL(string: "error.pdf")!)
    }
}
