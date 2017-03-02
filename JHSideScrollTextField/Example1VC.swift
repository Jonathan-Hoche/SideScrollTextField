//
//  Example1VC.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 28/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

class Example1VC: UIViewController {

    @IBOutlet weak var def1: SideScrollTextField!
    @IBOutlet weak var def2: SideScrollTextField!
    @IBOutlet weak var def3: SideScrollTextField!
    
    @IBOutlet weak var fsav1: SideScrollTextField!
    @IBOutlet weak var fsav2: SideScrollTextField!
    @IBOutlet weak var fsav3: SideScrollTextField!
    @IBOutlet weak var fsav4: SideScrollTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "START" {
            def1.startScroll()
            def2.startScroll()
            def3.startScroll()
            fsav1.startScroll()
            fsav2.startScroll()
            fsav3.startScroll()
            fsav4.startScroll()
            sender.setTitle("STOP", for: .normal)
        } else {
            def1.stopScroll()
            def2.stopScroll()
            def3.stopScroll()
            fsav1.stopScroll()
            fsav2.stopScroll()
            fsav3.stopScroll()
            fsav4.stopScroll()
            sender.setTitle("START", for: .normal)
        }

    }
}
