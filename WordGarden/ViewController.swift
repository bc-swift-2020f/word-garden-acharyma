//
//  ViewController.swift
//  WordGarden
//
//  Created by Manogya Acharya on 9/11/20.
//  Copyright © 2020 Manogya Acharya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!

    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var wordBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    
    var lettersGuessed = ""
    var revealedWord = ""
    var wordToGuess = "SWIFT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = guessedLetterTextField.text!
        guessLetterButton.isEnabled = !(text.isEmpty)
        revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        wordBeingRevealedLabel.text = revealedWord
    }
    
    func updateUIAfterGuess(){
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessLetterButton.isEnabled = false
    }

    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces)
        
        guessLetterButton.isEnabled = !(sender.text!.isEmpty)
    }
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        lettersGuessed = lettersGuessed + sender.text!
        revealedWord = ""
        print(lettersGuessed)
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord + "\(letter) "
            }
            else{
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
        print(revealedWord)
        wordBeingRevealedLabel.text = revealedWord
        
        updateUIAfterGuess()
    }
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        //dismisses keyboard
        lettersGuessed = lettersGuessed + guessedLetterTextField.text!
        revealedWord = ""
        print(lettersGuessed)
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord + "\(letter) "
            }
            else{
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
        print(revealedWord)
        wordBeingRevealedLabel.text = revealedWord
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }
    
    
}

