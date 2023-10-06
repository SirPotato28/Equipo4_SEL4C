//
//  ViewController3.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewController3: UIViewController {
    
    var newEntrepreneur: NewEntrepreneur?
    @IBOutlet weak var PassWord: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newEntrepreneur = newEntrepreneur {
                print("Received entrepreneur instance: \(newEntrepreneur)")
            } else {
                print("No entrepreneur instance received.")
            }
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DataView" {
            if let nextViewController = segue.destination as? ViewController4 {
                if let password = PassWord.text {
                    newEntrepreneur?.password = String(password)
                    nextViewController.newEntrepreneur = newEntrepreneur // Pasa la instancia de NewEntrepreneur a la siguiente vista
                }
            }
        }
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}