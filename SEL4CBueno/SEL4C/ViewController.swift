//
//  ViewController.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func backB1(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    

    
    @IBAction func Check(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected=false
        } else{
            sender.isSelected=true
        }
    }
    
}

