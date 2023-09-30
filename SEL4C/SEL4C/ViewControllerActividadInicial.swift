//
//  ViewControllerActividadInicial.swift
//  SEL4C
//
//  Created by Josue on 26/09/23.
//

import UIKit



class ViewControllerActividadInicial: UIViewController {

    @IBOutlet weak var textQuestion: UILabel!
    @IBOutlet weak var progressLine: UIProgressView!
    
    @IBOutlet weak var bNadaDeAcuerdo: UIButton!
    @IBOutlet weak var bPocoDeAcuerdo: UIButton!
    @IBOutlet weak var bNiDeAcuerdo: UIButton!
    @IBOutlet weak var BDeAcuerdo: UIButton!
    @IBOutlet weak var bMuyDeAcuerdo: UIButton!
    
    var engine = EcomplexityEngine()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressLine.progress = engine.getProgress()
        textQuestion.text = engine.getTextQuestion()
    }
    

    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            print("Nada de acuerdo")
        case let str where str.contains("Poco de acuerdo"):
            print("Poco de acuerdo")
        case let str where str.contains("Ni de acuerdo ni desacuerdo"):
            print("Ni de acuerdo ni desacuerdo")
        case let str where str.contains("De acuerdo"):
            print("De acuerdo")
        default:
            print("Muy de acuerdo")
        }
        sender.backgroundColor = UIColor.green
        bNadaDeAcuerdo .isEnabled = false
        bNiDeAcuerdo.isEnabled = false
        bMuyDeAcuerdo.isEnabled = false
        bPocoDeAcuerdo.isEnabled = false
        BDeAcuerdo.isEnabled = false
        
        if engine.nextQuestion(){
            let alert = UIAlertController(title: "Fin del cuestionario", message: "Vamos a pasar a la siguiente etapa", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default){ (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(continueAction)
            present(alert,animated: true)
        }else{
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
        }
    }
    

    @objc func nextQuestion(){
        textQuestion.text = engine.getTextQuestion()
        progressLine.progress = engine.getProgress()
        bNadaDeAcuerdo.backgroundColor = UIColor.white
        bNiDeAcuerdo.backgroundColor = UIColor.white
        bMuyDeAcuerdo.backgroundColor = UIColor.white
        bPocoDeAcuerdo.backgroundColor = UIColor.white
        BDeAcuerdo.backgroundColor = UIColor.white
        
        bNadaDeAcuerdo .isEnabled = true
        bNiDeAcuerdo.isEnabled = true
        bMuyDeAcuerdo.isEnabled = true
        bPocoDeAcuerdo.isEnabled = true
        BDeAcuerdo.isEnabled = true
    
    }
}
