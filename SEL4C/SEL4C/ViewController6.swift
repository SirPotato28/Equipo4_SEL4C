//
//  ViewController6.swift
//  SEL4C
//
//  Created by Andrew Williams on 26/08/23.
//

import UIKit

class ViewController6: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var CompleteRegistration: UIView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func Back2MM(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
}
