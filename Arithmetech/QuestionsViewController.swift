//
//  QuestionsViewController.swift
//  Arithmetech
//
//  Created by Joshua Killa on 09/08/2022.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var answer = String()
    let operators = ["+","-","×","÷"]
    var questionTypes = UserDefaults.standard.object(forKey: "questionTypes") as! [String]
    // // forced unwrap

    var goalNotCompleted = true
    
    var sliderAmount = UserDefaults.standard.object(forKey: "sliderAmount") as! Int
    
    var congratsMessage = UIAlertController(title: "Well Done!", message: "You have completed your goal!", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
     })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Questions"
        congratsMessage.addAction(ok)


        answer = SelectQuestion()
        print(answer)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sliderAmount = UserDefaults.standard.object(forKey: "sliderAmount") as! Int
    }
    
    
    
    @IBAction func GetFieldVal(_ sender: UITextField) {
        print(textField.text)
        var decimal = "\u{1D465}" //an untypable unicode value
        var answer2 = "\u{1D465}"
        if answer.contains("/") {
            let slashIndex = answer.firstIndex(of: "/")
            let beforeSlash = answer[...(answer.index(slashIndex!, offsetBy: -1))]
            let afterSlash = answer[(answer.index(slashIndex!, offsetBy: 1))...]
            
            decimal = String((Double(Int(beforeSlash)!))/(Double(Int(afterSlash)!)))
        }
        if answer.contains(",") {
            let commaIndex = answer.firstIndex(of: ",")
            let beforeComma = answer[...(answer.index(commaIndex!, offsetBy: -1))]
            let afterComma = answer[(answer.index(commaIndex!, offsetBy: 1))...]
            
            answer2 = "\(afterComma),\(beforeComma)"
        }
        //Checks for quadratic roots in reverse format
        
        if textField.text == answer || textField.text == decimal || textField.text == answer2 {
            progressBar.progress += Float(1.0/Float(sliderAmount))
            
            answer = SelectQuestion()
            print(answer)
            textField.text = ""
            if progressBar.progress == 1 && goalNotCompleted {
                self.present(congratsMessage, animated: true, completion: nil)
                goalNotCompleted = false
            }
        }
    }
    
    
    //functions
    func SelectQuestion() -> String {
        textField.placeholder = "0"
        if questionTypes.count > 0 {
            
            var type = Int.random(in: 0...(questionTypes.count-1))
            switch questionTypes[type] {
                
                case "simpleArith":
                    let op = operators[Int.random(in: 0...3)]
                    return String(OperatorSwitchSimple(op: op))
                    
                    //if userInput == answer {print("Correct Answer")} else {print("Wrong! \(answer) was the correct answer")}
                    
                    
                case "longArith":
                    let op = operators[Int.random(in: 0...3)]
                    return String(OperatorSwitchLong(op: op))

                
                case "fractions":
                    let num1 = Int.random(in: -6...6)
                    let den1 = Int.random(in: 1...6)
                
                    let num2 = Int.random(in: -6...6)
                    let den2 = Int.random(in: 1...6)
                
                    if Int.random(in: 0...1) == 1 {
                         
                        print("\(num1)/\(den1) + \(num2)/\(den2)")
                        QuestionLabel.text = "\(num1)/\(den1) + \(num2)/\(den2)"
                        return addFraction(num1: num1, den1: den1, num2: num2, den2: den2)
                    } else {
                        print("\(num1)/\(den1) × \(num2)/\(den2)")
                        QuestionLabel.text = "\(num1)/\(den1) × \(num2)/\(den2)"
                        let num3 = num1 * num2
                        let den3 = den1 * den2
                        return lowest(den3: den3, num3: num3)
                    }

                    
                     
                case "algebra":
                if Int.random(in: 0...1) == 1 {
                    textField.placeholder = "x"
                    let num1 = Int.random(in: -10...10)
                    var num2 = Int.random(in: 1...5)
                    if Int.random(in: 0...1)==1{
                        num2 = num2 * -1
                    }
                    let num3 = Int.random(in: -10...10)
                    let x = lowest(den3: num2, num3: (num3-num1))
                    
                    print("\(num1)+\(num2)x = \(num3)")
                    if num2>0 {
                        QuestionLabel.text = "\(num1)+\(num2)\u{1D465} = \(num3)"
                    } else {
                        QuestionLabel.text = "\(num1)-\(num2 * -1)\u{1D465} = \(num3)"
                    }
                    return x
                } else {
                    textField.placeholder = "x\u{2081},x\u{2082}"
                    //unicode of subscript 1,2
                    //shows user format of roots
                    
                    var x1 = Int.random(in: 1...10)
                    var x2 = Int.random(in: 1...10)
                    //generates the roots
                    
                    if Int.random(in: 0...1) == 1 {x1 = x1 * -1}
                    if Int.random(in: 0...1) == 1 {x2 = x2 * -1}
                    QuestionLabel.text = Exponentize(str: "\u{1D465}^2\(plusMinus(num: ((-1 * x1) + (-1 * x2))))\u{1D465}\(plusMinus(num: ((-1 * x1)*(-1 * x2))))=0")
                    return "\(x1),\(x2)"
                    
                    
                }
                case "exponents":
                    let num1 = Int.random(in: 2...13)
                    let num2 = ExponentRestrictions(num: num1)
                    let num3: Int = Int(pow(Double(num1),Double(num2)))
                    if 1 == Int.random(in: 1...2) {
                        print("What is \(num1)^\(num2)")
                        QuestionLabel.text = Exponentize(str: "\(num1)^\(num2)")
                        return String(num3)
                    } else {
                        print("What is x? \(num1)^x = \(num3)")
                        QuestionLabel.text = Exponentize(str: "\(num1)^x = \(num3)")
                        return String(num2)
                    }
                    
                case "inequalities":
                //each branch has 1/3 chance
                textField.placeholder = "> or <"
                if Int.random(in: 1...3) == 1 {
                    let num1 = Double.random(in: -1 ... 1)
                    var num1Str = String(num1)
                    num1Str = String(num1Str[num1Str.startIndex...(num1Str.index(num1Str.startIndex, offsetBy: 3))])
                    let num2 = Int.random(in: -1...1)
                    var num2Str = String()
                    let trigMinus1 = ["sin(-90°)","cos(180°)","sin(270°)","tan(-45°)"]
                    let trig0 = ["sin(0°)","sin(360°)","cos(-90°)","cos(90°)","tan(0°)"]
                    let trig1 = ["sin(90°)","cos(0°)","cos(360°)","tan(45°)"]
                    if num2 == -1 {
                        num2Str = trigMinus1[Int.random(in: 0...(trigMinus1.count-1))]
                    } else if num2 == 1{
                        num2Str = trig1[Int.random(in: 0...(trig1.count-1))]
                    } else {
                        num2Str = trig0[Int.random(in: 0...(trig0.count-1))]
                    }
                    QuestionLabel.text = "\(num2Str) ? \(num1Str)"
                    if Double(num2) > num1 {
                        return ">"
                    } else {
                        return "<"
                    }
                } else {
                    let num1 = Double.random(in: 0...1)
                    print(num1)
                    var num1Str = String(num1)
                    num1Str = String(num1Str[num1Str.startIndex...(num1Str.index(num1Str.startIndex, offsetBy: 3))])
                    //shortens double
                    
                    if Int.random(in: 1...2) == 1 {
                        let pointIndex = String(num1).firstIndex(of: ".")!
                        var decimalFirstChar = num1Str[(num1Str.index(pointIndex, offsetBy: 1))...(num1Str.index(pointIndex, offsetBy: 1))]
                        let num = Int(decimalFirstChar)!+Int.random(in: -2...2)
                        //can make fraction negative
                        let den = 10+Int.random(in: -1...1)
                        var num2 = lowest(den3: den, num3: num)
                        if let i = num2.firstIndex(of: "-") {
                            num2.remove(at: i)
                        }
                        //removes minus sign (if there were one)
                        QuestionLabel.text = "\(num1Str) ? \(num2)"
                        if num1 < (Double(num)/Double(den)) {
                            return "<"
                        } else {
                            return ">"
                        }
                    } else {
                        let base = Int.random(in: 2...4)
                        let power = Int.random(in: 1...3)
                        let num2 = pow(Double(base), Double(power * -1))
                        let num2Str = Exponentize(str: "\(base)\u{207B}^\(power)")
                        // unicode is superscript minus sign
                        
                        QuestionLabel.text = "\(num1Str) ? \(num2Str)"
                        if num1 < num2 {
                            return "<"
                        } else {
                            return ">"
                        }
                    }
                }
    
                default:
                    print("invalid type")
            }
        } else {
            print("No buttons selected")
        }
        return "error"
    }

    func OperatorSwitchSimple(op: String) ->Int {
        switch op {
            case "+":
                let num1 = Int.random(in: -20...20)
                let num2 = Int.random(in: -20...20)
                print("What is the answer to \(num1) + \(num2)")
                QuestionLabel.text = "\(num1) + \(num2)"
                return num1+num2
            case "-":
                let num1 = Int.random(in: -20...20)
                let num2 = Int.random(in: -20...20)
                print("What is the answer to \(num1) - \(num2)")
                QuestionLabel.text = "\(num1) - \(num2)"
                return num1-num2
            case "×":
                let num1 = Int.random(in: -13...13)
                let num2 = Int.random(in: -13...13)
                print("What is the answer to \(num1) × \(num2)")
                QuestionLabel.text = "\(num1) × \(num2)"
                return num1*num2
            default:
                let num1 = Int.random(in: -13...13)
                var num2 = Int.random(in: 1...13)
                if 1 == Int.random(in: 1...2) {
                    num2 *= -1
                }
                let num3 = num1*num2
                print("What is the answer to \(num3) ÷ \(num2)")
                QuestionLabel.text = "\(num3) ÷ \(num2)"
                return num1
            }
    }

    func OperatorSwitchLong(op: String) ->Int {
        switch op {
            case "+":
                let num1 = Int.random(in: -200...500)
                let num2 = Int.random(in: -50...300)
                print("What is the answer to \(num1) + \(num2)")
                QuestionLabel.text = "\(num1) + \(num2)"
                return num1+num2
            case "-":
                let num1 = Int.random(in: -200...500)
                let num2 = Int.random(in: -200...500)
                print("What is the answer to \(num1) - \(num2)")
                QuestionLabel.text = "\(num1) - \(num2)"
                return num1-num2
            case "×":
                let num1 = Int.random(in: -20...50)
                let num2 = Int.random(in: -20...20)
                print("What is the answer to \(num1) × \(num2)")
                QuestionLabel.text = "\(num1) × \(num2)"
                return num1*num2
            default:
                let num1 = Int.random(in: -16...30)
                var num2 = Int.random(in: 1...13)
                if 1 == Int.random(in: 1...2) {
                    num2 *= -1
                }
                let num3 = num1*num2
                print("What is the answer to \(num3) ÷ \(num2)")
                QuestionLabel.text = "\(num3) ÷ \(num2)"
                return num1
            }
    }

    func ExponentRestrictions(num: Int) ->Int {
        
        if num>=7 {return 2} else if num>=5{return Int.random(in: 2...3)} else {return Int.random(in: 2...5)}
    }
    
    func Exponentize(str: String) -> String {

        let supers = [
            "1": "\u{00B9}",
            "2": "\u{00B2}",
            "3": "\u{00B3}",
            "4": "\u{2074}",
            "5": "\u{2075}",
            "6": "\u{2076}",
            "7": "\u{2077}",
            "8": "\u{2078}",
            "9": "\u{2079}",
            "x": "\u{02E3}"]

        var newStr = ""
        var isExp = false
        for char in str{
            if char == "^" {
                isExp = true
            } else {
                if isExp {
                    let key = String(char)
                    if supers.keys.contains(key) {
                        newStr.append(Character(supers[key]!))
                    } else {
                        isExp = false
                        newStr.append(char)
                    }
                } else {
                    newStr.append(char)
                }
            }
        }
        return newStr
    }
    
    func plusMinus(num: Int) -> String {
        var str = String()
        if num>=0 {
            str = "+\(num)"
        } else {
            str = "\(num)"
        }
        
        return str
    }
    
    // Recursive func for greatest common denominator
    func gcd(a: Int, b: Int) -> Int {
        if (a == 0){
            return b
        }
        return gcd(a: (b % a), b: a)
    }
     
    // Function to convert the obtained fraction...
    // into it's simplest form.
    func lowest(den3: Int, num3: Int) -> String {
     
        // Finding gcd of both terms
        let common_factor = gcd(a: num3, b: den3)
     
        // Converting both terms
        // into simpler terms by
        // dividing them by common factor
        var den3 = (den3 / common_factor)
        var num3 = (num3 / common_factor)
        if den3 < 0 {
            den3 = den3 * -1
            num3 = num3 * -1
        }
        let pointIndex = String(Double(num3)/Double(den3)).firstIndex(of: ".")!
        // Only Double division preserves decimal
        let decimal = String(Double(num3)/Double(den3))[pointIndex...]
        print("\(num3)/\(den3)")
        
        if decimal == ".0" {
            return String((num3)/(den3))
        } else {
            return ("\((num3))/\((den3))")
        }
        //verifies that the fraction cannot be simplified to an integer
        
    }
     
    // Function to add two fractions
    func addFraction(num1:Int, den1:Int, num2:Int, den2:Int) -> String{
     
        // Finding gcd of den1 and den2
        var den3 = gcd(a: den1, b: den2)
     
        // Denominator of final
        // fraction obtained finding
        // LCM of den1 and den2
        // LCM * GCD = a * b
        den3 = (den1 * den2) / den3
     
        // Changing the fractions to
        // have same denominator Numerator
        // of the final fraction obtained
        let num3 = ((num1) * (den3 / den1) + (num2) * (den3 / den2))
     
        // Calling function to convert
        // final fraction into it's
        // simplest form
        return lowest(den3: den3, num3: num3)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
