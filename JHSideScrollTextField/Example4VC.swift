//
//  Example4VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

class Example4VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var delay1: SideScrollTextField!
    
    @IBOutlet weak var startOut1: SideScrollTextField!
    
    @IBOutlet weak var scrollRight1: SideScrollTextField!
    @IBOutlet weak var scrollRight2: SideScrollTextField!
    @IBOutlet weak var scrollRight3: SideScrollTextField!
    

    ///// programaticScroller /////
    @IBOutlet weak var completelyProgrammaticallyLabel: UILabel! // just the label
    @IBOutlet weak var resetProgrammatic: UIButton! // just the reset button
    
    
    var programaticScroller = SideScrollTextField()
    ///// programaticScroller /////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///// programaticScroller /////
        resetProgramaticAction(self)
        ///// programaticScroller /////
    }
    
    @IBAction func resetProgramaticAction(_ sender: Any) {
        ///// programaticScroller /////
        programaticScroller.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        
        programaticScroller.textField.font = UIFont(name: "Helvetica-Bold", size: 24)
        
        programaticScroller.text = "" //change text like this! NOT with textField.text!
        //programaticScroller.fontSizeAsView = true
        programaticScroller.fontSize = 24
        programaticScroller.maxFontSize = 17
        programaticScroller.maxFontSize = 9
        programaticScroller.scrollLeft = true
        programaticScroller.scrollOnlyWhenTooLong = false
        programaticScroller.scrollRepeat = -1 //contiues repeat
        programaticScroller.scrollTime = 0
        programaticScroller.scrollSpeed = 50 // pixels a second
        programaticScroller.repeatWhenOutOfBounds = true
        programaticScroller.repeatSpacing = 0 // ignored while repeatWhenOutOfBounds=true
        programaticScroller.delayAtStart = 3
        programaticScroller.delayAtEnd = 0
        programaticScroller.startOutOfBounds = false
        
        programaticScroller.layer.borderWidth = 3
        programaticScroller.layer.cornerRadius = 15
        programaticScroller.layer.borderColor = UIColor.green.cgColor
        
        view.addSubview(programaticScroller)
        programaticScroller.placeInCenterOfSuperView()
        programaticScroller.placeOnBottom(of: completelyProgrammaticallyLabel, offset: 5)
        
        programaticScroller.textField.isEnabled = true // default is false and should remain unless you need the user to edit
        programaticScroller.textField.textColor = .red
        programaticScroller.textField.placeholder = "Enter Your Own Message Here"
        programaticScroller.textField.backgroundColor = .white
        programaticScroller.textField.keyboardType = .alphabet
        programaticScroller.textField.autocorrectionType = .no
        programaticScroller.textField.returnKeyType = .done
        programaticScroller.textField.delegate = self
        
        ///// programaticScroller /////
    }
    
    
    @IBAction func startAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "START" {
            delay1.startScroll()
            startOut1.startScroll()
            scrollRight1.startScroll()
            scrollRight2.startScroll()
            scrollRight3.startScroll()
            
            ///// programaticScroller /////
            programaticScroller.startScroll()
            ///// programaticScroller /////
            
            resetProgrammatic.isHidden = true
            
            sender.setTitle("STOP", for: .normal)
        } else {
            delay1.stopScroll()
            startOut1.stopScroll()
            scrollRight1.stopScroll()
            scrollRight2.stopScroll()
            scrollRight3.stopScroll()
            
            ///// programaticScroller /////
            programaticScroller.stopScroll()
            programaticScroller.textField.placeInCenterOfSuperView()
            ///// programaticScroller /////
            
            resetProgrammatic.isHidden = false
            
            sender.setTitle("START", for: .normal)
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // self.endEditing(true)
        programaticScroller.textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        func animateFunc(){
            programaticScroller.placeInCenterOfSuperView()
            
            //refresh constraints
            //self.contextView.layoutSubviews()
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: animateFunc, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        programaticScroller.textField.sizeToFit()
        programaticScroller.textField.placeInCenterOfSuperView()
        programaticScroller.textField.placeInLeftOfSuperView(offset: 5)
        func animateFunc(){
            programaticScroller.placeOnBottom(of: completelyProgrammaticallyLabel, offset: 5)
            //refresh constraints
            //self.contextView.layoutSubviews()
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: animateFunc, completion: nil)
    }
}
