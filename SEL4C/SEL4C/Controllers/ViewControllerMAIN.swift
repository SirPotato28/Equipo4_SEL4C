//
//  ViewControllerMAIN.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit
import CommonCrypto

extension Data {
    func pbkdf2SHA256(password: String, salt: Data, iterations: Int, keyLength: Int) -> Data? {
        var derivedKey = [UInt8](repeating: 0, count: keyLength)
        let passwordData = password.data(using: .utf8)!
        
        let result = passwordData.withUnsafeBytes { passwordPtr in
            salt.withUnsafeBytes { saltPtr in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    passwordPtr.baseAddress?.assumingMemoryBound(to: Int8.self),
                    passwordData.count,
                    saltPtr.baseAddress?.assumingMemoryBound(to: UInt8.self),
                    salt.count,
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                    UInt32(iterations),
                    &derivedKey,
                    keyLength
                )
            }
        }
        
        if result == kCCSuccess {
            return Data(derivedKey)
        } else {
            return nil
        }
    }
}
class ViewControllerMAIN: UIViewController {
    
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        passField.isSecureTextEntry = true
    }
    
    func hashPassword(password: String, salt: String, iterations: Int) -> String? {
        // Convierte la contraseña y la sal en datos binarios
        guard let passwordData = password.data(using: .utf8), let saltData = salt.data(using: .utf8) else {
            return nil
        }
        
        // Define los parámetros para PBKDF2-SHA256
        let keyLength = kCCKeySizeAES256
        
        var derivedKey = Data(repeating: 0, count: keyLength)
        
        let result = derivedKey.withUnsafeMutableBytes { derivedKeyBytes in
            saltData.withUnsafeBytes { saltBytes in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password,
                    passwordData.count,
                    saltBytes.bindMemory(to: UInt8.self).baseAddress,
                    saltData.count,
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                    UInt32(iterations),
                    derivedKeyBytes.bindMemory(to: UInt8.self).baseAddress,
                    keyLength
                )
            }
        }
        
        if result == kCCSuccess {
            // Convierte el hash derivado en una cadena hexadecimal
            let hashHex = derivedKey.map { String(format: "%02hhx", $0) }.joined()
            return hashHex
        } else {
            return nil
        }
    }
    
    

    
    
    @IBAction func login(_ sender: UIButton) {
        if let emailText = emailField.text, let enteredPassword = passField.text {
            let email = String(emailText)
            
            let apiCall = APICall()
            async {
                do {
                    if let entrepreneur = try await apiCall.getEntrepreneur(email: email) {
                        print(entrepreneur)
                        let validHashedPassword = entrepreneur.password
                        
                        // Separar el hash almacenado en sus componentes
                        let components = validHashedPassword.components(separatedBy: "$")
                        if components.count == 4 {
                            let algorithm = components[0]
                            let iterations = Int(components[1]) ?? 0
                            let salt = components[2]
                            let storedHash = components[3]
                            
                            // Verificar la contraseña ingresada
                            if algorithm == "pbkdf2_sha256", iterations > 0 {
                                if let hashedEnteredPasswordData = Data().pbkdf2SHA256(password: enteredPassword, salt: Data(salt.utf8), iterations: iterations, keyLength: 32) {
                                    let hashedEnteredPassword = hashedEnteredPasswordData.base64EncodedString()
                                    // Luego puedes comparar hashedEnteredPassword con storedHash
                                    if hashedEnteredPassword == storedHash {
                                        print("Usuario encontrado")
                                        SessionManager.shared.setCurrentUser(entrepreneur)
                                        print(algorithm)
                                        print(iterations)
                                        print(salt)
                                        print(storedHash)
                                        print(hashedEnteredPassword)
                                        if hashedEnteredPassword == storedHash {
                                            // Las credenciales son válidas
                                            print("Usuario encontrado")
                                            DispatchQueue.main.async {
                                                // Realiza la transición al UITabBarController
                                                if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") {
                                                    let navigationController = UINavigationController(rootViewController: homeVC)
                                                    UIApplication.shared.windows.first?.rootViewController = navigationController
                                                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                                                }
                                            }
                                            return
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Contraseña incorrecta o hash inválido
                        let alertController = UIAlertController(title: "Error", message: "Contraseña incorrecta", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        // Manejar el caso en el que no se encontró un usuario con el correo electrónico proporcionado
                        let alertController = UIAlertController(title: "Error", message: "Usuario no encontrado", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                } catch {
                    // Maneja el error si ocurre
                    print("Error: \(error)")
                }
            }
        }
    }
}
