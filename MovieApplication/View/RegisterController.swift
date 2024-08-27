//
//  RegisterController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 3.08.2023.
//

import UIKit
import Parse

class RegisterController: UIViewController {
    
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var surname: UITextField!
    @IBOutlet var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let klavyeGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(klavyekapat))
        view.addGestureRecognizer(klavyeGestureRecognizer)
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        //        textlerin boş olup olmadığını kontrol ediyoruz, boş değilse if döngüsüne girer
        if   (name?.text != "" && password?.text != "" && email?.text != "" ) {
            let user = PFUser()
            user.username=name?.text!
            user.email=email?.text!
            user.password=password?.text!
            //           hata varsa yazdırır, yoksa kaydeder ve giriş sayfasına gönderir
            user.signUpInBackground{ ( success , error) in
                if error != nil {
                    self.HataAlert(title: "Hata", message: error?.localizedDescription ?? "Hata")}
                else {
                    self.performSegue(withIdentifier: "toVC", sender: nil)}  }
            //          textler boş ise eksiksiz doldurun alerti gösterir
        } else { self.HataAlert(title: "Hata!", message: "Lütfen bilgilerinizi eksiksiz doldurun")}
    }
    
    
    @objc func klavyekapat(){
        view.endEditing(true)
    }
    
    func HataAlert( title: String, message:String){
        let hata=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButon=UIAlertAction(title: "Tamam", style: .default)
        hata.addAction(okButon)
        self.present(hata, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    //    Bu buttonu kontrol ett!!!!
}
