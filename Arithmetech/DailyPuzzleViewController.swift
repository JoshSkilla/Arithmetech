//
//  DailyPuzzleViewController.swift
//  Arithmetech
//
//  Created by Joshua Killa on 12/08/2022.
//

import UIKit

class DailyPuzzleViewController: UIViewController {
    
    @IBOutlet weak var ansField: UITextField!
    @IBOutlet weak var puzzleLabel: UILabel!
    
    var puzzleNum = Int()
    var answer = String()
    let puzzleQs = ["Kaori writes a sequence with the property that after the first two terms in the sequence, each term is equal to one more than the term before it, minus the term before that. In other words, tn = 1 + tn−1 − tn−2, for n ≥ 3, where tn denotes the nth term in the sequence. \n The first term in Kaori’s sequence is x and the second term is y, where x and y are real numbers. That is, t1 = x and t2 = y. Determine the sum of the first 2021 terms in her sequence, as an expression in terms of x and y.", "Faisal chooses four numbers. When each number is added to the mean (average) of the other three, the following sums are obtained: 25, 37, 43, and 51. \n Determine the mean of the four numbers Faisal chose.", "The six faces of a cube have each been marked with one of the numbers 1, 2, 3, 4, 5, and 6, with each number being used exactly once. \n Three people, Paul, Lee, and Jenny, are seated around a square table. \n The cube is placed on the table so that from their different seat locations, each one can see the top face and two adjacent side faces. No two people see the same pair of adjacent side faces. \n When Paul adds the three numbers that he can see, his total is 9. When Lee adds the three numbers that they can see, their total is 14. When Jenny adds the three numbers that she can see, her total is 15. \n Determine all possibilities for the number on the bottom face of the cube.","A rectangular prism is placed on a table. Points P , Q, and R lie on three different faces of the prism with P on the top face and Q and R on two adjacent side faces. Each point is located where the diagonals of the particular face intersect. Connecting these three points gives us △PQR."]
    let puzzleAns = ["2021+y−x","19.5","2","90√6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //(UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        title = "Daily Puzzle"
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        if Int(day) <= 7 {
            puzzleNum = 0
        } else if Int(day) <= 14 {
            puzzleNum = 1
        } else if Int(day) <= 21 {
            puzzleNum = 2
        } else if Int(day) <= 31 {
            puzzleNum = 3
        }
        // Can be extended to provide a puzzle for each day
        puzzleLabel.text = puzzleQs[puzzleNum]
        answer = puzzleAns[puzzleNum]
        print(answer)
        

    }
    
    @IBAction func AnsFieldChanged(_ sender: UITextField) {
        print(ansField.text)
        if ansField.text == answer {
            ansField.text = ""
            ansField.placeholder = "Correct!"
        }
    }
        
    

     

}
