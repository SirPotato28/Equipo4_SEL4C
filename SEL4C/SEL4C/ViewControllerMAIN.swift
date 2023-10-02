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
        let validEmail = "hola"
        let validPassword = "hola"
                
        if emailField.text == validEmail && passField.text == validPassword {
                    // Las credenciales son válidas, realiza la transición al UITabBarController
                    if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "barcontroller") as? UITabBarController {
                        // Cambia "YourTabBarControllerIdentifier" al identificador de tu UITabBarController en el storyboard
                        
                        // Selecciona la pestaña correspondiente (ViewController7)
                        tabBarController.selectedIndex = 2 // Cambia el índice según tu estructura de pestañas
                        navigationController?.pushViewController(tabBarController, animated: true)
                    }
                }  else {
                    let alertController = UIAlertController(title: "Error", message: "Usuario o contraseña inválido", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                }
    }
    
}
