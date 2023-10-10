//
//  ViewControllerAct1.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class ViewControllerAct1: UIViewController, UIDocumentPickerDelegate {
    var newActivityCompleted: ActivitiesCompleted?
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
               let jsonEncoder = JSONEncoder()
               jsonEncoder.outputFormatting = .prettyPrinted
               let networkService = APICall()
               Task {
                   do {
                       await APICall().uploadFileToServer(fileURL: url, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 1, fileType: "file")
                       let encodeNewActivityCompleted = try jsonEncoder.encode(newActivityCompleted)
                       if let jsonString = String(data: encodeNewActivityCompleted, encoding: .utf8) {
                           print("JSON a enviar: \(jsonString)")
                       }
                       if let newUser = try await networkService.addActivitiesCompleted(newActivityCompleted: encodeNewActivityCompleted) {
                           // Maneja newUser en caso de éxito
                           // updateUI(with: newUser)
                       } else {
                           // Maneja el caso en que newUser sea nulo (error)
                       }
                   } catch {
                       print("Error al subir archivo")
                       // Manejar el error según sea necesario
                   }
               }
               
           }
    }

    
   func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
       // El usuario canceló la selección de archivos
   }
    
    
    
    @IBAction func onGoToGallery(_ sender: Any) {
        performSegue(withIdentifier: "gallerySegue", sender: self)
    }
    
    
    
    
}
