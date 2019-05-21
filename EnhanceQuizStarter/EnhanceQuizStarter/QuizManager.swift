//
//  QuizManager.swift
//  EnhanceQuizStarter
//
//  Created by Arwin Oblea on 5/19/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit

// manager that
// 1. initialize the questions
// 2. add to quiz
// 3. randomize the set
// 4. check if answer is correct

class QuizManager {

  let question1 = Question(question: "Only female koalas can whistle", options: ["Yes", "No"], answer: 2)
  let question2 = Question(question: "Blue whales are technically whales", options: ["Yes", "No"], answer: 1)
  let question3 = Question(question: "Camels are cannibalistic", options: ["Yes", "No"], answer: 2)
  let question4 = Question(question: "All ducks are birds", options: ["Yes", "No"], answer: 1)
  let question5 = Question(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 2)
  let question6 = Question(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 1)
  let question7 = Question(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: 3)
  let question8 = Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: 3)
  let question9 = Question(question: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], answer: 4)
  let question10 = Question(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argentina", "Spain"], answer: 2)
  let question11 = Question(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 2)
  let question12 = Question(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 1)
  let question13 = Question(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], answer: 1)
  let question14 = Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France", "Germany", "Japan", "Great Britian"], answer: 4)
  
  func randomQuestion() -> Question {
    let questions = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, question11, question12, question13, question14]
    let quiz = Quiz(quizArray: questions)
    guard let randomQuestion = quiz.quizArray.randomElement() else { return question1 }
    return randomQuestion
  }
  
  
}









