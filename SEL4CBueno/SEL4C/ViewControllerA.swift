//
//  ViewControllerA.swift
//  SEL4C
//
//  Created by Usuario on 31/08/23.
//

import UIKit

class ViewControllerA: UIViewController {

    @IBOutlet weak var HamburgerViewMenu: UIView!
    @IBOutlet weak var BackGround: UIView!

    @IBOutlet weak var leadingConstraintForHamburgerView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        BackGround.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func hideHamburgerView()
    {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.BackGround.alpha = 0.0
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = -280
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.BackGround.isHidden = true
                //self.isHamburgerMenuShown = false
            }
        }
    }
    @IBAction func ShowMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.BackGround.alpha = 1
            self.BackGround.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                //self.ShowMenu = true
            }

        }

        self.BackGround.isHidden = false
        
    }
}
    
    
    

