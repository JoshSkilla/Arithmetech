//
//  GoalsViewController.swift
//  Arithmetech
//
//  Created by Joshua Killa on 12/08/2022.
//

import UIKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var goalSlider: UISlider!
    @IBOutlet weak var questionAmount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Goals"
    }
    
    
    @IBAction func sliderValGet(_ sender: UISlider) {
        questionAmount.text = "\(Int(goalSlider.value))"
        let sliderAmount = Int(goalSlider.value)
        UserDefaults.standard.set(sliderAmount, forKey: "sliderAmount")
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
