//
//  ViewControllerMAIN.swift
//  SEL4C
//
//  Created by Andrew Williams on 25/08/23.
//

import UIKit

class ViewControllerMAIN: UIViewController {

    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: Any){
        if(emailField.text == "test" && passField.text == "123"){
            UserDefaults.standard.set(true, forKey: "loggeduser")
            let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")as! ActividadesScene
            self.navigationController?.pushViewController(HomeVC, animated: true)
        }
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
