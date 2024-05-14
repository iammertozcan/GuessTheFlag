//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Mert Özcan on 3.04.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.systemGray.cgColor
        button2.layer.borderColor = UIColor.systemGray.cgColor
        button3.layer.borderColor = UIColor.systemGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " | SCORE: \(score)"
        questionCounter += 1
        if questionCounter > 10 {
            showFinalScore()
            return
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var wrongCountry: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            if countries[sender.tag] == "us" || countries[sender.tag] == "uk" {
                wrongCountry = countries[sender.tag].uppercased()
                message = "Wrong! That's the flag of \(wrongCountry)."
            } else {
                wrongCountry = countries[sender.tag].capitalized
                message = "Wrong! That's the flag of \(wrongCountry)."
            }
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    func showFinalScore() {
        let finalMessage = """
        Your final score is \(score). 
        Press OK to play again.
        """
        let ac = UIAlertController(title: "Quiz Over", message: finalMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.score = 0 // Reset score to zero
            self.questionCounter = 0 // Reset question counter to zero
            self.askQuestion() // Start a new game
        })
        present(ac, animated: true)
    }
    
}
