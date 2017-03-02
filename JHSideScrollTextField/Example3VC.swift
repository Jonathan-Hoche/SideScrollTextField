//
//  Example3VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

class Example3VC: UIViewController {
    
    @IBOutlet weak var repeatDefault: SideScrollTextField!

    @IBOutlet weak var repeat0: SideScrollTextField!
    
    
    @IBOutlet weak var repeat1: SideScrollTextField!
    
    @IBOutlet weak var repeat5: SideScrollTextField!
    
    @IBOutlet weak var scrollTime1: SideScrollTextField!
    @IBOutlet weak var scrollTime2: SideScrollTextField!
    
    @IBOutlet weak var scrollSpeed1: SideScrollTextField!
    @IBOutlet weak var scrollSpeed2: SideScrollTextField!
    @IBOutlet weak var scrollSpeed3: SideScrollTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "START" {
            repeatDefault.startScroll()
            repeat0.startScroll()
            repeat1.startScroll()
            repeat5.startScroll()
            scrollTime1.startScroll()
            scrollTime2.startScroll()
            scrollSpeed1.startScroll()
            scrollSpeed2.startScroll()
            scrollSpeed3.startScroll()
            
            sender.setTitle("STOP", for: .normal)
        } else {
            repeatDefault.stopScroll()
            repeat0.stopScroll()
            repeat1.stopScroll()
            repeat5.stopScroll()
            scrollTime1.stopScroll()
            scrollTime2.stopScroll()
            scrollSpeed1.stopScroll()
            scrollSpeed2.stopScroll()
            scrollSpeed3.stopScroll()
          
            
            sender.setTitle("START", for: .normal)
        }
        
    }

}
