//
//  ViewControllerFinal.swift
//  SEL4C
//
//  Created by Usuario on 07/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

class ViewControllerFinal: UIViewController, UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate {

    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    
    @IBOutlet weak var enlace1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(enlace1Tapped))
                enlace1.isUserInteractionEnabled = true
                enlace1.addGestureRecognizer(tapGesture1)
    }
    
    @objc func enlace1Tapped() {
            if let url1 = URL(string: "https://www.youtube.com/watch?v=E7EzITdzarI") {
                // Abre la URL en el navegador
                UIApplication.shared.open(url1, options: [:], completionHandler: nil)
            }
        }

    
    @IBAction func playVideo(_ sender: Any) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let networkService = APICall()
        Task {
            do {
                await APICall().uploadFileToServer(fileURL: videoURL!, entrepreneurId: SessionManager.shared.currentUser!.id, activityId: 6, fileType: "file")
                let newActivityCompleted = NewActivitiesCompleted(activity: 6, entrepreneur: SessionManager.shared.currentUser!.id)
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
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()

        }
    }

}
