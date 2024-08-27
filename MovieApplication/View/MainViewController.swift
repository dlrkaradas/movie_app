//
//  ViewController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 3.08.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.backgroundColor = UIColor(named: "color")
        
        
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
    @IBAction func SıgnInButton(_ sender: Any) {
        //        email ve passwordun boş gelip gelmemesini kontrol ediyoruz, boş değilse pfuser ile kontrol edilip giriş sağlanıyor
        if email.text != "" && password.text != ""{
           
            PFUser.logInWithUsername(inBackground : email.text!, password : password.text! , block: { user, error in
                // hata varsa ekrana hata mesajı veriyor yoksa else bloğuna gidip
                if error != nil {
                    self.HataAlert(title: "Hata", message: error?.localizedDescription ?? "Hata")
                }
                else{
                    UserDefaults.standard.set(self.email.text!, forKey: "email")
                    self.signInButton.isEnabled = false
                    self.signInButton.alpha = 0.5
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                    
                }
                
            })                    }
        else { self.HataAlert(title: "Hata!", message: "Lütfen bilgilerinizi eksiksiz doldurun" ) }
        
    }
    
    func HataAlert( title: String, message:String){
        let hata=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButon=UIAlertAction(title: "Tamam", style: .default)
        hata.addAction(okButon)
        self.present(hata, animated: true)
    }
    
}

