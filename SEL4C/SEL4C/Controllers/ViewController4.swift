//
//  ViewController4.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit

class ViewController4: UIViewController, UITextFieldDelegate {
    var newEntrepreneur: NewEntrepreneur?
    
    @IBOutlet private weak var generoButton: UIButton!
    @IBOutlet private weak var paisButton: UIButton!
    @IBOutlet private weak var gacademicButton: UIButton!
    @IBOutlet private weak var institucionButton: UIButton!
    @IBOutlet private weak var disciplinaButton: UIButton!
    
    
    @IBOutlet private weak var nombre: UITextField!
    @IBOutlet private weak var apellido: UITextField!
    @IBOutlet private weak var edad: UITextField!
    
    
    @IBOutlet weak var siguienteview: UIButton!
    
    var countryNames: [String] = [] // Array para almacenar los nombres de los países
    
    override func viewDidLoad() {
                super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            
            // Agregar el UITapGestureRecognizer a la vista principal
            self.view.addGestureRecognizer(tapGestureRecognizer)
        if let newEntrepreneur = newEntrepreneur {
            print("Received entrepreneur instance: \(newEntrepreneur)")
        } else {
            print("No entrepreneur instance received.")
        }
                configureButton(button: generoButton, options: ["Masculino", "Femenino","No binario", "Prefiero no decir"])
            
        loadCountryNamesFromCSV()
                
            configureButton(button: gacademicButton, options: ["Pregrado (Licenciatura, Profesional, Universidad, Grado)", "Posgrado (Maestría, Doctorado)", "Educación continua"])
            
                configureButton(button: institucionButton, options: ["UNAM", "ITESM", "IPN", "UDG", "UANL", "BUAP", "UAM", "UAEMEX", "UV", "UMSNH","IBERO","UAEH","UAQ","UGTO","ITAM","UDLAP","UABC","ITESO","UADY","UJAT","UASLP","UPAEP","UP","UDEM","UACJ","UAS","UACH","UPN","COLMEX","UVM"])

                configureButton(button: disciplinaButton, options: ["Ingeniería y Ciencias", "Humanidades y Educación", "Ciencias sociales", "Ciencias de la Salud","Arquitectura, Arte y Diseño", "Negocios"])
                
            nombre.delegate = self
            apellido.delegate = self
            edad.delegate = self
        edad.keyboardType = .numberPad
        
                self.navigationController?.isToolbarHidden = false
        
        
        siguienteview.isEnabled = false
                
                // Agrega controladores de eventos a los campos de texto
                nombre.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
                apellido.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
                edad.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    private func loadCountryNamesFromCSV() {
                if let url = URL(string: "https://gist.githubusercontent.com/brenes/1095110/raw/4422fd7ba3a388f31a9a017757e21e5df23c5916/paises.csv") {
                    do {
                        let csvString = try String(contentsOf: url, encoding: .utf8)
                        
                        // Parsear el CSV para obtener los nombres de los países
                        parseCountryNames(csvString)
                    } catch {
                        print("Error al cargar los nombres de los países: \(error)")
                    }
                }
            }
            
            private func parseCountryNames(_ csvString: String) {
                let lines = csvString.components(separatedBy: "\n")
                    
                    for (index, line) in lines.enumerated() {
                        // Omitir la primera línea (encabezado)
                        if index == 0 {
                            continue
                        }
                        
                        let components = line.components(separatedBy: ",")
                        if components.count >= 3 {
                            var name = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                            // Verificar si el nombre comienza y termina con comillas y eliminarlas
                            if name.hasPrefix("\"") && name.hasSuffix("\"") {
                                name = String(name.dropFirst().dropLast())
                            }
                            countryNames.append(name)
                        }
                    }
                
                // Configurar el botón de países con los nombres obtenidos
                configureButton(button: paisButton, options: countryNames)
            }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == nombre || textField == apellido {
                // Define un conjunto de caracteres válidos (solo letras y espacios)
                let validCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
                // Verifica si cada carácter en la cadena de reemplazo es válido
                for character in string {
                    if !validCharacterSet.contains(character.unicodeScalars.first!) {
                        return false // Carácter no válido, no permitir el cambio
                    }
                }
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
            return true
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterView" {
            if let nextViewController = segue.destination as? ViewController5 {
                if let nombree = nombre.text, let apellidoo = apellido.text, let edadd = Int(edad.text ?? ""),let generoo = generoButton.titleLabel?.text,
                   let paiss = paisButton.titleLabel?.text,
                   let academia = gacademicButton.titleLabel?.text,
                   let escuela = institucionButton.titleLabel?.text,
                   let diciplina = disciplinaButton.titleLabel?.text{
                    newEntrepreneur?.first_name = String(nombree)
                    newEntrepreneur?.last_name = String(apellidoo)
                    newEntrepreneur?.age = Int(edadd)
                    newEntrepreneur?.gender = String(generoo)
                    newEntrepreneur?.country = String(paiss)
                    newEntrepreneur?.institution = String(escuela)
                    newEntrepreneur?.degree = String(academia)
                    newEntrepreneur?.studyField = String(diciplina)
                    nextViewController.newEntrepreneur = newEntrepreneur // Pasa la instancia de NewEntrepreneur a la siguiente vista
                }
            }
        }
    }
    @IBAction func AddData(_ sender: Any) {
        
    }
    
    
    @objc func textFieldDidChange() {
            // Verifica si los campos de texto y los botones contienen datos válidos
            let isNombreValid = !(nombre.text?.isEmpty ?? true)
            let isApellidoValid = !(apellido.text?.isEmpty ?? true)
            let isEdadValid = isValidEdad(edad.text)
            let isGeneroValid = !(generoButton.titleLabel?.text?.isEmpty ?? true)
            let isPaisValid = !(paisButton.titleLabel?.text?.isEmpty ?? true)
            let isGacademicValid = !(gacademicButton.titleLabel?.text?.isEmpty ?? true)
            let isInstitucionValid = !(institucionButton.titleLabel?.text?.isEmpty ?? true)
            let isDisciplinaValid = !(disciplinaButton.titleLabel?.text?.isEmpty ?? true)

            // Habilita el botón si todos los campos son válidos
            siguienteview.isEnabled = isNombreValid && isApellidoValid && isEdadValid &&
                isGeneroValid && isPaisValid && isGacademicValid && isInstitucionValid && isDisciplinaValid
        }

        func isValidEdad(_ edadString: String?) -> Bool {
            if let edadText = edadString, let edad = Int(edadText), (0...80).contains(edad) {
                return true
            }
            return false
        }
    
    
    @objc func handleTap() {
        // Ocultar el teclado
        view.endEditing(true)
    }
    
}
