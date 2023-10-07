//
//  ViewControllerAct3.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class ViewControllerAct3: UIViewController, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
