//
//  ViewControllerGaleria.swift
//  SEL4C
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class ViewControllerGaleria: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getImage(imageName: "test.png")
    }
    

    func getImage(imageName: String) {
            let fileManager = FileManager.default
            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath) {
                imageView.image = UIImage(contentsOfFile: imagePath)
            } else {
                print("No existe la imagen")
            }
        }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
            
            // Obtiene la URL del archivo de la imagen seleccionada
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                // Realiza la llamada asíncrona dentro de una tarea asíncrona
                Task {
                    await APICall().uploadFileToServer(fileURL: imageURL, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 1, fileType: "image")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

    
}
