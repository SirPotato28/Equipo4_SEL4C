//
//  ViewControllerVideo.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

class ViewControllerVideo: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {

    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func playVideo(_ sender: Any) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onRecordVideo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
             print("Camera Available")

            let videoPicker = UIImagePickerController()
            videoPicker.delegate = self
            videoPicker.sourceType = .camera
            videoPicker.mediaTypes = [kUTTypeMovie as String] // MobileCoreServices
            videoPicker.allowsEditing = false

             self.present(videoPicker, animated: true, completion: nil)
            
         }else{
             
             print("Camera UnAvaliable")
         }
    }
 
    func imagePicker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        print(videoURL!)
        do {
            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
        
        let player = AVPlayer(url: videoURL!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()

        }
    }
    
    var myPickedVideo:NSURL! = NSURL()
    
    var VideoToPass:Data!

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Close
        dismiss(animated: true, completion: nil)

        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            
            else {
                return
            }
        
        
        if let pickedVideo:NSURL = (info[UIImagePickerController.InfoKey.mediaURL] as? NSURL) {

            // Get Video URL
            self.myPickedVideo = pickedVideo
            
            do {
                try? VideoToPass = Data(contentsOf: pickedVideo as URL)
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let documentsDirectory = paths[0]
                let tempPath = documentsDirectory.appendingFormat("/vid.mp4")
                let url = URL(fileURLWithPath: tempPath)
                do {
                    try? VideoToPass.write(to: url, options: [])
                }

                // If you want display Video here 1
            }
        }
        // Handle a movie capture
         UISaveVideoAtPathToSavedPhotosAlbum(
             url.path,
             self,
            #selector(video(_:didFinishSavingWithError:contextInfo:)),
             nil)
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let title = (error == nil) ? "Bien" : "Error"
        let message = (error == nil) ? "El video fue guardado" : "El video no se guardó"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
                        await APICall().uploadFileToServer(fileURL: url, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 5, fileType: "file")
                        let newActivityCompleted = NewActivitiesCompleted(activity: 5, entrepreneur: SessionManager.shared.currentUser!.id)
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
                        if let response = try await APICall().addActivityCompleted(newActivityCompleted: encodeNewActivityCompleted){
                            
                        }else{
                            
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
    
    
    
    
}
