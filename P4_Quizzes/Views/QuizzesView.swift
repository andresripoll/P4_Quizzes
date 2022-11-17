//
//  QuizzesView.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import SwiftUI

struct QuizzesView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(quizzesModel.quizzes) { quizItem in
                    NavigationLink {
                        QuizPlayView(quizItem: quizItem)
                    } label : {
                        QuizRow(quizItem: quizItem)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("P4 Quizzes")
            .onAppear {
                quizzesModel.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
        QuizzesView()
            .environmentObject(qm)
    }
}
