//
//  ViewController.swift
//  WordGarden
//
//  Created by Manogya Acharya on 9/11/20.
//  Copyright © 2020 Manogya Acharya. All rights reserved.
//

import UIKit
import AVFoundation

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
    var wordsToGuess = ["SWIFT", "DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    var guessCount = 0
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = guessedLetterTextField.text!
        guessLetterButton.isEnabled = !(text.isEmpty)
        wordToGuess = wordsToGuess[currentWordIndex]
        revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        wordBeingRevealedLabel.text = revealedWord
        updateGameStatusLabels()
    }
    
    func updateUIAfterGuess(){
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessLetterButton.isEnabled = false
    }
    
    func formatRevealedWord(){
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
    }
    
    func updateAfterWinOrLose(){
        //increment currentwordIndex by 1
        //disable guessALetterTextField
        //disable button
        //set playAgain button.isHidden to false
        currentWordIndex += 1
        guessedLetterTextField.isEnabled = false
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = false
        
        updateGameStatusLabels()
    }
    
    func updateGameStatusLabels(){
        //update labels
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
        wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
        wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)"
    }
    
    func drawFlowerAndPlaySound(currentLetterGuessed: String){
        //update image, if needed, and keep track of wrong guesses
        if wordToGuess.contains(currentLetterGuessed) == false{
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                UIView.transition(with: self.flowerImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.flowerImageView.image = UIImage(named: "wilt\(self.wrongGuessesRemaining)")})
                { (_) in
                    //if not last, show next
                    //else play sound whistle and another transition
                    if self.wrongGuessesRemaining != 0 {
                        self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")
                    }
                    else{
                        self.playSound(name: "word-not-guessed")
                        UIView.transition(with: self.flowerImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")
                        }, completion: nil)

                    }
                    
                    
                }
                
                self.playSound(name: "incorrect")
            }
            
            
            
        }
        else{
            playSound(name: "correct")
        }
        
        
    }
    
    func guessALetter(){
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        
        formatRevealedWord()
        
        drawFlowerAndPlaySound(currentLetterGuessed: currentLetterGuessed)
        
        //update gameStatusMessage
        guessCount += 1
        let guesses = (guessCount == 1 ? "Guess" : "Guesses")
        gameStatusMessageLabel.text = "You've Made \(guessCount) \(guesses)"
        
        //after each guess
        //1 user won game... no more _
        //2 user lost game... wrongGuessesRemaining = 0
        
        if wordBeingRevealedLabel.text!.contains("_") == false{
            gameStatusMessageLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word."
            wordsGuessedCount += 1
            playSound(name: "word-guessed")
            updateAfterWinOrLose()
        }
        else if wrongGuessesRemaining == 0{
            gameStatusMessageLabel.text = "So sorry. You are out of guesses"
            wordsMissedCount += 1
            updateAfterWinOrLose()
        }
        
        //check to see if all games were played
        if currentWordIndex == wordsToGuess.count{
            gameStatusMessageLabel.text! += "\n\nYou've tried all of the words! Restart from the Beginning?"
        }
        
        
    }
    
    func playSound(name:String){
        if let sound = NSDataAsset(name: name){
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch{
                print("😡 ERROR: \(error.localizedDescription). Could not initialize AVAudioPlayer object")
            }
        } else{
            print("😡 ERROR: Could not read data from file \(name)")
        }
    }

    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces).uppercased()
        
        guessLetterButton.isEnabled = !(sender.text!.isEmpty)
    }
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        
        updateUIAfterGuess()
    }
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        //hide play again
        //enable letterGuessedText
        //currentWord set to next word
        //set wprdBeingRevealed.text to underscores seperated by spaces
        //set guessCount = 0
        //set flowerImageView to flower8
        //clear out lettersGuessed to ""
        //set gameStatusMessageLabel.text to 0 guesses
        if currentWordIndex == wordToGuess.count{
            currentWordIndex = 0
            wordsGuessedCount = 0
            wordsMissedCount = 0
        }
        
        
        playAgainButton.isHidden = true
        guessedLetterTextField.isEnabled = true
        guessLetterButton.isEnabled = false
        wordToGuess = wordsToGuess[currentWordIndex]
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        //create word with underscores
        revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        wordBeingRevealedLabel.text = revealedWord
        guessCount = 0
        flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuesses)")
        lettersGuessed = ""
        updateGameStatusLabels()
        gameStatusMessageLabel.text = "You've made Zero Guesses"
        
    }
    
    
}

