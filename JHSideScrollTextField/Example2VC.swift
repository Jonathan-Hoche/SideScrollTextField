//
//  Example2VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

class Example2VC: UIViewController {
    
    @IBOutlet weak var max1: SideScrollTextField!
    @IBOutlet weak var max2: SideScrollTextField!
    @IBOutlet weak var max3: SideScrollTextField!
    
    @IBOutlet weak var whenLong1: SideScrollTextField!
    @IBOutlet weak var whenLong2: SideScrollTextField!
    @IBOutlet weak var whenLong3: SideScrollTextField!
    @IBOutlet weak var whenLong4: SideScrollTextField!
    @IBOutlet weak var whenLong5: SideScrollTextField!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "START" {
            max1.startScroll()
            max2.startScroll()
            max3.startScroll()
            
            whenLong1.startScroll()
            whenLong2.startScroll()
            whenLong3.startScroll()
            whenLong4.startScroll()
            whenLong5.startScroll()
          
            sender.setTitle("STOP", for: .normal)
        } else {
            max1.stopScroll()
            max2.stopScroll()
            max3.stopScroll()
            
            whenLong1.stopScroll()
            whenLong2.stopScroll()
            whenLong3.stopScroll()
            whenLong4.stopScroll()
            whenLong5.stopScroll()
            
            sender.setTitle("START", for: .normal)
        }
        
    }
}

