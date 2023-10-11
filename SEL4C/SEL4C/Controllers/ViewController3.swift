//
//  ViewController3.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var Siguieteview: UIButton!
    var newEntrepreneur: NewEntrepreneur?
    
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            
            // Agregar el UITapGestureRecognizer a la vista principal
            self.view.addGestureRecognizer(tapGestureRecognizer)
        
        password1.isSecureTextEntry = true
        password2.isSecureTextEntry = true
        Siguieteview.isEnabled = false // Deshabilitar el botón al inicio
        checkPasswordsMatch()
        
        
        if let newEntrepreneur = newEntrepreneur {
                print("Received entrepreneur instance: \(newEntrepreneur)")
            } else {
                print("No entrepreneur instance received.")
            }
        // Do any additional setup after loading the view.
        
        password1.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        password2.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }
    
    @objc func handleTap() {
        // Ocultar el teclado
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DataView" {
                if let nextViewController = segue.destination as? ViewController4 {
                    if let password = password1.text {
                        newEntrepreneur?.password = String(password)
                        nextViewController.newEntrepreneur = newEntrepreneur // Pasa la instancia de NewEntrepreneur a la siguiente vista
                    }
                }
            }
        }

        @objc func passwordChanged() {
            checkPasswordsMatch() // Comprobar las contraseñas cuando cambien
        }

        // Función para verificar si las contraseñas son iguales
        func checkPasswordsMatch() {
            if password2.text == password1.text {
                Siguieteview.isEnabled = true // Habilitar el botón si las contraseñas coinciden
            } else {
                Siguieteview.isEnabled = false // Deshabilitar el botón si las contraseñas no coinciden
            }
        }
    
    
    
    
}
