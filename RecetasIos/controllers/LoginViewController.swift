//
//  LoginViewController.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 31/01/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if let email = txtEmail.text, let passowrd = txtPassword.text{
            Auth.auth().signIn(withEmail: email, password: passowrd){
                (result, error) in
                
                if let res = result, error == nil{
                    // ESTÁ LOGEADO
                    self.navigationController?.popViewController(animated: true)
                }else{
                    // NO SE HA LOGEADO
                    let alert = UIAlertController(title: "ERROR", message: "ERROR EN  LOGIN \(error.debugDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnRegistrar(_ sender: Any) {
        if let email = txtEmail.text, let passowrd = txtPassword.text{
            Auth.auth().createUser(withEmail: email, password: passowrd){
                (result, error) in
                
                if let res = result, error == nil{
                    // ESTÁ LOGEADO
                    self.navigationController?.popViewController(animated: true)
                }else{
                    // NO SE HA LOGEADO
                    let alert = UIAlertController(title: "ERROR", message: "ERROR EN  LOGIN \(error.debugDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
