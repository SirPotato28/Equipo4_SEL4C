//
//  ViewControllerHamburger.swift
//  SEL4C
//
//  Created by Usuario on 01/09/23.
//

import UIKit

protocol ViewControllerHamburgerDelegate{
    func hideHambugerMenu()
}
class ViewControllerHamburger: UIViewController {

    var delegate : ViewControllerHamburgerDelegate?
    @IBOutlet weak var ImageUser: UIImageView!
    @IBOutlet weak var BackGround: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //self.setupHamburgerUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupHamburgerUI()
    {
        self.BackGround.layer.cornerRadius = 40
        self.BackGround.clipsToBounds = true
        
        self.ImageUser.layer.cornerRadius = 40
        self.ImageUser.clipsToBounds = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
