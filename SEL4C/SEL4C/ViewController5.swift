//
//  ViewController5.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit

class ViewController5: UIViewController {

    
    @IBOutlet weak var link: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()

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
    

}
