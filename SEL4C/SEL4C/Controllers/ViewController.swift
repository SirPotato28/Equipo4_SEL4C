//
//  ViewController.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassView" {
            if let nextViewController = segue.destination as? ViewController3 {
                if let email = emailTextField.text {
                    let newEntrepreneur = NewEntrepreneur(email: email, password: "", first_name: "", last_name: "", degree: "", institution: "", gender: "", age: 0, country: "", studyField: "")
                    nextViewController.newEntrepreneur = newEntrepreneur // Pasa la instancia de NewEntrepreneur a la siguiente vista
                }
            }
        }
    }

    @IBAction func AddEmail(_ sender: Any) {
        if let email = emailTextField.text {

        } else {
    
        }
    }
    
    @IBAction func backB1(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
}

