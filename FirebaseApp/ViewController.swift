//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Felipe Ignacio Zapata Riffo on 26-08-21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
     
    private let imageLoginCenter : UIImageView = {
       let titleLogin = UIImageView()
        titleLogin.contentMode = .scaleAspectFit
        titleLogin.translatesAutoresizingMaskIntoConstraints = false
        titleLogin.image = UIImage(named: "Image")
         
        return titleLogin
    }()
    
    private let mailTextField : UITextField = {
       let mailTextField = UITextField()
        mailTextField.textColor = .black
        mailTextField.textAlignment = .left
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.autocapitalizationType = .none
        mailTextField.placeholder =  "Type Your Mail"
        mailTextField.backgroundColor = .white
        mailTextField.layer.cornerRadius = 10
        mailTextField.layer.masksToBounds = true
        mailTextField.font = .systemFont(ofSize: 15)
        mailTextField.leftViewMode = .always
        
        return mailTextField
    }()
    
    private let passwordTextField : UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.textAlignment = .left
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder =  "Type You Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    private let iconMail: UIImageView = {
        let iconMail = UIImageView()
        iconMail.tintColor = .black
        iconMail.contentMode = .scaleAspectFill
        iconMail.translatesAutoresizingMaskIntoConstraints = false
        iconMail.image = UIImage(systemName: "mail")
 
        
        return iconMail
    }()
    
    private let iconPassword: UIImageView = {
        let iconPassword = UIImageView()
        iconPassword.tintColor = .black
        iconPassword.contentMode = .scaleAspectFill
        iconPassword.translatesAutoresizingMaskIntoConstraints = false
        iconPassword.image = UIImage(systemName: "lock")
        return iconPassword
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return loginButton
    }()
    
    
    private let containerViewLabelAndIconMail : UIView = {
        let containerMail = UIView()
        containerMail.translatesAutoresizingMaskIntoConstraints = false
        containerMail.backgroundColor = .quaternarySystemFill
        
        return containerMail
    }()
    
    private let containerViewPasswordAndIconMail : UIView = {
        let containerPassword = UIView()
        return containerPassword
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link

        setUpView()
        
         
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mailTextField.becomeFirstResponder()
    }
    
    @objc func didTapButton (){
        guard let mail = mailTextField.text, !mail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing Data")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: mail, password: password, completion: {
            [weak self] result, error in
               guard let strongSelf = self else {
                   return
               }
               guard error == nil else {
                strongSelf.showCreateAccount(mail: mail, password: password)
                 
                   return
               }
            
            print("You have sign in")
            strongSelf.mailTextField.isHidden = true
            strongSelf.passwordTextField.isHidden = true
            strongSelf.loginButton.isHidden = true
            strongSelf.imageLoginCenter.isHidden = true
            strongSelf.iconMail.isHidden = true
            strongSelf.iconPassword.isHidden = true
            
            strongSelf.mailTextField.resignFirstResponder()
            strongSelf.passwordTextField.resignFirstResponder()
             
        })
         
         
    }
    
    @objc func showCreateAccount(mail:String, password:String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: mail, password: password, completion: {[weak self] result, error in
                
                guard let strongSelf = self else {
                    return
                    
                }
                guard error == nil else {
                  print("Account creation failed ")
                    return
                }
             print("You have sign in")
             strongSelf.mailTextField.isHidden = true
             strongSelf.passwordTextField.isHidden = true
             strongSelf.loginButton.isHidden = true
             strongSelf.imageLoginCenter.isHidden = true
             strongSelf.iconMail.isHidden = true
             strongSelf.iconPassword.isHidden = true
             strongSelf.mailTextField.resignFirstResponder()
             strongSelf.passwordTextField.resignFirstResponder()
             
                 
                
            })
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    func setUpView (){
        view.addSubview(imageLoginCenter)
        view.addSubview(iconMail)
        view.addSubview(iconPassword)
        view.addSubview(mailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(containerViewLabelAndIconMail)
      
        
        setUpConstraints()
    }
    
    func setUpConstraints(){
        //Mark:- titleLoginLabel
        imageLoginCenter.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        imageLoginCenter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        imageLoginCenter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        imageLoginCenter.heightAnchor.constraint(equalToConstant: 150).isActive = true
         
        
        //Mark:- iconMail
        iconMail.topAnchor.constraint(equalTo: imageLoginCenter.bottomAnchor, constant: 50).isActive = true
        iconMail.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
         
        iconMail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconMail.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        //Mark:- iconPassword
        iconPassword.topAnchor.constraint(equalTo: iconMail.bottomAnchor, constant: 10).isActive = true
        iconPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true

        iconPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconPassword.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Mark:- mailTextField
        mailTextField.topAnchor.constraint(equalTo: imageLoginCenter.bottomAnchor, constant: 50).isActive = true
        mailTextField.leadingAnchor.constraint(equalTo: iconMail.trailingAnchor, constant: 10).isActive = true
        mailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        mailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
         
        //Mark:- passwordTextField
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: iconPassword.trailingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        //Mark:- loginButton

        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }


}

