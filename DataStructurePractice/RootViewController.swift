//
//  ViewController.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/13/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    let MVVMButton = UIButton(type: .Custom)
    let MVPButton = UIButton(type: .Custom)
    let MVCButton = UIButton(type: .Custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        title = "Data Structure Practice"
        
        MVCButton.setTitle("MVC", forState: .Normal)
        MVVMButton.setTitle("MVVM", forState: .Normal)
        MVPButton.setTitle("MVP", forState: .Normal)
        
        MVCButton.addTarget(self, action: #selector(RootViewController.pushToMVC), forControlEvents: .TouchUpInside)
        MVPButton.addTarget(self, action: #selector(RootViewController.pushToMVP), forControlEvents: .TouchUpInside)
        MVVMButton.addTarget(self, action: #selector(RootViewController.pushToMVVM), forControlEvents: .TouchUpInside)
        
        let buttons = [MVCButton, MVPButton, MVVMButton]
        _ = buttons.map({ (button) -> UIButton in
            button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.widthAnchor.constraintEqualToConstant(UIScreen.mainScreen().bounds.width)
            return button
        })
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        stackView.alignment = .Center
        stackView.spacing = 30.0
        view.addSubview(stackView)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pushToMVC() {
        let mvcVC = MVCViewController()
        navigationController?.pushViewController(mvcVC, animated: true)
    }
    
    func pushToMVP() {
        let mvpVC = MVPresenter()
        navigationController?.pushViewController(mvpVC, animated: true)
    }
    
    func pushToMVVM() {
        let mvvmVC = MvvmView()
        navigationController?.pushViewController(mvvmVC, animated: true)
    }
}

