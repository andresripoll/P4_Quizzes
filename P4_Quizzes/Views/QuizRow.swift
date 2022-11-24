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
        HStack(alignment: .center, spacing: 3) {
            attatchment
            VStack(alignment: .center) {
                HStack {
                    favourite
                    Spacer()
                    autor
                }
                question
            }
        }
    }
    
    private var autor: some View {
        HStack {
            Text(quizItem.author?.username ?? "Anónimo")
                .font(.system(size: 12.0))
                .fontWeight(.light)
            
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .shadow(radius: 15)
        }
        .padding(.trailing, 10)
    }
    
    private var attatchment: some View {
        MyAsyncImage(url: quizItem.attachment?.url)
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 3))
            .shadow(radius: 15)
    }
    
    private var question: some View {
        Text(quizItem.question)
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .bottom], 15)
            
    }
    
    private var favourite: some View {
        Image(quizItem.favourite ? "star_yellow" : "star_grey")
            .resizable()
            .frame(width: 30, height:30)
            .scaledToFit()
            .foregroundColor(.white)
            .shadow(radius: 50)
            .padding(.leading, 15)
            
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
            QuizRow(quizItem: qm.quizzes[2])
        }
    }
}
