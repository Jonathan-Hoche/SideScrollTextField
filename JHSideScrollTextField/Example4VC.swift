//
//  Example4VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit
                           ///// UITextFieldDelegate HERE FOR programaticScroller /////
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
        
        // !!! @IBInspectable properties
        programaticScroller.text = "" //change the text like this! (NOT with programaticScroller.textField.text)
        programaticScroller.fontSizeAsView = false //if true will override fontSize, maxFontSize and minFontSize
        programaticScroller.fontSize = 17
        programaticScroller.maxFontSize = 17 // if maxFontSize > minFontSize (and both are bigger than 0) they will try to...
        programaticScroller.minFontSize = 9 //  resize (shrink) to fit the view as much as possible within these boundaries
        programaticScroller.scrollLeft = true
        programaticScroller.scrollOnlyWhenTooLong = false
        programaticScroller.scrollRepeat = -1 //contiues repeat
        programaticScroller.scrollTime = 0 // if bigger than 0 will override scrollSpeed
        programaticScroller.scrollSpeed = 50 // pixels a second
        programaticScroller.repeatWhenOutOfBounds = true
        programaticScroller.repeatSpacing = 0 // ignored while repeatWhenOutOfBounds=true
        programaticScroller.delayAtStart = 3
        programaticScroller.delayAtEnd = 0
        programaticScroller.startOutOfBounds = false
        // !!!
        
        //other properties
        programaticScroller.layer.borderWidth = 3
        programaticScroller.layer.cornerRadius = 15
        programaticScroller.layer.borderColor = UIColor.green.cgColor
        
        view.addSubview(programaticScroller)
        programaticScroller.placeInCenterOfSuperView()
        programaticScroller.placeOnBottom(of: completelyProgrammaticallyLabel, offset: 5)
        
        programaticScroller.textField.isEnabled = true // default is false and should remain unless you need the user to edit
        programaticScroller.textField.textColor = .red
        programaticScroller.textField.placeholder = "Enter Message..." //CAREFUL: startScroll() wil size to fit to the placeholder text if it is longer than the text... set it back to "" before startScroll()
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
            programaticScroller.textField.placeholder = "" //otherwise it will sizeToFit to the length of the placeholder
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

    ///// HERE FOR programaticScroller /////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        programaticScroller.textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        func animateFunc(){
            programaticScroller.placeInCenterOfSuperView()
            //refresh constraints
            //programaticScroller.layoutSubviews()
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: animateFunc, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        func animateFunc(){
            programaticScroller.placeOnBottom(of: completelyProgrammaticallyLabel, offset: 5)
            //refresh constraints
            //programaticScroller.layoutSubviews()
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: animateFunc, completion: nil)
    }
    ///// HERE FOR programaticScroller /////
}
