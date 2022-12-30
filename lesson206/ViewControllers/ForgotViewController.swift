//
//  ForgotViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 29.12.2022.
//

import UIKit

class ForgotViewController: UIViewController {
    
    private var userNameTextField = UITextField()
    private var passwordButton = UIButton()
    
    var users: [String : User]! = nil
    
    private var outlets: [UIView] {
        [userNameTextField,
         passwordButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllSubview()
        setFalseInAutoresizingMask()
        
        view.backgroundColor = .gray
        
        settingUserNameTextField()
        
        settingPasswordButton()
    }
    
    override func viewWillLayoutSubviews() {
        settingConstraintsUserNameTextField()
        settingConstraintsSeeButton()
    }
    
    @objc private func seeButtonAction() {
        let alert: UIAlertController
        let okAction: UIAlertAction
        guard let userName = userNameTextField.text else {
            return
        }
        if let user = users[userName] {
            alert = UIAlertController(title: "Your Password", message: user.password, preferredStyle: .alert)
            okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.dismiss(animated: true)
            }
        } else {
            alert = UIAlertController(title: "There is no such user", message: "Please enter a valid username", preferredStyle: .alert)
            okAction = UIAlertAction(title: "Ok", style: .default)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func settingUserNameTextField() {
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.backgroundColor = .white
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.spellCheckingType = .no
        userNameTextField.autocorrectionType = .no
        userNameTextField.placeholder = "User Name"
    }
    
    private func settingPasswordButton() {
        passwordButton.setTitle("Show password", for: .normal)
        passwordButton.titleLabel?.font = passwordButton.titleLabel?.font.withSize(16)
        passwordButton.addTarget(self, action: #selector(seeButtonAction), for: .touchUpInside)
    }
    
    private func addAllSubview() {
        outlets.forEach {
            view.addSubview($0)
        }
    }
    
    private func setFalseInAutoresizingMask() {
        outlets.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

private extension ForgotViewController {
    // constraints
    func settingConstraintsUserNameTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: userNameTextField, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0.3 * view.frame.width),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .height, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.05, constant: 0),
            NSLayoutConstraint(
                item: userNameTextField, attribute: .width, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.9, constant: 0)
        ])
    }
    
    func settingConstraintsSeeButton() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: passwordButton, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: passwordButton, attribute: .top, relatedBy: .greaterThanOrEqual,
                toItem: userNameTextField, attribute: .bottom, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: passwordButton, attribute: .width, relatedBy: .equal,
                toItem: userNameTextField, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(
                item: passwordButton, attribute: .height, relatedBy: .equal,
                toItem: userNameTextField, attribute: .height, multiplier: 1, constant: 0)
        ])
    }
}
