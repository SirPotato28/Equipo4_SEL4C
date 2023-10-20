//
//  ViewControllerResults.swift
//  SEL4C
//
//  Created by Usuario on 20/10/23.
//

import UIKit

class ViewControllerResults: UIViewController {
    var entrepreneurProfile: [EntrepreneurProfile] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            do{
                let apiCall = APICall()
                let response = try await apiCall.getEntrepreneurProfile(entrepreneur_id: SessionManager.shared.currentUser!.id) //act hardcodeada
                entrepreneurProfile = response
                print(entrepreneurProfile)
            }catch{
                
            }
        }
        // Do any additional setup after loading the view.
    }
    

}
