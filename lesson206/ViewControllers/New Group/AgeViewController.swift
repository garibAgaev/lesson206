//
//  AgeViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 30.12.2022.
//

import UIKit

class AgeViewController: UIViewController {

    var user: User! = nil
    
    private var ageLable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ageLable)
        
        ageLable.textAlignment = .center
        if let age = user.age {
            ageLable.text = "\(age)"
        } else {
            ageLable.text = ""
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        settingConstraintsUserNameTextField()
    }
    
    func settingConstraintsUserNameTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: ageLable, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: ageLable, attribute: .centerY, relatedBy: .greaterThanOrEqual,
                toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: ageLable, attribute: .height, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.1, constant: 0),
            NSLayoutConstraint(
                item: ageLable, attribute: .width, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.5, constant: 0)
        ])
    }

}
