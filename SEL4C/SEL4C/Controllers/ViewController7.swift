//
//  ViewController7.swift
//  SEL4C
//
//  Created by Josue on 28/08/23.
//

import UIKit
import SwiftUI

class ViewController7: UIViewController {

    @IBOutlet weak var inicial: UIButton!
    @IBOutlet weak var act1: UIButton!
    @IBOutlet weak var act2: UIButton!
    @IBOutlet weak var act3: UIButton!
    @IBOutlet weak var act4: UIButton!
    @IBOutlet weak var act5: UIButton!
    @IBOutlet weak var cierre: UIButton!
    
    
    var botonPresionado = false
    var botonPresionado2 = false
    var botonPresionado3 = false
    var botonPresionado4 = false
    var botonPresionado5 = false
    var botonPresionado6 = false
    var botonPresionado7 = false

    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Configurar la apariencia inicial de los botones
            setupButtons()
            
        }
        
        func setupButtons() {
            // Deshabilitar todos los botones excepto el inicial
            /*
            act1.isEnabled = false
            act2.isEnabled = false
            act3.isEnabled = false
            act4.isEnabled = false
            act5.isEnabled = false
            cierre.isEnabled = false
            */
            if botonPresionado {
                
                act1.isEnabled = true
                print("Act1")
            } else {
                act1.isEnabled = false
            }
            if botonPresionado2 {
                
                act2.isEnabled = true
                print("Act2")
            } else {
                act2.isEnabled = false
            }
            if botonPresionado3 {
                
                act3.isEnabled = true
                print("Act3")
            } else {
                act3.isEnabled = false
            }
            if botonPresionado4 {
                
                act4.isEnabled = true
                print("Act4")
            } else {
                act4.isEnabled = false
            }
            if botonPresionado5 {
                
                act5.isEnabled = true
                print("Act5")
            } else {
                act5.isEnabled = false
            }
            if botonPresionado6 {
                
                cierre.isEnabled = true
                print("Act6")
            } else {
                cierre.isEnabled = false
            }
            
            inicial.backgroundColor = UIColor(red: 0.6, green: 0.4, blue: 1.0, alpha: 0.4)
            act1.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            act2.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            act3.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            act4.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            act5.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            cierre.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.45)
            
        }
        
        
    @IBAction func botonPresionado(_ sender: Any) {
        botonPresionado = true
        setupButtons()
    }
    
    @IBAction func botonPresionado2(_ sender: Any) {
        botonPresionado2 = true
        setupButtons()
    }
    
    @IBAction func botonPresionado3(_ sender: Any) {
        botonPresionado3 = true
        setupButtons()
    }
    
    @IBAction func botonPresionado4(_ sender: Any) {
        botonPresionado4 = true
        setupButtons()
    }
    
    @IBAction func botonPresionado5(_ sender: Any) {
        botonPresionado5 = true
        setupButtons()
    }
    
    @IBAction func botonPresionado6(_ sender: Any) {
        botonPresionado6 = true
        setupButtons()
    }
    
    
    
    
}

