//
//  TwoPlayerViewController.swift
//  HangMan
//
//  Created by Ana Klabjan on 12/6/18.
//  Copyright © 2018 Ana Klabjan. All rights reserved.
//

import UIKit

class TwoPlayerViewController: UIViewController {
    
    @IBOutlet var wordTF: UITextField!
    @IBOutlet var catagoryTF: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var label: UILabel!
    var player = "Player One"
    
    var playerOne = 0
    var playerTwo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 15
        label.text = player
        label.adjustsFontSizeToFitWidth = true
        self.title = player
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
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "submit"
        {
            if wordTF.text != "" && catagoryTF.text != ""
            {
                if wordTF.text!.count < 11 && wordTF.text!.count > 3
                {
                    if wordIsReal(word: wordTF.text!)
                    {
                        if wordIsReal(word: catagoryTF.text!)
                        {
                            return true
                        }
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Error", message: "Please enter a real word for the word and catagoory.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                        }))
                        self.present(alert, animated: true)
                    }
                    
                }
                let alert = UIAlertController(title: "Error", message: "Your word needs to be between 4 and 10 letters long.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                }))
                self.present(alert, animated: true)
                return false
            }
            
        }
        let alert = UIAlertController(title: "Error", message: "You need to type in a word and catagory to continue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
        return false
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        var temp = ""
        if player == "Player One"
        {
            temp = "Player Two"
        }
        else{
            temp = "Player One"
        }
        let alert = UIAlertController(title: "Pass phone to \(temp).", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        {
        case "submit":
            let viewController = segue.destination as! GameViewController
            viewController.hangMan.word = wordTF.text!
            viewController.hangMan.catagory = catagoryTF.text!
            viewController.isTwoPlayer = true
            viewController.playerOne = self.playerOne
            viewController.playerTwo = self.playerTwo
            if self.player == "Player One"
            {
                viewController.player = "Player Two"
            }
            else
            {
                viewController.player = "Player One"
            }
        default: ()
        }
    }
    
    func wordIsReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}
