//
//  QuizzesView.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import SwiftUI

struct QuizzesView: View {
    
    @State var showAll = true
    @EnvironmentObject var quizzesModel: QuizzesModel
    @EnvironmentObject var scoresModel: ScoresModel
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("Ver todos", isOn: $showAll)
                ForEach(quizzesModel.quizzes) { quizItem in
                    if showAll || !scoresModel.acertadas.contains(quizItem.id) {
                        NavigationLink {
                            QuizPlayView(quizItem: quizItem)
                        } label : {
                            QuizRow(quizItem: quizItem)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("P4 Quizzes")
            .navigationBarItems(leading: Text("Record: \(scoresModel.record.count)").foregroundColor(.blue),
                                trailing: Button(action: {quizzesModel.download2()},
                                                 label: {Label("descargar", systemImage: "square.and.arrow.down")})
                                )
            .task {
                if quizzesModel.quizzes.count == 0 {
                    await quizzesModel.download3()
                }
            }
            //.onAppear {
            //   if quizzesModel.quizzes.count == 0 {
            //        quizzesModel.download() ó quizzesModel.download2()
            //    }
            //}
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
