//
//  GameViewController.swift
//  HangMan
//
//  Created by Ana Klabjan on 12/3/18.
//  Copyright © 2018 Ana Klabjan. All rights reserved.
//


import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var hangMan = HangMan()
    var isTwoPlayer = false
    var playerOne = 0
    var playerTwo = 0
    var player = ""
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var catagoryLabel: UILabel!
    @IBOutlet var incorrectLettersLabel: UILabel!
    @IBOutlet var letterTF: UITextField!
    @IBOutlet var wordTF: UITextField!
    @IBOutlet var pictureLabel: UILabel!
    @IBOutlet var letterButton: UIButton!
    @IBOutlet var wordButton: UIButton!
    
    @IBAction func checkLetter(_ sender: UIButton) {
        if letterTF.text != "" && letterTF.text!.count == 1
        {
            if hangMan.word.contains(letterTF.text!)
            {
                var occurences = hangMan.word.indicesOf(string: letterTF.text!)
                while occurences.count > 0
                {
                    let characters = Array(letterTF.text!)
                    wordLabel.text = replace(myString: wordLabel.text!, occurences[0]*2, characters[0])
                    occurences.remove(at: 0)
                }
                if hangMan.word == wordLabel.text!.replacingOccurrences(of: " ", with: "")
                {
                    correct()
                }
                self.playSound(sound: "clap")
            }
            else
            {
                if incorrectLettersLabel.text!.contains(letterTF.text!) == false
                {
                    incorrectLettersLabel.text = incorrectLettersLabel.text! + "\(letterTF.text!) "
                    checkIfNoMoreAttempts()
                    self.playSound(sound: "boo")
                }
            }
        }
    }
    
    @IBAction func guessWord(_ sender: UIButton) {
        if wordTF.text != ""
        {
            if wordTF.text == hangMan.word
            {
                correct()
                self.playSound(sound: "clap")
            }
            else
            {
                checkIfNoMoreAttempts()
                self.playSound(sound: "boo")
            }
        }
    }
    
    override func viewDidLoad() {
        
        
        restart()
        
        letterButton.layer.cornerRadius = 15
        wordButton.layer.cornerRadius = 15
        
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(GameViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func becomeFirstResponder() -> Bool
    {
        return true
    }
    
    @objc func didTapView()
    {
        self.view.endEditing(true)
    }
    
    func restart()
    {
        if isTwoPlayer == false
        {
            hangMan.updateWord()
        }
        else
        {
            self.title = player
        }
        if hangMan.word.count == 4
        {
            wordLabel.text = "_ _ _ _"
        }
        else if hangMan.word.count == 5
        {
            wordLabel.text = "_ _ _ _ _"
        }
        else if hangMan.word.count == 6
        {
            wordLabel.text = "_ _ _ _ _ _"
        }
        else if hangMan.word.count == 7
        {
            wordLabel.text = "_ _ _ _ _ _ _"
        }
        else if hangMan.word.count == 8
        {
            wordLabel.text = "_ _ _ _ _ _ _ _"
        }
        else if hangMan.word.count == 9
        {
            wordLabel.text = "_ _ _ _ _ _ _ _ _"
        }
        else
        {
            wordLabel.text = "_ _ _ _ _ _ _ _ _ _"
        }
        catagoryLabel.text = "Catagory: \(hangMan.catagory)"
        incorrectLettersLabel.text = ""
        pictureLabel.text = hangMan.updateHangMan()
        
        print(hangMan.word)
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)  
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func checkIfNoMoreAttempts()
    {
        hangMan.numberWrong += 1
        pictureLabel.text = hangMan.updateHangMan()
        if hangMan.numberWrong == 7
        {
            if isTwoPlayer == false
            {
                let alert = UIAlertController(title: "Sorry you ran out of attempts.", message: "Would you like to play again?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.restart()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
                self.present(alert, animated: true)
            }
            else
            {
                if player == "Player Two"
                {
                    playerOne += 1
                }
                else
                {
                    playerTwo += 1
                }
                let alert = UIAlertController(title: "You lost this round. Would you like to keep play?", message: "Player One: \(playerOne) Player Two: \(playerTwo)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.performSegue(withIdentifier: "twoPlayer", sender: self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        {
        case "twoPlayer":
            let viewController = segue.destination as! TwoPlayerViewController
            viewController.player = self.player
            viewController.playerOne = self.playerOne
            viewController.playerTwo = self.playerTwo
        default: ()
        }
    }
    
    func correct()
    {
        if isTwoPlayer == false{
            let alert = UIAlertController(title: "You win!", message: "Would you like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.restart()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
            self.present(alert, animated: true)
        }
        else
        {
            if player == "Player Two"
            {
                playerTwo += 1
            }
            else
            {
                playerOne += 1
            }
            let alert = UIAlertController(title: "You won this round. Would you like to keep play?", message: "Player One: \(playerOne) Player Two: \(playerTwo)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.performSegue(withIdentifier: "twoPlayer", sender: self)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func playSound(sound: String)
    {
        let fileURL = Bundle.main.path(forResource: sound, ofType: "mp3")
        if let fileURL = Bundle.main.path(forResource: sound, ofType: "mp3") {
            print("Continue processing")
        } else {
            print("Error: No file with specified name exists")
        }
        do {
            if let fileURL = Bundle.main.path(forResource: sound, ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.play()
    }
}

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
    }
}
