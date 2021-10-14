//
//  GuidbookVM.swift
//  ClimbGesh
//
//  Created by Tatiana Ilvutikova on 06.09.2021.
//

import Foundation

class GuidbookVM: ObservableObject {

    @Published var locations = [Location]()

    func loadJSON() {
        guard let urlGeshWorkJSON = Bundle.main.url(forResource: "geshWork", withExtension: "json") else {
            print("Ошибка при чтении локального файла JSON")
            return
        }
        
        do {
            let data = try Data(contentsOf: urlGeshWorkJSON)
            let decodedData = try JSONDecoder().decode([Location].self, from: data)
            self.locations = decodedData
            
        } catch {
            print("ошибка при конвертации в тип данных Data из файла по urlGeshWorkJSON и/или ошибка при декодировании")
        }
        
        
    }
    
    
    
}
