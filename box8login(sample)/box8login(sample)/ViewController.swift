//
//  ViewController.swift
//  box8login(sample)
//
//  Created by mac on 06/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginSegmentControl: UISegmentedControl!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var emailOrPhoneLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let keychain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelEditing))
        tap.numberOfTapsRequired = 2
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        //swotch between login and signup view
        self.loginView.isHidden = !(sender.selectedSegmentIndex == 0)
        self.loginView.alpha = (sender.selectedSegmentIndex == 0) ? 1 : 0
        self.signUpView.isHidden = (sender.selectedSegmentIndex == 0)
        self.signUpView.alpha = (sender.selectedSegmentIndex == 0) ? 0 : 1
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
        }, completion: { (success) in
        })
    }
    
    @IBAction func signInAction(_ sender: Any) {
        view.endEditing(true)
        //validations
        if (emailOrPhoneLoginTextField.text?.isValidEmail ?? true  || (emailOrPhoneLoginTextField.text?.isNumeric ?? false  && emailOrPhoneLoginTextField.text?.count ?? 0 > 8) ){
            if !(passwordLoginTextField.text?.isWhitespace ?? true){
                let pass = keychain.get(emailOrPhoneLoginTextField.text ?? "")
                //check if entered password is correct
                if let password = passwordLoginTextField.text,password == pass{
                    self.showToast(message: NSAttributedString(string: "Signed in succesfully"),position: .topAttached
                        ,withShake : false)
                }
                else{
                    self.showToast(message: NSAttributedString(string: "Unable to authenticate"),withShake : true)
                }
            }
        }
        else{
            self.showToast(message: NSAttributedString(string: "Invalid Email/Phone"),withShake : true)
        }
    }
    @IBAction func signUpAction(_ sender: Any) {
        view.endEditing(true)
        //validations
        if (emailTextField.text?.isValidEmail ?? true  && ( mobileTextField.text?.isNumeric ?? false  && mobileTextField.text?.count ?? 0 > 9)  && nameTextField.text?.isWhitespace == false && passwordTextField.text?.isWhitespace == false ){
            //to save password to keychain
            keychain.set(passwordTextField.text ?? "", forKey: emailTextField.text ?? "" )
            keychain.set(passwordTextField.text ?? "", forKey: mobileTextField.text ?? "" )
            self.showToast(message: NSAttributedString(string: "Signed up succesfully"),withShake : false)
        }
        else{
            self.showToast(message: NSAttributedString(string: "Invalid Email/Phone"),position: .topAttached
                ,withShake : true)
        }
    }
    @objc func cancelEditing(){
        view.endEditing(true)
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //to switch between textfields
        switch textField {
        case emailOrPhoneLoginTextField:
            passwordLoginTextField.becomeFirstResponder()
        case passwordLoginTextField:
            passwordLoginTextField.resignFirstResponder()
        case nameTextField:
            mobileTextField.becomeFirstResponder()
        case mobileTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

