//
//  JeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Player{
    var questions: [JeopardyQuestion]
    var score = 0
    var nextQuestionCounter = 1
    var currentQuestion: JeopardyQuestion
    var answer = ""
    init(questions: [JeopardyQuestion]) {
        self.currentQuestion = questions.first!
        self.questions = questions
    }
    func checkAnswer(inputAnswer: String) -> Bool {
        if inputAnswer.lowercased() == currentQuestion.answer.lowercased(){
            score += 1
            return true
        }
        else{
            guard score != 0 else{
                return false
            }
            score -= 1
            return false
        }
    }
    func nextQuestion() {
        guard nextQuestionCounter < questions.count else{
            nextQuestionCounter = 0
            currentQuestion = questions.first!
            return
        }
        currentQuestion = questions[nextQuestionCounter]
        nextQuestionCounter += 1
        return
    }
}
