//
//  QuizRow.swift
//  P4_Quizzes
//
//  Created by b106 DIT UPM on 17/11/22.
//

import SwiftUI

struct QuizRow: View {
    
    var quizItem: QuizItem
    
    var body: some View {
        HStack{
            MyAsyncImage(url: quizItem.attachment?.url)
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 3))
                .shadow(radius: 15)
            
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .shadow(radius: 15)
            
            VStack {
                Text(quizItem.question)
                    .fontWeight(.heavy)
                Text(quizItem.author?.username ?? "Anónimo")
                    .font(.callout)
            }
            
            Image(quizItem.favourite ? "star_yellow" : "star_grey")
                .resizable()
                .frame(width: 30, height:30)
                .scaledToFit()
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct QuizRow_Previews: PreviewProvider {

    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()

    static var previews: some View {
        VStack {
            QuizRow(quizItem: qm.quizzes[0])
            QuizRow(quizItem: qm.quizzes[1])
        }
    }
}
