//
//  OccupationViewController.swift
//  lesson206
//
//  Created by Garib Agaev on 30.12.2022.
//

import UIKit

class OccupationViewController: UIViewController {

    var user: User! = nil
    
    private var occupationLable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        occupationLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(occupationLable)
        
        occupationLable.textAlignment = .center
        occupationLable.text = user.occupation?.rawValue
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        settingConstraintsUserNameTextField()
    }
    
    func settingConstraintsUserNameTextField() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: occupationLable, attribute: .centerX, relatedBy: .equal,
                toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: occupationLable, attribute: .centerY, relatedBy: .greaterThanOrEqual,
                toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(
                item: occupationLable, attribute: .height, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.1, constant: 0),
            NSLayoutConstraint(
                item: occupationLable, attribute: .width, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.5, constant: 0)
        ])
    }

}
