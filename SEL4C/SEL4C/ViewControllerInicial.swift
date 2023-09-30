//
//  ViewControllerInicial.swift
//  SEL4C
//
//  Created by Josue on 29/09/23.
//

import UIKit

class ViewControllerInicial: UIViewController {

    
    @IBOutlet weak var estatus: UIButton!
    
    var botonPresionado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actualizarTextoDelBoton()
    }
    
    func actualizarTextoDelBoton() {
            if botonPresionado {
                estatus.setTitle("Entregado", for: .normal)
                estatus.isEnabled = true
                print("Actividad 1 Entregada")
            } else {
                estatus.setTitle("No entregado", for: .normal)
            }
        }
    
    @IBAction func botonPresionado(_ sender: Any) {
        botonPresionado = true
        actualizarTextoDelBoton()
    }
    
}
