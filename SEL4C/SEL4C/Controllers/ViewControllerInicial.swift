//
//  ViewControllerInicial.swift
//  SEL4C
//
//  Created by Josue on 29/09/23.
//

import UIKit

class ViewControllerInicial: UIViewController {

    
    @IBOutlet weak var estatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        estatus.text = "No entregado"
    }
    
    func usuarioTerminoDeContestarPreguntas() {
            // Cambia el texto del UILabel a "Entregado"
            estatus.text = "Entregado"
        }
    
}
