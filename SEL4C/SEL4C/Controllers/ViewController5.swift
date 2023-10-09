//
//  ViewController5.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit

class ViewController5: UIViewController {

    var newEntrepreneur: NewEntrepreneur?
    @IBOutlet weak var link: UILabel!
    
    @IBOutlet weak var accept: UIButton!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        accept.isEnabled = false
        if let newEntrepreneur = newEntrepreneur {
            print("Received entrepreneur instance: \(newEntrepreneur)")
        } else {
            print("No entrepreneur instance received.")
        }

            // Agrega un gesto de toque al UILabel
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            link.isUserInteractionEnabled = true
            link.addGestureRecognizer(tapGesture)
        }
    

    @objc func labelTapped() {
            // URL que deseas abrir en el navegador
            if let url = URL(string: "https://tec.mx/es/aviso-de-privacidad-sel4c") {
                // Abre la URL en el navegador
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    
    
    @IBAction func check(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        accept.isEnabled = sender.isSelected
    }
    
    
    @IBAction func acceptAction(_ sender: Any) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let networkService = APICall()
        //activityIndicator.isHidden = false
        //activityIndicator.startAnimating()
        
        Task {
            do {
                let encodeNewEntrepreneur = try jsonEncoder.encode(newEntrepreneur)
                if let jsonString = String(data: encodeNewEntrepreneur, encoding: .utf8) {
                    print("JSON a enviar: \(jsonString)")
                }
                if let newUser = try await networkService.addEntrepreneur(newEntrepreneur: encodeNewEntrepreneur) {
                    // Maneja newUser en caso de éxito
                    // updateUI(with: newUser)
                } else {
                    // Maneja el caso en que newUser sea nulo (error)
                }
            } catch {
                // Maneja el error aquí
            }
        }
    }
}
