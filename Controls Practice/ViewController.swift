//
//  ViewController.swift
//  Controls Practice
//
//  Created by Andrey Pereslavtsev on 17.11.2020.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var switches: [UISwitch]!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var textfield: UITextField!
    
    var number  = 0 {
        didSet {
            self.number = ( number + 256 ) % 256
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        rotateSwitches()
    }
    
    func rotateSwitches() {
        for `switch` in switches {
            `switch`.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        }
    }
    
    func updateSwitches() {
        for s in switches {
            s.isOn = (Int(number) & s.tag) != 0
        }
    }
    
    func updateNumberFromSwitches() {
        var i: Int = 0
        for s in switches {
            i +=  s.isOn ? s.tag : 0
        }
        number = ( i % 256 )
    }

    func updateUI() {
        button.setTitle("\(number)", for: [])
        updateSwitches()
        slider.value = Float(number)
        textfield.text = ("\(number)")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        number = ((Int(number)+1)%256)
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        updateNumberFromSwitches()
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        number = Int(slider.value)
    }
    
    @IBAction func textfieldEdited(_ sender: UITextField) {
        number =  Int(textfield.text ?? "") ?? 128
    }
    
    @IBAction func sreenTapped(_ sender: UITapGestureRecognizer) {
        let loc = sender.location(in: view)
        if loc.x < view.bounds.midX {
            number -= 1
        } else {
            number += 1
        }
        print(#line,#function, sender.location(in: view))
    }
    
}

