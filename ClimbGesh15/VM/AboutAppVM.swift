//
//  AboutAppVM.swift
//  ClimbGesh15
//
//  Created by Tatiana Ilvutikova on 07.10.2021.
//

import Foundation
import SwiftUI

class AboutAppVM: NSObject, ObservableObject {
    
    @AppStorage("camelsPDF") var isDownloadedCamels = false
    @AppStorage("munndybashPDF") var isDownloadedMundybash = false
    
    @Published var isShowOpenButtonCamels = false
    @Published var isShowOpenButtonMundybash = false

    @Published var downloadedData: Float = 0.0

    var downloadURL: URL?
    
    func checkIsDownloadedCamelsPDF() {
        let fileManager = FileManager.default
        guard
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
               else { return }
        print(documentsPath)
        let destinationURLForCamels = documentsPath.appendingPathComponent("camels2020.pdf")
        if fileManager.fileExists(atPath: destinationURLForCamels.path) {
            isDownloadedCamels = true
            isShowOpenButtonCamels = true
        } else {
            isDownloadedCamels = false
            isShowOpenButtonCamels = false
        }
    }
    
    func checkIsDownloadedMundybashPDF() {
        let fileManager = FileManager.default
        guard
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
               else { return }
        let destinationURLForCamels = documentsPath.appendingPathComponent("mundybash.pdf")
        if fileManager.fileExists(atPath: destinationURLForCamels.path) {
            isDownloadedMundybash = true
            isShowOpenButtonMundybash = true
        } else {
            isDownloadedMundybash = false
            isShowOpenButtonMundybash = false
        }
    }
    
    
    func downloadPDF(name: String) {
        let url = URL(string: "https://climbgesh.ru/pdf/\(name)")!
        downloadURL = url
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
      
}

extension AboutAppVM: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    let fileManager = FileManager.default
        
    guard
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
        let lastPathComponent = downloadURL?.lastPathComponent
        else {
            print("не удалось найти папку Documents в песочнице и получить название файла из компонента URL")
            return
        }
        print("песочница по адресу: ->", documentsPath)
        print("название файла: -> ", lastPathComponent)
        
        let destinationURL = documentsPath.appendingPathComponent(lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(at: location, to: destinationURL)
            
            print("файл из временной папки перенесен в песочницу")
            //TODO: - переменная в UserDefaults?
            // создать переменную, которая после первой загрузки файла будет менять свое состояние, чтобы проверить: Если файл уже был загружен, то не делать повторного запроса к серверу
            DispatchQueue.main.async {
                switch lastPathComponent {
                case "camels2020.pdf":
                    self.isDownloadedCamels = true
                    self.isShowOpenButtonCamels = true
                case "mundybash.pdf":
                    self.isDownloadedMundybash = true
                    self.isShowOpenButtonMundybash = true
                default: print("что-не так с изменением статуса /isDownloaded для гайдбука \(lastPathComponent)")
                }
            }
            
        } catch {
            print("ошибка при перемещении временного файла \(destinationURL.lastPathComponent) в папку Documents, так как он уже существует", error.localizedDescription)
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard
            let response = downloadTask.response as? HTTPURLResponse,
            let contentLength = response.allHeaderFields["Content-Length"] as? String,
            let totalBytesExpected = Int64(contentLength)
        else {
            print("ошибка в получении HTTPURLResponse - Content-Length")
            return
        }
        
        DispatchQueue.main.async {
            
            self.downloadedData = Float(totalBytesWritten) / Float(totalBytesExpected)
            
        }
    }
    
}
