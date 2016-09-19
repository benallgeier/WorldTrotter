//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Benjamin Allgeier on 9/13/16.
//  Copyright © 2016 ballgeier. All rights reserved.
//

//import Foundation
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {                          // property observer
            updateCelsiusLabel()
            print("fahrenheitValue is \(fahrenheitValue)")
        }
    } // end fahrenheitValue
    var celsiusValue: Double? {           // computed property
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
//        celsiusLabel.text = textField.text
        
//        if let text = textField.text where !text.isEmpty {
//            celsiusLabel.text = text
//        }
//        else {
//            celsiusLabel.text = "???"
//        }
        
        // not sure why if let for textField.text because 
        // I don't think it can ever be nil
        // but it is an optional value: String?
//        if let text = textField.text, value = Double(text) {
//            fahrenheitValue = value
//        }
//        else {
//            fahrenheitValue = nil
//        }
        
        if let text = textField.text { // numberFormatter.number(from: ".") must return nil
            // so broke that part off of the if let
            //print("text is \(text)")
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator
            if text == decimalSeparator {
                fahrenheitValue = Double(0) // celsius value should be -17.8
            }
            else { // text is not simply "."
                // this approach allows text such as "2,72" in spanish to 
                // understood as representing the number 2.72 
                // numberFormatter takes into consideration locale
                let number = numberFormater.number(from: text) // returns NSNumber
                fahrenheitValue = number?.doubleValue // converts NSNumber into a double
            }
        }
        else {
            fahrenheitValue = nil
        }
        
       // if let text = textField.text, let number = numberFormater.number(from: text) {
         //   fahrenheitValue = number.doubleValue
        //}
        //else {
         //   fahrenheitValue = nil
        //}
        
        // check to see if textField.text is "." -- consider short for 0.0
        //if let text = textField.text , text == "." {
          //  fahrenheitValue = 0  // celsius value should be -17.8
        //}
        // is it okay to not have an else condition here?
        // below I had to add else because variable outside of if let 
        // needed to be guaranteed to be initialized apparently
        // didn't want to mess with way book presented above
        // but could try to nest an if statement after if let 
        // text = textField.text and test = "." and then Double(text)
        
    } // end fahrenheitFieldEditingChanged
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        textField.resignFirstResponder()
    } // end dismissKeyboard
    
    // study closures later and how is numberFormatter working
    let numberFormater: NumberFormatter = {         // using a closure
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
//            celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormater.string(from: NSNumber(value: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    } // end updateCelsiusLabel

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // one bug noticed: In spanish mode, can put in mulitple periods
        // with keyboard. When one is entered, celsius label turns in ???
        // probably commas do same thing in english setting
        // we only filtered for CharacterSet.letters,,
        
//        print("Current text: \(textField.text)")
//        print("Replacement text: \(string)")
//        
//        return true
        
//        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
//        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        let currentLocale = Locale.current
        //let decimalSeparator = (currentLocale as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as! String
        
        let decimalSeparator = currentLocale.decimalSeparator
        
        let existingTextHasDecimalSeparator : Range<String.Index>?
        let replacementTextHasDecimalSeparator : Range<String.Index>?
        
        if let separator = decimalSeparator {
            existingTextHasDecimalSeparator = textField.text?.range(of: separator)
            replacementTextHasDecimalSeparator = string.range(of: separator)
        }
        else {
            existingTextHasDecimalSeparator = nil
            replacementTextHasDecimalSeparator = nil
        }
        
        // before trying the if let way above, tried method below
        // decimalSeparator is String?
        // however xcode gave error if I used ?
        // So can we not unwrap with ? -- I thought that was the more graceful way
        // same thing below
        
        //let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator!)
        
        //let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator!)
        
        let alphaCharacters = CharacterSet.letters
        let replacementTextHasLetter = string.rangeOfCharacter(from: alphaCharacters)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } // end if
        else if replacementTextHasLetter != nil {
            return false
        } // end else if
        else { // no letters and at most one decimalSeparator
            return true
        } // end if
    } // end textField(_, _, _)     // figure out function syntax --
    // see WorldTrotterOld
    
    override func viewDidLoad() {
        // Always call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // I suppose you should call the super
        super.viewWillAppear(animated)
        
        // get the hour and minutes of the current time
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.hour, .minute], from: date)
        let hour = components.hour
        let minute = components.minute
        print("hour is \(hour) and minutes is \(minute)")
        if (hour! >= 6 && hour! <= 17) {
            view!.backgroundColor = UIColor.yellow
        } // end if
        else {
            view!.backgroundColor = UIColor.gray
        } // end else
        
        print("ConversionViewController will appear")
    } // end viewWillAppear
    
} // end ConversionViewController
