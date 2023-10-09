//
//  ViewControllerAct2.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class ViewControllerAct2: UIViewController, UIDocumentPickerDelegate {

    
    @IBOutlet weak var enlace1: UILabel!
    
    @IBOutlet weak var enlace2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(enlace1Tapped))
                enlace1.isUserInteractionEnabled = true
                enlace1.addGestureRecognizer(tapGesture1)

                // Configura el gestor de toques para el enlace2
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(enlace2Tapped))
                enlace2.isUserInteractionEnabled = true
                enlace2.addGestureRecognizer(tapGesture2)
    }
    
    @objc func enlace1Tapped() {
            if let url1 = URL(string: "https://www.youtube.com/watch?v=MCKH5xk8X-g") {
                // Abre la URL en el navegador
                UIApplication.shared.open(url1, options: [:], completionHandler: nil)
            }
        }

        @objc func enlace2Tapped() {
            if let url2 = URL(string: "https://www.undp.org/es/sustainable-development-goals") {
                // Abre la URL en el navegador
                UIApplication.shared.open(url2, options: [:], completionHandler: nil)
            }
        }
    
    
    @IBAction func subirArchivos(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: .import)
                       documentPicker.delegate = self
                       documentPicker.allowsMultipleSelection = true
                       self.present(documentPicker, animated: true, completion: nil)
           }
           
           func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
                   for url in urls {
                       // Procesa los archivos seleccionados aquí (por ejemplo, subirlos a un servidor, guardarlos localmente, etc.)
                       print("Archivo seleccionado: \(url.lastPathComponent)")
                   }
               }

               func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
                   // El usuario canceló la selección de archivos
    }
    
    
    
    
}
