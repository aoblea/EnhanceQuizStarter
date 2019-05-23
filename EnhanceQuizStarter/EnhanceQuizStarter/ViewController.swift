//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
  // MARK: - Properties
  let questionsPerRound = 4
  var questionsAsked = 0
  var correctQuestions = 0
  var indexOfSelectedQuestion = 0
  
  let quizManager = QuizManager()
  let soundManager = SoundManager()
  
  var buttonArray: [UIButton] = []
  var isGameOver: Bool = false
  var question: Question!

  // MARK: - Outlets
  @IBOutlet weak var questionField: UILabel!
  @IBOutlet weak var resultField: UILabel!
  
  @IBOutlet weak var firstOptionButton: UIButton!
  @IBOutlet weak var secondOptionButton: UIButton!
  @IBOutlet weak var thirdOptionButton: UIButton!
  @IBOutlet weak var fourthOptionButton: UIButton!
  @IBOutlet weak var playAgainButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buttonArray = [firstOptionButton, secondOptionButton, thirdOptionButton, fourthOptionButton]

    soundManager.loadGameStartSound()
    soundManager.playGameStartSound()
    
    setupButtons()
    displayQuestion()
  }
  
  func setupButtons() {
    // Set a tag number to each button
    firstOptionButton.tag = 0
    secondOptionButton.tag = 1
    thirdOptionButton.tag = 2
    fourthOptionButton.tag = 3
    
    // Round the corners of buttons
    let radiusConstant: CGFloat = 10
    
    firstOptionButton.layer.cornerRadius = radiusConstant
    secondOptionButton.layer.cornerRadius = radiusConstant
    thirdOptionButton.layer.cornerRadius = radiusConstant
    fourthOptionButton.layer.cornerRadius = radiusConstant
    playAgainButton.layer.cornerRadius = radiusConstant
  }

  // Displays a random question
  func displayQuestion() {
    isGameOver = false
    playAgainButton.setTitle("Next Question", for: .normal)
    
    question = quizManager.randomQuestion()
    let randomQuestion = question.question
    
    questionField.text = randomQuestion
    resultField.text = ""
    playAgainButton.isHidden = true
    
    // Matches the buttons tag with the options index and sets the title
    for (index, item) in question.options.enumerated() {
      if index == firstOptionButton.tag {
        firstOptionButton.setTitle(item, for: .normal)
      }
      if index == secondOptionButton.tag {
        secondOptionButton.setTitle(item, for: .normal)
      }
      if index == thirdOptionButton.tag {
        thirdOptionButton.setTitle(item, for: .normal)
      }
      if index == fourthOptionButton.tag {
        fourthOptionButton.setTitle(item, for: .normal)
      }
    }

    // Matches amount of choices to display 2 or 4 buttons
    if question.options.count == 2 {
      thirdOptionButton.isHidden = true
      fourthOptionButton.isHidden = true
    } else {
      firstOptionButton.isHidden = false
      secondOptionButton.isHidden = false
      thirdOptionButton.isHidden = false
      fourthOptionButton.isHidden = false
    }
  }
  
  func displayScore() {
    // Hide the answer buttons
    firstOptionButton.isHidden = true
    secondOptionButton.isHidden = true
    thirdOptionButton.isHidden = true
    fourthOptionButton.isHidden = true

    // Display play again button
    playAgainButton.setTitle("Play Again", for: .normal)
    playAgainButton.isHidden = false
    
    resultField.text = ""
    questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
  }

  func nextRound() {
    if questionsAsked == questionsPerRound {
      // Game is over
      isGameOver = true
      displayScore()
    } else {
      // Continue game
      isGameOver = false
      displayQuestion()
    }
  }

  // MARK: - Actions
  @IBAction func checkAnswer(_ sender: UIButton) {
    // Increment the questions asked counter
    questionsAsked += 1
    
    // Compare button.tag with question.answer
    let checkFirstOption = quizManager.checkAnswer(question: question, button: firstOptionButton)
    let checkSecondOption = quizManager.checkAnswer(question: question, button: secondOptionButton)
    let checkThirdOption = quizManager.checkAnswer(question: question, button: thirdOptionButton)
    let checkFourthOption = quizManager.checkAnswer(question: question, button: fourthOptionButton)

    if (sender === firstOptionButton && checkFirstOption == true) ||
      (sender === secondOptionButton && checkSecondOption == true) ||
      (sender === thirdOptionButton && checkThirdOption == true) ||
      (sender === fourthOptionButton && checkFourthOption == true) {
    
      correctQuestions += 1
    
      for button in buttonArray {
        button.isEnabled = false
      }
      
      sender.isEnabled = true
      resultField.text = "Correct!"
      
    } else {
      
      for button in buttonArray {
        button.isEnabled = false
      }
      
      sender.isEnabled = true
      resultField.text = "Sorry, wrong answer!"
    }
    
    playAgainButton.isHidden = false
  }

  @IBAction func playAgain(_ sender: UIButton) {
    // Enable the buttons
    for button in buttonArray {
      button.isEnabled = true
    }
    
    // If game is over display "Play Again" else "Next Question"
    if isGameOver == true {
      playAgainButton.setTitle("Play Again", for: .normal)
      
      // Show the answer buttons
      firstOptionButton.isHidden = false
      secondOptionButton.isHidden = false
      thirdOptionButton.isHidden = false
      fourthOptionButton.isHidden = false
      
      // Reset game
      questionsAsked = 0
      correctQuestions = 0
      nextRound()
      
    } else if isGameOver == false {
      playAgainButton.setTitle("Next Question", for: .normal)
      nextRound()
    }
  }
  
}
