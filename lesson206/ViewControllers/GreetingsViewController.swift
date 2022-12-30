//
//  GreetingsViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 02.12.2022.
//

import UIKit

class GreetingsViewController: UIViewController {
    
    @IBOutlet private var logOutButton: UIButton!
    
    var userName: String!
    var user: User! = nil
    
    private var informationOfMeButton = UIButton(type: .system)
    private var greetingLabel = UILabel()
    
    private var outlets: [UIView] {
        [logOutButton,
         informationOfMeButton,
         greetingLabel]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFalseInAutoresizingMask()
        addAllSubview()
        
        view.backgroundColor = .red
        
        settingGreetingLabel()
        settingLogOutButton()
        settingInformationOfMeButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        modalPresentationStyle = .fullScreen
        settingConstraintsGreetingLabel()
        settingConstraintsLogOutButton()
        settingConstraintsInformationOfMeButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBC = segue.destination as? UITabBarController, let viewControllers = tabBC.viewControllers else {
            return
        }
        for viewController in viewControllers {
            if let viewController = viewController as? NameViewController {
                viewController.user = user
            }
            if let viewController = viewController as? OccupationViewController {
                viewController.user = user
            }
            if let viewController = viewController as? AgeViewController {
                viewController.user = user
            }
        }
    }
    
    @objc private func jumpInformationOfMeButton() {
        performSegue(withIdentifier: "informationTBC", sender: nil)
    }
}

private extension GreetingsViewController {
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
    
    func settingGreetingLabel() {
        greetingLabel.text = "Welcome, \(userName ?? "")"
        greetingLabel.textAlignment = .center
    }
    
    func settingLogOutButton() {
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.titleLabel?.font = logOutButton.titleLabel?.font.withSize(16)
    }
    
    func settingInformationOfMeButton() {
        informationOfMeButton.setTitle("Information of me", for: .normal)
        informationOfMeButton.titleLabel?.font = informationOfMeButton.titleLabel?.font.withSize(16)
        informationOfMeButton.addTarget(self, action: #selector(jumpInformationOfMeButton), for: .touchUpInside)
    }
}

private extension GreetingsViewController {
    func settingConstraintsLogOutButton() {
        guard let logOutButton = logOutButton else { return }
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: logOutButton, attribute: .centerY, relatedBy: .equal,
                toItem: view, attribute: .centerY, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: logOutButton, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: logOutButton, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(
                item: logOutButton, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        ])
    }
    func settingConstraintsGreetingLabel() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: greetingLabel, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: greetingLabel, attribute: .top, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0.1 * view.frame.width),
            NSLayoutConstraint(
                item: greetingLabel, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(
                item: greetingLabel, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        ])
    }
    
    func settingConstraintsInformationOfMeButton() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: informationOfMeButton, attribute: .centerY, relatedBy: .equal,
                toItem: view, attribute: .centerY, multiplier: 1, constant: -0.1 * view.frame.width),
            NSLayoutConstraint(
                item: informationOfMeButton, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: informationOfMeButton, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(
                item: informationOfMeButton, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        ])
    }
}
