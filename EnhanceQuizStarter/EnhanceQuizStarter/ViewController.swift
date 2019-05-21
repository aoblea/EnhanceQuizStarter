//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

// TODO: Todo list
// 1. Refactor code to be neater

class ViewController: UIViewController {
  // MARK: - Properties
  let questionsPerRound = 4
  var questionsAsked = 0
  var correctQuestions = 0
  var indexOfSelectedQuestion = 0
  
  let quizManager = QuizManager()
  
  
  var isGameOver: Bool = false
  
  var gameSound: SystemSoundID = 0

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
    
    loadGameStartSound()
    playGameStartSound()
    
    displayQuestion()
  }

  // MARK: - Helpers
  func loadGameStartSound() {
    let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
  }

  func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
  }

  
  func displayQuestion() {
    isGameOver = false
    playAgainButton.setTitle("Next Question", for: .normal)
    
    // Reset button colors
    let buttonArray = [firstOptionButton, secondOptionButton, thirdOptionButton, fourthOptionButton]
    for button in buttonArray {
      button?.alpha = 1.0
      button?.backgroundColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1.0)
    }
    
    // Chooses a question randomly
    let finalQuestion = quizManager.randomQuestion()

    questionField.text = finalQuestion.question
    resultField.text = ""
    playAgainButton.isHidden = true
    
    // Set a tag number to each button
    firstOptionButton.tag = 0
    secondOptionButton.tag = 1
    thirdOptionButton.tag = 2
    fourthOptionButton.tag = 3
    
    // Matches tag of buttons with the options index and sets the title
    for (index, item) in finalQuestion.options.enumerated() {
      print("\(index) of \(item)")
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

    // Matches amount of choices to display
    if finalQuestion.options.count == 2 {
      thirdOptionButton.isHidden = true
      fourthOptionButton.isHidden = true
    } else {
      firstOptionButton.isHidden = false
      secondOptionButton.isHidden = false
      thirdOptionButton.isHidden = false
      fourthOptionButton.isHidden = false
    }
    
    // Round edges of buttons
    firstOptionButton.layer.cornerRadius = 10
    secondOptionButton.layer.cornerRadius = 10
    thirdOptionButton.layer.cornerRadius = 10
    fourthOptionButton.layer.cornerRadius = 10
    playAgainButton.layer.cornerRadius = 10
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

//  func loadNextRound(delay seconds: Int) {
//    // Converts a delay in seconds to nanoseconds as signed 64 bit integer
//    let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
//    // Calculates a time value to execute the method given current time and delay
//    let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
//
//    // Executes the nextRound method at the dispatch time on the main queue
//    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
//      self.nextRound()
//    }
//  }

  // MARK: - Actions
  @IBAction func checkAnswer(_ sender: UIButton) {
    // Increment the questions asked counter
    questionsAsked += 1

    let buttonArray = [firstOptionButton, secondOptionButton, thirdOptionButton, fourthOptionButton]
    
    let finalQuestion = quizManager.randomQuestion()
    let correctAnswer = finalQuestion.answer
    
    if (sender === firstOptionButton && correctAnswer == 1) || (sender === secondOptionButton && correctAnswer == 2) || (sender === thirdOptionButton && correctAnswer == 3) || (sender === fourthOptionButton && correctAnswer == 4) {
      
      correctQuestions += 1
      
      for button in buttonArray {
        button?.isEnabled = false
      }
      
      sender.isEnabled = true
      resultField.text = "Correct!"
    } else {
      
      for button in buttonArray {
        button?.isEnabled = false
      }
      
      sender.isEnabled = true
      resultField.text = "Sorry, wrong answer!"
    }
    
    playAgainButton.isHidden = false
//    loadNextRound(delay: 3)
  }

  @IBAction func playAgain(_ sender: UIButton) {
    // Enables the buttons
    let buttonArray = [firstOptionButton, secondOptionButton, thirdOptionButton, fourthOptionButton]
    for button in buttonArray {
      button?.isEnabled = true
    }
    
    // If game is over display "Play Again" else "Next Question"
    if isGameOver == true {
      playAgainButton.setTitle("Play Again", for: .normal)
      
      // Show the answer buttons
      firstOptionButton.isHidden = false
      secondOptionButton.isHidden = false
      thirdOptionButton.isHidden = false
      fourthOptionButton.isHidden = false
      
      // Reset button colors
      for button in buttonArray {
        button?.alpha = 1.0
        button?.backgroundColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1.0)
      }
      // Reset game
      questionsAsked = 0
      correctQuestions = 0
      nextRound()
    } else if isGameOver == false {
      playAgainButton.setTitle("Next Question", for: .normal)
      // Reset button colors
      let buttonArray = [firstOptionButton, secondOptionButton, thirdOptionButton, fourthOptionButton]
      for button in buttonArray {
        button?.alpha = 1.0
        button?.backgroundColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1.0)
      }
      nextRound()
    }
  }
}
