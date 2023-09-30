//
//  ViewController4.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit

class ViewController4: UIViewController, UITextFieldDelegate {

    
    @IBOutlet private weak var generoButton: UIButton!
    @IBOutlet private weak var paisButton: UIButton!
    @IBOutlet private weak var gacademicButton: UIButton!
    @IBOutlet private weak var institucionButton: UIButton!
    @IBOutlet private weak var disciplinaButton: UIButton!
    
    
    @IBOutlet private weak var nombre: UITextField!
    @IBOutlet private weak var apellido: UITextField!
    @IBOutlet private weak var edad: UITextField!
    
    override func viewDidLoad() {
                super.viewDidLoad()
                configureButton(button: generoButton, options: ["Masculino", "Femenino"])
            
                configureButton(button: paisButton, options: ["México", "EEUU", "Canadá"])
                
            configureButton(button: gacademicButton, options: ["Secundaria", "Preparatoria", "Universidad"])
            
                configureButton(button: institucionButton, options: ["Tecnológico de Monterrey", "La Salle", "Universidad Marista", "UNAM", "UAM", "IPN"])

                configureButton(button: disciplinaButton, options: ["Negocios", "Humanidades", "Ciencias naturales y aplicadas", "Ciencias sociales"])
                
            nombre.delegate = self
            apellido.delegate = self
            edad.delegate = self
        edad.keyboardType = .numberPad
        
                self.navigationController?.isToolbarHidden = false
            }
            
            private func configureButton(button: UIButton, options: [String]) {
                let menu = UIMenu(title: "", children: options.map { option in
                    return UIAction(title: option, handler: { (_) in
                        button.setTitle(option, for: .normal)
                        self.printSelectedOption(option)
                    })
                })
                
                button.menu = menu
                button.showsMenuAsPrimaryAction = true
            }
            
            private func printSelectedOption(_ option: String) {
                print("Opción seleccionada: \(option)")
            }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                // Verifica si el text field es el de nombre o apellido
                if textField == nombre {
                    // Concatena el nuevo texto con el texto actual
                    let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
                    print("Nombre: \(newText)")
                } else if textField == apellido {
                    let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
                    print("Apellido: \(newText)")
                } else if textField == edad {
                    if let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string),
                                   let edadInt = Int(newText),
                                   (0...80).contains(edadInt) {
                                    print("Edad: \(edadInt)")
                                    return true
                                } else {
                                    print("Edad inválida")
                                    return false
                                }
                }
                
                // Permite el cambio en el text field
                return true
            }


}
