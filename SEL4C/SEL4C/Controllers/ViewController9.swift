//
//  ViewController9.swift
//  SEL4C
//
//  Created by Usuario on 05/09/23.
//

import UIKit

class ViewController9: UIViewController {
    
    var CurrentEntrepreneur: Entrepreneur?
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var birthdateField: UITextField!
    
    @IBOutlet weak var degreeField: UITextField!
    
    @IBOutlet weak var institutionField: UITextField!
    
    @IBOutlet weak var disciplineField: UITextField!
    var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(SessionManager.shared.currentUser!)
        CurrentEntrepreneur = SessionManager.shared.currentUser!
        
        nameField.text = SessionManager.shared.currentUser!.first_name
        lastNameField.text = SessionManager.shared.currentUser!.last_name
        countryField.text = SessionManager.shared.currentUser!.country
        genderField.text = SessionManager.shared.currentUser!.gender
        birthdateField.text = String(SessionManager.shared.currentUser!.age)
        degreeField.text = SessionManager.shared.currentUser!.degree
        institutionField.text = SessionManager.shared.currentUser!.institution
        disciplineField.text = SessionManager.shared.currentUser!.studyField
        textFields.append(nameField)
        textFields.append(lastNameField)
        textFields.append(countryField)
        textFields.append(genderField)
        textFields.append(birthdateField)
        textFields.append(degreeField)
        textFields.append(institutionField)
        textFields.append(disciplineField)
       
        
    }
    

    @IBAction func allowFields(_ sender: UIButton) {
        
        nameField.isEnabled = true
        lastNameField.isEnabled = true
        countryField.isEnabled = true
        countryField.isEnabled = true
        genderField.isEnabled = true
        birthdateField.isEnabled = true
        degreeField.isEnabled = true
        institutionField.isEnabled = true
        disciplineField.isEnabled = true
        for textField in textFields {
            textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    @IBAction func saveEntrepreneurData(_ sender: UIButton) {
        CurrentEntrepreneur?.first_name = nameField.text ?? ""
        CurrentEntrepreneur?.last_name = lastNameField.text ?? ""
        CurrentEntrepreneur?.country = countryField.text ?? ""
        CurrentEntrepreneur?.gender = genderField.text ?? ""
        CurrentEntrepreneur?.age = Int(birthdateField.text ?? "0") ?? 0
        CurrentEntrepreneur?.degree = degreeField.text ?? ""
        CurrentEntrepreneur?.institution = institutionField.text ?? ""
        CurrentEntrepreneur?.studyField = disciplineField.text ?? ""
        Task{
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            do{
                let encodeEntrepreneur = try jsonEncoder.encode(CurrentEntrepreneur)
                if let jsonString = String(data: encodeEntrepreneur, encoding: .utf8) {
                    print("JSON a enviar: \(jsonString)")
                }else{
                 
                }
                
                if let response = try? await APICall().updateEntrepreneur(entrepreneur: encodeEntrepreneur, entrepreneur_id: SessionManager.shared.currentUser!.id) {
                    let confirmationAlert = UIAlertController(title: "Success", message: "Se han actualizado sus datos correctamente", preferredStyle: .alert)
                        confirmationAlert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                            DispatchQueue.main.async {
                                // Realiza la transición al UITabBarController
                                if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") {
                                    UIView.transition(with: UIApplication.shared.windows.first!,
                                                      duration: 0.5,
                                                      options: .transitionFlipFromRight,
                                                      animations: {
                                                          UIApplication.shared.windows.first?.rootViewController = homeVC
                                                      },
                                                      completion: nil)
                                }
                            }
                        })

                        present(confirmationAlert, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "No se pudieron actualizar los datos", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }

              
            }catch{
                
            }
        }
        
    }
}
