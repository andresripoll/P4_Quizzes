//
//  QuizPlayView.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import SwiftUI

struct QuizPlayView: View {
    
    var quizItem: QuizItem
    
    @Environment(\.horizontalSizeClass) var hsc
    
    @State var answer: String = ""
    @EnvironmentObject var scoresModel: ScoresModel
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            if hsc == .compact {
                VStack {
                    HStack(alignment: .center, spacing: 5){
                        titulo
                        favorito
                    }
                    respuesta
                    attatchment
                    footer
                }
            } else {
                VStack {
                    HStack {
                        VStack {
                            HStack(alignment: .center, spacing: 5){
                                titulo
                                favorito
                            }
                            respuesta
                        }
                        
                        attatchment
                    }
                    footer
                }
            }
        }
        .navigationTitle("Play")
    }
    
    private var titulo: some View {
        Text(quizItem.question)
            .fontWeight(.heavy)
            .font(.largeTitle)
    }
    
    private var respuesta: some View {
        VStack {
            TextField("Introduzca su respuesta", text: $answer)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onSubmit {
                    if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                        scoresModel.add(answer: answer, quizItem: quizItem)
                    }
                    showAlert = true
                }
            
            Button("Comprobar") {
                if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                    scoresModel.add(answer: answer, quizItem: quizItem)
                }
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Resultado"),
                  message: Text(answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ? "Bien" : "Mal"),
                  dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    private var attatchment: some View {
        GeometryReader {geom in
            MyAsyncImage(url: quizItem.attachment?.url)
                .scaledToFill()
                .frame(width: geom.size.width, height: geom.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3))
                .shadow(radius: 15)
        }
        .padding()
    }
    
    private var footer: some View {
        HStack {
            Text("Puntos: \(scoresModel.acertadas.count)")
                .foregroundColor(.green)
            
            Spacer()
            
            Text(quizItem.author?.username ?? "Anónimo")
                .font(.callout)
            
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .shadow(radius: 15)
        }
        .padding()
    }
    
    private var favorito: some View {
        Button {
            quizzesModel.toggleFav(quizItemId: quizItem.id)
        } label: {
            Image(quizItem.favourite ? "star_yellow" : "star_grey")
                .resizable()
                .frame(width: 35, height: 35)
                .scaledToFit()
        }
    }
}

struct QuizPlayView_Previews: PreviewProvider {
    
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
        QuizPlayView(quizItem: qm.quizzes[0])
    }
}
