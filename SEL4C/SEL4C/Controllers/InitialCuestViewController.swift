import UIKit

class CustomTransition2: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 // Duración de la animación en segundos
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Define tu animación personalizada aquí
        // Usa transitionContext para obtener las vistas de origen y destino
        // y realiza la animación deseada
        
        // Al finalizar la animación, llama a:
        transitionContext.completeTransition(true)
    }
}

private var sliderValues: [Int] = []




class InitialCuestViewController: UIViewController {
    var questions: [Question] = []
    var answersArray: [[String: Any]] = []
    var viewControllerInicial: ViewControllerInicial?
    var activity_id_num = 1
    let slider = UISlider()
    var engine = EcomplexityEngine()
    var userResponses = UserResponses()
    var userResponsesController = UserResponsesController()
    private var questionsText: [String] = []

    private let CuadroPregunta: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            do {
                let apiCall = APICall()
                let response = try await apiCall.fetchQuestions(activity_id: activity_id_num)
                questions = response
                self.questionsText = response.map { $0.description }

                // Agrega un fondo
                let backgroundImageView = UIImageView(image: UIImage(named: "Rectangle 27"))
                view.addSubview(backgroundImageView)
                backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                    backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

                // Agrega un título "Preguntas Iniciales"
                let titleLabel = UILabel()
                titleLabel.text = "Preguntas Iniciales"
                titleLabel.textAlignment = .center
                titleLabel.font = .systemFont(ofSize: 36)
                titleLabel.textColor = UIColor.white
                view.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])

                // Agrega una ScrollView para el contenido desplazable
                let scrollView = UIScrollView()
                view.addSubview(scrollView)
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

                // Agrega el CuadroPregunta al ScrollView
                scrollView.addSubview(CuadroPregunta)
                NSLayoutConstraint.activate([
                    CuadroPregunta.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    CuadroPregunta.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    CuadroPregunta.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    CuadroPregunta.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    CuadroPregunta.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                ])

                for pregunta in questionsText {
                    let label = UILabel()
                    label.text = pregunta
                    label.textAlignment = .left
                    label.font = .boldSystemFont(ofSize: 20) // Cambia el tamaño de la fuente
                    label.textColor = UIColor.white // Cambia el color del texto a blanco
                    label.numberOfLines = 0 // Permite múltiples líneas para preguntas largas
                    label.minimumScaleFactor = 0.5

                    let slider = UISlider()
                    slider.minimumValue = 0.0
                    slider.maximumValue = 4.0
                    slider.value = 0.0
                    slider.isContinuous = true
                    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

                    let likertImageView = UIImageView(image: UIImage(named: "Likert"))
                    likertImageView.contentMode = .scaleAspectFit

                    slider.minimumTrackTintColor = UIColor.blue
                    slider.maximumTrackTintColor = UIColor.lightGray
                    slider.thumbTintColor = UIColor.blue
                    sliderValues.append(0)

                    let valueLabel = UILabel()
                    valueLabel.text = "\(Int(slider.value))"
                    valueLabel.textAlignment = .center
                    valueLabel.textColor = UIColor.white // Cambia el color del texto a blanco

                    CuadroPregunta.addArrangedSubview(label)
                    CuadroPregunta.addArrangedSubview(likertImageView)
                    CuadroPregunta.addArrangedSubview(slider)
                    CuadroPregunta.addArrangedSubview(valueLabel)
                }

                // Agregar el botón de "Enviar" al final de las preguntas
                let sendButton = UIButton(type: .system)
                sendButton.setTitle("Enviar", for: .normal)
                sendButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
                sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
                CuadroPregunta.addArrangedSubview(sendButton)

                if self.questionsText.isEmpty {
                    self.displayError(QuestionError.itemNotFound, title: "No se encontraron preguntas")
                } else {
                    // Actualizar la interfaz si se obtuvieron preguntas
                    // self.updateUI(with: self.questions)
                }
            } catch {
                self.displayError(QuestionError.itemNotFound, title: "No se pudo acceder a las preguntas")
            }
        }
    }

    
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        sender.value = roundf(sender.value)

        if let sliderIndex = CuadroPregunta.arrangedSubviews.firstIndex(of: sender) {
            let valueLabelIndex = sliderIndex + 1
            if let valueLabel = CuadroPregunta.arrangedSubviews[valueLabelIndex] as? UILabel {
                valueLabel.text = "\(Int(sender.value))"
                sliderValues[sliderIndex / 4] = Int(sender.value)
            }
        }
    }

    @objc func sendButtonTapped() {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let networkService = APICall()

        Task {
            do {
                var answersArray = [NewAnswer]()
                
                for (index, value) in sliderValues.enumerated() {
                    let newAnswer = NewAnswer(activity: activity_id_num,question: questions[index].id, answer: value, entrepreneur: SessionManager.shared.currentUser!.id)
                    answersArray.append(newAnswer)
                }
                
                do {
                    let answersDict = ["answers": answersArray]
                    let encodeAnswers = try jsonEncoder.encode(answersDict)
                    
                    if let jsonString = String(data: encodeAnswers, encoding: .utf8) {
                        print("JSON a enviar: \(jsonString)")
                    }
                    
                    let apiCall = APICall()
                    
                    if let response = try await apiCall.addAnswers(newAnswer: encodeAnswers) {
                        viewControllerInicial?.usuarioTerminoDeContestarPreguntas() // Se puede borrar
                        // Procesa la respuesta si es necesario
                        
                    } else {
                        // Maneja el caso en el que no obtuviste una respuesta
                    }
                } catch {
                    // Maneja el error de codificación de datos aquí
                    print("Error al codificar 'answersDict': \(error)")
                }
            } catch {
                // Maneja otros errores aquí
                print("Otro error ocurrió: \(error)")
            }
        }

        
        
        
         let confirmationAlert = UIAlertController(title: "Respuestas enviadas", message: "Tus respuestas se han enviado correctamente.", preferredStyle: .alert)
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
         
         
    }

    func updateUI(with questions: Questions) {
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
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
}
