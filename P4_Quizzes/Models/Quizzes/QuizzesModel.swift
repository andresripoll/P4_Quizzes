//
//  QuizzesModel.swift
//  Quiz con SwiftUI
//
//  Created by Santiago Pavón Gómez on 18/10/22.
//

import Foundation

class QuizzesModel: ObservableObject {
    
    private let urlbase = "https://core.dit.upm.es"
    private let quizzesPath = "api/quizzes/random10wa?token"
    private let token = "15cdf17a460f3d0828ee"
    
    // Los datos
    @Published private(set) var quizzes = [QuizItem]()
    
    
    func load() {
                
        guard let jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
//            if let str = String(data: data, encoding: String.Encoding.utf8) {
//                print("Quizzes ==>", str)
//            }
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            
            self.quizzes = quizzes

            print("Quizzes cargados")
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
    
    func endpoint() -> URL? {
        let surl = "\(urlbase)/\(quizzesPath)=\(token)"
                
        guard let url = URL(string: surl) else {
            print("Internal error 1")
            return nil
        }
        
        return url
    }
    
    func download() {
        
        guard let url = endpoint() else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let quizzes = try decoder.decode([QuizItem].self, from: data)
                
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    print("Quizzes cargados")
                }
                
            } catch {
                print("Algo chungo ha pasado: \(error)")
            }
        }
    }
    
    func download2() {
        
        guard let url = endpoint() else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data else {
                print("Fallo en la descarga")
                return
            }
            
            if let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data) {
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    print("Quizzes cargados")
                }
            } else {
                print("Fallo en los datos, json corrupto")
            }
            
        }
        .resume()
    }
    
    func download3() async {
        
        guard let url = endpoint() else { return }
        
        if let (data, _) = try? await URLSession.shared.data(from: url),
            let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data) {
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    print("Quizzes cargados")
                }
        } else {
            print("Fallo terrible")
        }
    }
}
