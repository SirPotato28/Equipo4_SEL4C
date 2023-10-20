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
    
    var engine=EcomplexityEngine()
    var userResponses = UserResponses()
    var userResponsesController = UserResponsesController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
                do {
                    let apiCall = APICall()
                    let questions = try await apiCall.fetchQuestions()
                    
                    if questions.isEmpty {
                        // Mostrar un mensaje de error si no hay preguntas disponibles
                        displayError(QuestionError.itemNotFound, title: "No se encontraron preguntas")
                    } else {
                        // Actualizar la interfaz si se obtuvieron preguntas
                        updateUI(with: questions)
                    }
                } catch {
                    // Mostrar un mensaje de error en caso de una excepción
                    displayError(QuestionError.itemNotFound, title: "No se pudo acceder a las preguntas")
                }
            }
        
    }
    func updateUI(with questions:Questions){
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
            self.progressLine.progress = self.engine.getProgress()
            self.textQuestion.text = self.engine.getQuestionDescription()
            self.userResponses.user = "user@tec.mx"
        }
    }
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    

    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        let question = Question(id: engine.getId(), question_num: engine.getQuestionNum(),description: engine.getQuestionDescription())
        var ans = Answer(activity: 0, question: question, answer: 0, Entrepreneur: 1)
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            ans.answer = 1
            //print("Nada de acuerdo")
        case let str where str.contains("Poco de acuerdo"):
            ans.answer = 2
            //print("Poco de acuerdo")
        case let str where str.contains("Ni de acuerdo ni desacuerdo"):
            ans.answer = 3
            //print("Ni de acuerdo ni desacuerdo")
        case let str where str.contains("De acuerdo"):
            ans.answer = 4
            //print("De acuerdo")
        default:
            ans.answer = 5
            //print("Muy de acuerdo")
        }
        userResponses.responses.append(ans)
        sender.backgroundColor = UIColor.green
        BDeAcuerdo.isEnabled = false
        bNiDeAcuerdo.isEnabled = false
        bMuyDeAcuerdo.isEnabled = false
        bNadaDeAcuerdo.isEnabled = false
        bPocoDeAcuerdo.isEnabled = false
        
        if engine.nextQuestion(){
            Task{
                do{
                    try await userResponsesController.insertUserResponses(newUserResponses: userResponses)
                    updateUserResponses(title: "Las respuestas fueron almacenas con éxito en el servidor")
                }catch{
                    displayErrorUserResponses(UserResponsesError.itemNotFound, title: "No se pudo accer almacenar las respuestas en la base de datos")
                }
            }
            
        }else{
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
        }
    }
    func updateUserResponses(title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "Datos almacenados con éxito", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default)
            alert.addAction(continueAction)
            self.present(alert,animated: true)
        }
    }
    func displayErrorUserResponses(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    @objc func nextQuestion(){
        textQuestion.text = engine.getQuestionDescription()
        progressLine.progress = engine.getProgress()
        BDeAcuerdo.backgroundColor = UIColor.white
        bNiDeAcuerdo.backgroundColor = UIColor.white
        bMuyDeAcuerdo.backgroundColor = UIColor.white
        bNadaDeAcuerdo.backgroundColor = UIColor.white
        bPocoDeAcuerdo.backgroundColor = UIColor.white
        
        BDeAcuerdo.isEnabled = true
        bNiDeAcuerdo.isEnabled = true
        bMuyDeAcuerdo.isEnabled = true
        bNadaDeAcuerdo.isEnabled = true
        bPocoDeAcuerdo.isEnabled = true
    }
}
