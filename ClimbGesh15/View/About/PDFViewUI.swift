//
//  PDFViewUI.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 08.10.2021.
//

import SwiftUI
import PDFKit

struct PDFViewUI: UIViewRepresentable {
    var url: URL?
    init(url: URL) {
        self.url = url
    }
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        if let url = url {
            pdfView.document = PDFDocument(url: url)
            pdfView.autoScales = true
        }
        return pdfView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    
}


