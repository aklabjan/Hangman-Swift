//
//  HangMan.swift
//  HangMan
//
//  Created by Ana Klabjan on 12/3/18.
//  Copyright © 2018 Ana Klabjan. All rights reserved.
//


import Foundation
class HangMan
{
    let animals = ["duck", "whale", "turtle", "moose", "mouse", "lizard", "bear", "donkey", "tiger"]
    let colors = ["red", "orange", "yellow", "green", "blue", "purple", "pink", "teal", "gray"]
    let food = ["burger", "lettuce", "carrot", "oatmeal", "bread", "pasta", "soup", "cheese", "cereal"]
    var word = ""
    var count = 0
    var catagory = ""
    var numberWrong = 0
    
    func updateWord()
    {
        if count == 0
        {
            word = animals.randomElement()!
            count = 2
            catagory = "animals"
        }
        else if count == 1
        {
            word = colors.randomElement()!
            count = 2
            catagory = "colors"
        }
        else
        {
            word = food.randomElement()!
            count = 0
            catagory = "food"
        }
        numberWrong = 0
    }
    
    func updateHangMan() -> String
    {
        if numberWrong == 0
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |      \n" +
                "  |    \n" +
                "  |     \n" +
                "  |     \n" +
            "_|_"
        }
        else if numberWrong == 1
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    \n" +
                "  |     \n" +
                "  |    \n" +
            "_|_"
        }
        else if numberWrong == 2
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |     |\n" +
                "  |      \n" +
                "  |     \n" +
            "_|_"
        }
        else if numberWrong == 3
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    /|\n" +
                "  |     \n" +
                "  |    \n" +
            "_|_"
        }
        else if numberWrong == 4
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    /|\\\n" +
                "  |     \n" +
                "  |     \n" +
            "_|_"
        }
        else if numberWrong == 5
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    /|\\\n" +
                "  |     | \n" +
                "  |    \n" +
            "_|_"
        }
        else if numberWrong == 6
        {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    /|\\\n" +
                "  |     | \n" +
                "  |    / \n" +
            "_|_"
        }
        else {
            return "  ____ \n" +
                "  |     | \n" +
                "  |     o \n" +
                "  |    /|\\\n" +
                "  |     | \n" +
                "  |    / \\ \n" +
            "_|_"
        }
    }
}
