import UIKit

class ViewController5: UIViewController {

    @IBOutlet weak var button2: UIButton! // Agrega una referencia al botón 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicialmente, deshabilita el botón 2
        button2.isEnabled = false
    }
    
    @IBAction func Check(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        // Habilita o deshabilita el botón 2 en función del estado seleccionado del sender
        button2.isEnabled = sender.isSelected
    }
}
