//
//  SettingsController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 4.08.2023.
//

import UIKit
import Parse

class SettingsController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    var user : Users!
    override func viewDidLoad() {
        super.viewDidLoad()
        veriAl()
  
    }
    
    func veriAl (){
        let email = UserDefaults.standard.object(forKey: "email") as! String
        self.emailLabel.text = email
        let query = PFQuery(className: "User")
        query.findObjectsInBackground(){ users , error in
            if error != nil {
                self.HataAlert(title: "Hata", message: "hata")
            }else{
//                self.nameLabel.text = users?[0].object(forKey: "username") as! String
//            self.createdAtLabel.text = query.whereKey("createdAt", equalTo: self.emailLabel.text!)
                
            }
        }
    }

        
    
    
    @IBAction func cikisYap(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.HataAlert(title: "Hata!", message: "Hata!")
            }else {
                self.performSegue(withIdentifier: "toGirisEkrani", sender: nil)
            }
        }
    }
    
    
    func HataAlert( title: String, message:String){
        let hata=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButon=UIAlertAction(title: "Tamam", style: .default)
        hata.addAction(okButon)
        self.present(hata, animated: true)
    }
}
