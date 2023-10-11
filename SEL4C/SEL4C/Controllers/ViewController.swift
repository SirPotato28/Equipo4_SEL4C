//
//  ViewController.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var Siguieteview: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        Siguieteview.isEnabled = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            
            // Agregar el UITapGestureRecognizer a la vista principal
            self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap() {
        // Ocultar el teclado
        view.endEditing(true)
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

    @objc func textFieldDidChange(_ textField: UITextField) {
            if let email = emailTextField.text {
                if email.contains("@") {
                    Siguieteview.isEnabled = true // Habilita el botón si el "@" está presente
                } else {
                    Siguieteview.isEnabled = false // Deshabilita el botón si el "@" no está presente
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

