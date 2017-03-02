//
//  Example5VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

class Example5VC: UIViewController {
    
    @IBOutlet weak var repeatSpacing1: SideScrollTextField!
    @IBOutlet weak var repeatSpacing2: SideScrollTextField!
    @IBOutlet weak var repeatSpacing3: SideScrollTextField!
    @IBOutlet weak var repeatSpacing4: SideScrollTextField!
    
    @IBOutlet weak var repeatSpacing5: SideScrollTextField!
    
    @IBOutlet weak var repeatSpacing6: SideScrollTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "START" {
            repeatSpacing1.startScroll()
            repeatSpacing2.startScroll()
            repeatSpacing3.startScroll()
            repeatSpacing4.startScroll()
            repeatSpacing5.startScroll()
            repeatSpacing6.startScroll()
            
            sender.setTitle("STOP", for: .normal)
        } else {
            
            repeatSpacing1.stopScroll()
            repeatSpacing2.stopScroll()
            repeatSpacing3.stopScroll()
            repeatSpacing4.stopScroll()
            repeatSpacing5.stopScroll()
            repeatSpacing6.stopScroll()
            
            sender.setTitle("START", for: .normal)
        }
        
    }


}
