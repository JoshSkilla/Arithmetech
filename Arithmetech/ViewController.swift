//
//  ViewController.swift
//  Arithmetech
//
//  Created by Joshua Killa on 08/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //UI components
    @IBOutlet weak var simpleArithSwitch: UISwitch!
    @IBOutlet weak var LongArithSwitch: UISwitch!
    @IBOutlet weak var fractionsSwitch: UISwitch!
    @IBOutlet weak var algebraSwitch: UISwitch!
    @IBOutlet weak var exponentsSwitch: UISwitch!
    @IBOutlet weak var inequalitiesSwitch: UISwitch!
    
    
    //array that holds the question modes
    var questionTypes: [String] = []
    
    var warningMessage = UIAlertController(title: "Alert", message: "You need to select a question mode", preferredStyle: .alert)
    
    // Create OK button with action handler
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
     })
    


    
    //What happens after launch
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options"
        let sliderAmount = 50
        UserDefaults.standard.set(sliderAmount, forKey: "sliderAmount")

        
        warningMessage.addAction(ok)
        //Add OK button to the warning message
        //Here and not in button action so that multiple...
        //alert - actions are not added

    }
    
        
        
    
        //UI functions

    @IBAction func BarButtonPressed(_ sender: UIBarButtonItem) {
        if questionTypes.count > 0 {
            performSegue(withIdentifier: "segueToQVC", sender: nil)
            //View controller method to manually trigger segue
            
        } else {
            self.present(warningMessage, animated: true, completion: nil)
        }

    }
    
    @IBAction func SimpleArithSwitchFlipped(_ sender: Any) {
            if simpleArithSwitch.isOn {
                questionTypes.append("simpleArith")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "simpleArith"}

                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
        @IBAction func LongAirthSwitchFlipped(_ sender: UISwitch) {
            if LongArithSwitch.isOn {
                questionTypes.append("longArith")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "longArith"}
                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
        @IBAction func ExponentsSwitchFlipped(_ sender: UISwitch) {
            if exponentsSwitch.isOn {
                questionTypes.append("exponents")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "exponents"}
                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
        @IBAction func FractionsSwitchFlipped(_ sender: UISwitch) {
            if fractionsSwitch.isOn {
                questionTypes.append("fractions")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "fractions"}
                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
        @IBAction func AlgebraSwitchFlipped(_ sender: UISwitch) {
            if algebraSwitch.isOn {
                questionTypes.append("algebra")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "algebra"}
                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
        @IBAction func InequalitiesSwitchFlipped(_ sender: UISwitch) {
            if inequalitiesSwitch.isOn {
                questionTypes.append("inequalities")
                print(questionTypes)
            } else {
                questionTypes = questionTypes.filter{$0 != "inequalities"}
                print(questionTypes)
            }
            UserDefaults.standard.set(questionTypes, forKey: "questionTypes")
        }
}
    

