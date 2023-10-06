//
//  ViewControllerMAIN.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit

class ViewControllerMAIN: UIViewController {
    
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        passField.isSecureTextEntry = true
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        if let emailText = emailField.text {
            let email = String(emailText)
            
            let apiCall = APICall()
            async {
                do {
                    if let entrepreneur = try await apiCall.getEntrepreneur(email: email) {
                        print(entrepreneur)
                        let validEmail = entrepreneur.email
                        let validPassword = "123"
                        //jona@tec.mx
                        if emailField.text == validEmail && passField.text == validPassword {
                            // Las credenciales son válidas, realiza la transición al UITabBarController
                            print("Usuario encontrado")
                            if let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "barcontroller") {
                                        // Realizar la navegación al controlador de vista de destino
                                        navigationController?.pushViewController(destinationViewController, animated: true)
                                    }
                        } else {
                            let alertController = UIAlertController(title: "Error", message: "Usuario o contraseña inválido", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            present(alertController, animated: true, completion: nil)
                        }
                    } else {
                        // Manejar el caso en el que no se encontró un usuario con el correo electrónico proporcionado
                        let alertController = UIAlertController(title: "Error", message: "Usuario no encontrado", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        present(alertController, animated: true, completion: nil)
                    }
                    
                } catch {
                    // Maneja el error si ocurre
                    print("Error: \(error)")
                }
            }
        }
    }
}
