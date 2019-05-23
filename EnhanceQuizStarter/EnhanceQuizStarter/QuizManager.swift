//
//  QuizManager.swift
//  EnhanceQuizStarter
//
//  Created by Arwin Oblea on 5/19/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit

// Put game logic here

class QuizManager {
  // MARK: - Properties
  let quiz = Quiz()
  var arrayOfMultipleQuestions: [Question] = []
  
  // Picks out random question from array
  func randomQuestion() -> Question {
    let questions = [quiz.question1, quiz.question2,quiz.question3, quiz.question4, quiz.question5, quiz.question6, quiz.question7, quiz.question8, quiz.question9, quiz.question10, quiz.question11, quiz.question12, quiz.question13, quiz.question14]
    
    // Multiply the items in the array and append to arrayOfMultipleQuestions
    for x in questions {
      let multipleQuestions = Array(repeating: x, count: 2)
      arrayOfMultipleQuestions.append(contentsOf: multipleQuestions)
    }
    
    guard let randomQuestion = arrayOfMultipleQuestions.randomElement() else { return quiz.question1 }
    return randomQuestion
  }
  
  func checkAnswer(question: Question, button: UIButton) -> Bool {
    // Subtracted 1 from question.answer to match button tag
    if question.answer-1 == button.tag {
      return true
    } else {
      return false
    }
  }
}









