//
//  ViewControllerAct3.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class ViewControllerAct3: UIViewController, UIDocumentPickerDelegate {

    
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
            if let url1 = URL(string: "https://www.sistemab.org/ser-b/") {
                // Abre la URL en el navegador
                UIApplication.shared.open(url1, options: [:], completionHandler: nil)
            }
        }

        @objc func enlace2Tapped() {
            if let url2 = URL(string: "https://www.ashoka.org/en-us/our-network") {
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
                       let jsonEncoder = JSONEncoder()
                       jsonEncoder.outputFormatting = .prettyPrinted
                       let networkService = APICall()
                       Task {
                           do {
                               await APICall().uploadFileToServer(fileURL: url, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 4, fileType: "file")
                               let alertController = UIAlertController(title: "Success", message: "Archivo enviado al servidor correctamente", preferredStyle: .alert)
                               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                               alertController.addAction(okAction)
                               self.present(alertController, animated: true, completion: nil)
                               let newActivityCompleted = NewActivitiesCompleted(activity: 4, entrepreneur: SessionManager.shared.currentUser!.id)
                               let encodeNewActivityCompleted = try jsonEncoder.encode(newActivityCompleted)
                               if let jsonString = String(data: encodeNewActivityCompleted, encoding: .utf8) {
                                   print("JSON a enviar: \(jsonString)")
                               }
                               if let response = try await APICall().addActivityCompleted(newActivityCompleted: encodeNewActivityCompleted){
                                   
                               }else{
                                   
                               }
                           } catch {
                               let alertController = UIAlertController(title: "Error", message: "No se pudo enviar el archivo al servidor", preferredStyle: .alert)
                               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                               alertController.addAction(okAction)
                               self.present(alertController, animated: true, completion: nil)
                           }
                       }
                   }
               }

               func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
                   // El usuario canceló la selección de archivos
    
    }
    

}
