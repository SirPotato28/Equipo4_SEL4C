//
//  ViewControllerAct1.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class ViewControllerAct1: UIViewController, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
       print("Entrando a la función documetnPiker")
       for url in urls {
               // Procesa los archivos seleccionados aquí (por ejemplo, subirlos a un servidor, guardarlos localmente, etc.)
               print("Archivo seleccionado: \(url.lastPathComponent)")
               let jsonEncoder = JSONEncoder()
               jsonEncoder.outputFormatting = .prettyPrinted
               let networkService = APICall()
               Task {
                   do {
                       await APICall().uploadFileToServer(fileURL: url, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 2, fileType: "file")
                       let newActivityCompleted = NewActivitiesCompleted(activity: 2, entrepreneur: SessionManager.shared.currentUser!.id)
                       let encodeNewActivityCompleted = try jsonEncoder.encode(newActivityCompleted)
                       if let jsonString = String(data: encodeNewActivityCompleted, encoding: .utf8) {
                           print("JSON a enviar: \(jsonString)")
                       }else{
                        
                       }
    
                       if let response = try await APICall().addActivityCompleted(newActivityCompleted: encodeNewActivityCompleted){
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
    
    
    @IBAction func OpenGallery(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //imageView.image = selectedImage
            // Obtiene la URL del archivo de la imagen seleccionada
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                // Realiza la llamada asíncrona dentro de una tarea asíncrona
                Task {
                    do{
                        let jsonEncoder = JSONEncoder()
                        jsonEncoder.outputFormatting = .prettyPrinted
                        do {
                            try await APICall().uploadFileToServer(fileURL: imageURL, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 2, fileType: "image")
                            let alertController = UIAlertController(title: "Succes", message: "Imagen enviada al servidor correctamente", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        } catch {
                            let alertController = UIAlertController(title: "Error", message: "No se pudo enviar la imagen al servidor", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        let newActivityCompleted = NewActivitiesCompleted(activity: 2, entrepreneur: SessionManager.shared.currentUser!.id)
                        let encodeNewActivityCompleted = try jsonEncoder.encode(newActivityCompleted)
                        if let jsonString = String(data: encodeNewActivityCompleted, encoding: .utf8) {
                            print("JSON a enviar: \(jsonString)")
                        }else{
                         
                        }
                        
                        if let response = try await APICall().addActivityCompleted(newActivityCompleted: encodeNewActivityCompleted){
                            
                        }else{
                           
                        }
                        
                    }catch{
                       
                    }
                    
                    
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

    
    
}
