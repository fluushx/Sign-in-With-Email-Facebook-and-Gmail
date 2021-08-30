//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Felipe Ignacio Zapata Riffo on 26-08-21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "77097381740-gdmqj4c0j4ukgj6cptb9l777md73h02m.apps.googleusercontent.com")
     
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
        mailTextField.layer.shadowColor = UIColor.lightGray.cgColor
        mailTextField.layer.shadowOffset = CGSize(width:3, height:3)
        mailTextField.layer.shadowOpacity = 3
        mailTextField.layer.shadowRadius = 3
        mailTextField.layer.borderWidth = 0.5
        mailTextField.layer.borderColor = UIColor.black.cgColor
        return mailTextField
    }()
    
    private let passwordTextField : UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.textAlignment = .left
        passwordTextField.placeholder =  "Type Your Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.shadowColor = UIColor.lightGray.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width:3, height:3)
        passwordTextField.layer.shadowOpacity = 3
        passwordTextField.layer.shadowRadius = 3
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
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
        loginButton.backgroundColor = .link
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowOffset = CGSize(width:3, height:3)
        loginButton.layer.shadowOpacity = 3
        loginButton.layer.shadowRadius = 3
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return loginButton
    }()
    
    
    private let containerViewLabelAndIconMail : UIView = {
        let containerMail = UIView()
        containerMail.translatesAutoresizingMaskIntoConstraints = false
        containerMail.backgroundColor = .systemGray5
        containerMail.layer.cornerRadius = 12
        containerMail.layer.shadowColor = UIColor.lightGray.cgColor
        containerMail.layer.shadowOffset = CGSize(width:3, height:3)
        containerMail.layer.shadowOpacity = 3
        containerMail.layer.shadowRadius = 3
        containerMail.layer.borderWidth = 0.5
        containerMail.layer.borderColor = UIColor.black.cgColor
        
        return containerMail
    }()
    
    private let containerViewPasswordAndIconMail : UIView = {
        let containerPassword = UIView()
        containerPassword.translatesAutoresizingMaskIntoConstraints = false
        containerPassword.backgroundColor = .systemGray5
        containerPassword.layer.cornerRadius = 12
        containerPassword.layer.shadowColor = UIColor.lightGray.cgColor
        containerPassword.layer.shadowOffset = CGSize(width:3, height:3)
        containerPassword.layer.shadowOpacity = 3
        containerPassword.layer.shadowRadius = 3
        containerPassword.layer.borderWidth = 0.5
        containerPassword.layer.borderColor = UIColor.black.cgColor
        return containerPassword
    }()
    
    private let containerGoogleLogin : GIDSignInButton = {
        let containerGoogleLogin = GIDSignInButton()
        containerGoogleLogin.translatesAutoresizingMaskIntoConstraints = false
        containerGoogleLogin.layer.cornerRadius = 12
        containerGoogleLogin.layer.cornerRadius = 12
        containerGoogleLogin.layer.shadowColor = UIColor.lightGray.cgColor
        containerGoogleLogin.layer.shadowOffset = CGSize(width:3, height:3)
        containerGoogleLogin.layer.shadowOpacity = 3
        containerGoogleLogin.layer.shadowRadius = 3
        containerGoogleLogin.layer.borderColor = UIColor.black.cgColor
        containerGoogleLogin.addTarget(self, action: #selector(didTapButtonGoogle), for: .touchUpInside)
        return containerGoogleLogin
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         
        
        setUpView()
        
         
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mailTextField.becomeFirstResponder()
    }
    @objc func didTapButtonGoogle (){
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { result, error in
            guard result == result, error == nil else {
                return
            }
            
        }
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
            strongSelf.dismiss(animated: true, completion: nil)
            
               for v in strongSelf.view.subviews{
                  v.removeFromSuperview()
               }
             
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
        view.addSubview(loginButton)
        view.addSubview(containerViewLabelAndIconMail)
        containerViewLabelAndIconMail.addSubview(iconMail)
        containerViewLabelAndIconMail.addSubview(mailTextField)
        view.addSubview(containerViewPasswordAndIconMail)
        containerViewPasswordAndIconMail.addSubview(iconPassword)
        containerViewPasswordAndIconMail.addSubview(passwordTextField)
        view.addSubview(containerGoogleLogin)
         
        
        
        setUpConstraintsV2()
      
        
         
    }
    
    func setUpConstraintsV2(){
        
        //Mark:- imageLoginCenter
        imageLoginCenter.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        imageLoginCenter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        imageLoginCenter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55).isActive = true
        imageLoginCenter.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
         
         
        //Mark:- iconMail
        iconMail.topAnchor.constraint(equalTo: containerViewLabelAndIconMail.topAnchor, constant: 18).isActive = true
        iconMail.leadingAnchor.constraint(equalTo: containerViewLabelAndIconMail.leadingAnchor,constant: 10).isActive = true
        iconMail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconMail.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Mark:- mailTextField
        mailTextField.topAnchor.constraint(equalTo: containerViewLabelAndIconMail.topAnchor, constant: 15).isActive = true
        mailTextField.leadingAnchor.constraint(equalTo: iconMail.trailingAnchor, constant: 10).isActive = true
        mailTextField.trailingAnchor.constraint(equalTo: containerViewLabelAndIconMail.trailingAnchor, constant: -10).isActive = true
        mailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Mark:- containerViewLabelAndIconMail
        containerViewLabelAndIconMail.topAnchor.constraint(equalTo: imageLoginCenter.bottomAnchor, constant: 20).isActive = true
        containerViewLabelAndIconMail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        containerViewLabelAndIconMail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        containerViewLabelAndIconMail.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        //Mark:- iconPassword
        iconPassword.topAnchor.constraint(equalTo: containerViewPasswordAndIconMail.topAnchor, constant: 18).isActive = true
        iconPassword.leadingAnchor.constraint(equalTo: containerViewPasswordAndIconMail.leadingAnchor,constant: 10).isActive = true
        iconPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconPassword.widthAnchor.constraint(equalToConstant: 50).isActive = true
 
         
    
        
        //Mark:- containerViewPasswordAndIconMail
        containerViewPasswordAndIconMail.topAnchor.constraint(equalTo: containerViewLabelAndIconMail.bottomAnchor, constant: 20).isActive = true
        containerViewPasswordAndIconMail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        containerViewPasswordAndIconMail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        containerViewPasswordAndIconMail.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //Mark:- passwordTextField
        passwordTextField.topAnchor.constraint(equalTo: containerViewPasswordAndIconMail.topAnchor, constant: 15).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: iconPassword.trailingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerViewLabelAndIconMail.trailingAnchor, constant: -10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Mark:- loginButton

        loginButton.topAnchor.constraint(equalTo: containerViewPasswordAndIconMail.bottomAnchor, constant: 20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        //Mark:- containerGoogleLogin

        containerGoogleLogin.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        containerGoogleLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        containerGoogleLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerGoogleLogin.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
     

}

