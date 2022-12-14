//
//  ScoresModel.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import Foundation

class ScoresModel: ObservableObject {
    
    @Published private(set) var acertadas : Set<Int> = []
    @Published private(set) var record : Set<Int> = []
    
    init() {
        record = Set(UserDefaults.standard.array(forKey: "record") as? [Int] ?? [])
    }
    
    func add(answer: String, quizItem: QuizItem) {
        
        if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            acertadas.insert(quizItem.id)
            record.insert(quizItem.id)
            
            UserDefaults.standard.set(Array(record), forKey: "record")
        }
    }
    
}
