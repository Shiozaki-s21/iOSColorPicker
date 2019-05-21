//
//  ViewController.swift
//  ColorPicker
//
//  Created by SubaruShiozaki on 2019-04-15.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // view for color
  @IBOutlet var colorView: UIView!
  
  // switches
  @IBOutlet var redSwitch: UISwitch!
  @IBOutlet var greenSwitch: UISwitch!
  @IBOutlet var blueSwitch: UISwitch!
  
  // slideres
  @IBOutlet var redSlider: UISlider!
  @IBOutlet var greenSlider: UISlider!
  @IBOutlet var blueSlider: UISlider!
  
  // label for display state
  @IBOutlet var redLabel: UILabel!
  @IBOutlet var greenLabel: UILabel!
  @IBOutlet var blueLabel: UILabel!
  
  // button
  @IBOutlet var saveButton: UIButton!
  
  // userDefaults
  let userDefaults: UserDefaults = UserDefaults()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    redLabel.adjustsFontSizeToFitWidth = true
    colorView.layer.borderWidth = 5.0
    colorView.layer.cornerRadius = 20
    colorView.layer.borderColor = UIColor.black.cgColor
    
    redLabel.text = String(0)
    greenLabel.text =  String(0)
    blueLabel.text =  String(0)
    
    // store bool data from
    // if data doesn't exist, put false as a default
    redSwitch.setOn(userDefaults.bool(forKey: "redSwitch"), animated: false)
    blueSwitch.setOn(userDefaults.bool(forKey: "blueSwitch"), animated: false)
    greenSwitch.setOn(userDefaults.bool(forKey: "greenSwitch"), animated: false)
    
    // store Color Data from UserDefaults
    // if data doesn't exist, put 0 as a defaults
    redSlider.value = Float(userDefaults.integer(forKey: "redSlider"))
    blueSlider.value = Float(userDefaults.integer(forKey: "blueSlider"))
    greenSlider.value = Float(userDefaults.integer(forKey: "greenSlider"))
    
    updateControls()
    updateColor()
  }
  
  fileprivate func updateColor() {
    var red:CGFloat = 0 // float date type for color
    var green:CGFloat = 0
    var blue:CGFloat = 0
    
    if redSwitch.isOn {
      red = CGFloat(redSlider.value / 255)
    }
    
    if greenSwitch.isOn {
      green =  CGFloat(greenSlider.value / 255)
    }
    
    if blueSwitch.isOn {
      blue =
        CGFloat(blueSlider.value / 255)
    }
    
    let bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    colorView.backgroundColor = bgColor
    
    redLabel.text = String(Int(redSlider.value))
    greenLabel.text = String(Int(greenSlider.value))
    blueLabel.text = String(Int(blueSlider.value))
  }
  
  @IBAction func switchChanged(_ sender: UISwitch) {
    updateControls()
    updateColor()
  }
  
  fileprivate func updateControls() {
    redSlider.isEnabled = redSwitch.isOn
    greenSlider.isEnabled = greenSwitch.isOn
    blueSlider.isEnabled = blueSwitch.isOn
  }
  
  @IBAction func resetButtonTapped(_ sender: Any) {
    redSlider.value = 0
    greenSlider.value = 0
    blueSlider.value = 0
    
    redSwitch.isOn = false
    greenSwitch.isOn = false
    blueSwitch.isOn = false
    
    redLabel.text = String(0)
    greenLabel.text =  String(0)
    blueLabel.text =  String(0)
    
    updateColor()
  }
  
  @IBAction func copyColorCode(_ sender: UIButton) {
    let redValue:String = String(Int(redSlider.value), radix:16)
    let greenValue:String = String(Int(greenSlider.value), radix:16)
    let blueValue:String = String(Int(blueSlider.value), radix:16)
    
    UIPasteboard.general.string = redValue+greenValue+blueValue
  }
  
  @IBAction func sliderChanged(_ sender: UISlider) {
    updateColor()
  }
  
  @IBAction func saveColor(_ sender: UIButton) {
    // save switch as a bool
    userDefaults.set(redSwitch.isOn, forKey: "redSwitch")
    userDefaults.set(blueSwitch.isOn, forKey: "blueSwitch")
    userDefaults.set(greenSwitch.isOn, forKey: "greenSwitch")
    
    // save value as a float value
    userDefaults.set(redSlider.value, forKey: "redSlider")
    userDefaults.set(blueSlider.value, forKey: "blueSlider")
    userDefaults.set(greenSlider.value, forKey: "greenSlider")
    
  }
}

