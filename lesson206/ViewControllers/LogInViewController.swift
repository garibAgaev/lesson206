//
//  LogInViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 28.11.2022.
//

import UIKit

final class LogInViewController: UIViewController {
    
    private var userNameTextField = UITextField()
    private var greetingLabel = UILabel()
    private var passwordTextField = UITextField()
    private var passwordButton = UIButton(type: .system)
    private var logInButton = UIButton(type: .system)
    
    private let users: [String: User]! = User.getUsers(logIn: "Usr", password: "Password")
    
    private var outlets: [UIView] {
        [userNameTextField,
         passwordTextField,
         logInButton,
         passwordButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllSubview()
        setFalseInAutoresizingMask()
        
        view.backgroundColor = .cyan
        
        settingTextField(textField: userNameTextField, placeholderText: "User name")
        settingTextField(textField: passwordTextField, placeholderText: "Password")
        
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.isSecureTextEntry = true
        
        settingLogInButton()
        settingPasswordButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        settingConstraintsUserNameTextField()
        settingConstraintsPasswordTextField()
        settingConstraintsLogInLabel()
        settingConstraintsPasswordButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let greetingVC = segue.destination as? GreetingsViewController, let userName = userNameTextField.text {
            greetingVC.modalPresentationStyle = .fullScreen
            greetingVC.userName = userName
            greetingVC.user = users[userName]
            return
        }
        if let forgotVC = segue.destination as? ForgotViewController {
            forgotVC.users = users
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction private func unwind(for segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc private func jumpBylogInButton() {
        guard let users = users, let userNameText = userNameTextField.text, let passwordText = passwordTextField.text else {
            showTechnicalErrorAlert {
                self.userNameTextField.text = ""
                self.passwordTextField.text = ""
            }
            return
        }
        if let user = users[userNameText], user.password == passwordText {
            performSegue(withIdentifier: "showGreetingsVC", sender: nil)
        } else {
            showAlert(title: "Invalid login or password!", message: "Please, enter correct login and password") {
                self.passwordTextField.text = ""
            }
        }
    }
    
    @objc private func jumpPasswordButton() {
        if users == nil {
            showTechnicalErrorAlert {
                self.userNameTextField.text = ""
                self.passwordTextField.text = ""
            }
        } else {
            performSegue(withIdentifier: "forgotVC", sender: nil)
        }
    }
}

private extension LogInViewController {
    
    func addAllSubview() {
        outlets.forEach {
            view.addSubview($0)
        }
    }
    
    func setFalseInAutoresizingMask() {
        outlets.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func settingTextField(textField: UITextField, placeholderText: String) {
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.placeholder = placeholderText
    }
    
    func settingPasswordTextField() {
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.isSecureTextEntry = true
    }
    
    func settingLogInButton() {
        logInButton.setTitle("Log in", for: .normal)
        logInButton.titleLabel?.font = logInButton.titleLabel?.font.withSize(16)
        logInButton.addTarget(self, action: #selector(jumpBylogInButton), for: .touchUpInside)
    }
    
    func settingPasswordButton() {
        passwordButton.setTitle("Forgot password?", for: .normal)
        passwordButton.titleLabel?.font = passwordButton.titleLabel?.font.withSize(12)
        passwordButton.addTarget(self, action: #selector(jumpPasswordButton), for: .touchUpInside)
    }
    
    func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let handler = handler else {
                return
            }
            handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showTechnicalErrorAlert(handler: (() -> Void)? = nil) {
        showAlert(
          title: "A technical error",
          message: "Our developer is crooked, we apologize",
          handler: handler
        )
    }
}

private extension LogInViewController {
    // constraints
    func settingConstraintsUserNameTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: userNameTextField, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .height, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.05, constant: 0),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .width, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.9, constant: 0)
        ])
        
    }
    
    func settingConstraintsPasswordTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: passwordTextField, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: passwordTextField, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: userNameTextField, attribute: .bottom, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: passwordTextField, attribute: .height, relatedBy: .equal,
                toItem: userNameTextField, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: passwordTextField, attribute: .width, relatedBy: .equal,
                toItem: userNameTextField, attribute: .width, multiplier: 1, constant: 0)
        ])
    }
    
    func settingConstraintsLogInLabel() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: logInButton, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: logInButton, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: logInButton, attribute: .width, relatedBy: .equal,
                toItem: userNameTextField, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(
                item: logInButton, attribute: .height, relatedBy: .equal,
                toItem: userNameTextField, attribute: .height, multiplier: 1, constant: 0)
        ])
    }
    
    func settingConstraintsPasswordButton() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: passwordButton, attribute: .centerX, relatedBy: .greaterThanOrEqual,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: passwordButton, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: logInButton, attribute: .bottom, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: passwordButton, attribute: .width, relatedBy: .equal,
                toItem: logInButton, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: passwordButton, attribute: .height, relatedBy: .equal,
                toItem: userNameTextField, attribute: .height, multiplier: 0.5, constant: 0)
        ])
    }
}
