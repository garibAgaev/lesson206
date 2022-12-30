//
//  NameViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 30.12.2022.
//

import UIKit

class NameViewController: UIViewController {
    
    var user: User! = nil
    
    private var nameLable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLable)
        
        nameLable.textAlignment = .center
        nameLable.text = user.name
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        settingConstraintsUserNameTextField()
    }
    
    func settingConstraintsUserNameTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: nameLable, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: nameLable, attribute: .centerY, relatedBy: .greaterThanOrEqual,
                toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: nameLable, attribute: .height, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.1, constant: 0),
            NSLayoutConstraint(
                item: nameLable, attribute: .width, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.5, constant: 0)
        ])
    }
}
