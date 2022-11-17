//
//  P4_QuizzesApp.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import SwiftUI

@main
struct P4_QuizzesApp: App {
    
    @StateObject var quizzesModel: QuizzesModel = QuizzesModel()
    
    var body: some Scene {
        WindowGroup {
            QuizzesView()
                .environmentObject(quizzesModel)
        }
    }
}
