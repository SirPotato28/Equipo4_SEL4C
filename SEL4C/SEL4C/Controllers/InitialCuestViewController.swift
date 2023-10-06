//
//  InitialCuestViewController.swift
//  SEL4C
//
//  Created by Usuario on 03/10/23.
//

import UIKit

class InitialCuestViewController: UIViewController {
    let slider = UISlider()
    
    private let CuadroPregunta: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(CuadroPregunta)
        // Do any additional setup after loading the view.
        NSLayoutConstraint.activate([
            CuadroPregunta.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            CuadroPregunta.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            CuadroPregunta.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
        ])
        ["pregunta 1","pregunta2","pregunta3", "pregunta4","aaa"].forEach { pregunta in
            let label = UILabel()
            label.text = pregunta
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 32)
            
            let slider = UISlider()
            slider.minimumValue = 0.0
            slider.maximumValue = 4.0
            slider.value = 0.0
            slider.isContinuous = true
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            
            let valueLabel = UILabel()
                        valueLabel.text = "\(Int(slider.value))" // Inicialmente muestra el valor del slider
                        valueLabel.textAlignment = .center
            
           
            
            
            CuadroPregunta.addArrangedSubview(label)
            
            CuadroPregunta.addArrangedSubview(slider)
            CuadroPregunta.addArrangedSubview(valueLabel)
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        sender.value = roundf(sender.value) // Redondea el valor a un número entero
        
        // Encuentra la posición de la etiqueta del valor en el stack view
        if let sliderIndex = CuadroPregunta.arrangedSubviews.firstIndex(of: sender) {
            // Encuentra la etiqueta del valor correspondiente
            let valueLabelIndex = sliderIndex + 1
            if let valueLabel = CuadroPregunta.arrangedSubviews[valueLabelIndex] as? UILabel {
                valueLabel.text = "\(Int(sender.value))" // Actualiza el valor de la etiqueta
            }
        }
    }

}
