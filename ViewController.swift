//
//  ViewController.swift
//  HangMan
//  Created by Ana Klabjan on 12/3/18.
//  Copyright © 2018 Ana Klabjan. All rights reserved.
//
//  Ana Klabjan
//  HangMan
//  It allows the user to either play solo with a computer generated word or two player game with user created word.
//  recieve random element from array: https://learnappmaking.com/random-numbers-swift/#random-numbers
//  extention of string class inorder to find all occurances of charactor in string
//  https://stackoverflow.com/questions/40413218/swift-find-all-occurrences-of-a-substring
//  replace charactor in string https://stackoverflow.com/questions/24789515/how-to-replace-nth-character-of-a-string-with-another
//  play sound https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
//  check to use apple's dictionary to check if valid word https://stackoverflow.com/questions/32603825/swift-open-built-in-ios-dictionary-to-find-word-meaning

import UIKit

class ViewController: UIViewController {
    @IBOutlet var startGame: UIButton!
    @IBOutlet var twoPlayerGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame.layer.cornerRadius = 10
        twoPlayerGame.layer.cornerRadius = 10
        startGame.titleLabel?.adjustsFontSizeToFitWidth = true
        twoPlayerGame.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
}

