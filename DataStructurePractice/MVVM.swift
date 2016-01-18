//
//  MVVM.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/17/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

//The relationships between the three components of the MVVM pattern are simpler than the MVC equivalents, following these strict rules:
//A couple of immediate advantages of this pattern are as follows:
//Lightweight Views – All your UI logic resides within the ViewModel, resulting in a very lightweight view.
//Testing – you should be able to run your entire application without the View, greatly enhancing its testability.

class MvvmView: UIViewController {
//The View has a reference to the ViewModel, but not vice-versa.
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    let viewModel = MvvmViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .ScaleAspectFit
        imageView.heightAnchor.constraintEqualToConstant(200).active = true
        imageView.widthAnchor.constraintEqualToConstant(100).active = true
        _ = [titleLabel, priceLabel].map({ (label) -> UILabel in
            label.textAlignment = .Center
            label.font = UIFont(name: "Avenir", size: 20)
            return label
        })
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.distribution = .EqualSpacing
        stackView.alignment = .Center
        stackView.spacing = 10
        view.addSubview(stackView)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
     
        bindViewModel()
    }
    
    func bindViewModel() {
        if let url = viewModel.imgURL {
            imageView.kf_setImageWithURL(url)
        }
        titleLabel.text = viewModel.productTitle
        priceLabel.text = viewModel.price
        view.backgroundColor = viewModel.backgroundColor
    }
}

public struct MvvmViewModel {
    public private (set) var backgroundColor: UIColor?
    public private (set) var productTitle: String?
    public private (set) var imgURL: NSURL?
    public private (set) var price: String?
    let model = MvvmModel(backgroundColor: UIColor.whiteColor(), imageURL: "http://images.urbanoutfitters.com/is/image/UrbanOutfitters/20611299_021_b", name: "Nail Polish", price: "$10.0")
    
    //At the core of this pattern is the ViewModel, which is a special type of model that represents the UI state of the application.
    //It contains properties that detail the state of each and every UI control. For example, the current text for a text field, or whether a specific button is enabled. It also exposes the actions the view can perform, like button taps or gestures. 
    //It can help to think of the ViewModel as the model-of-the-view.
    //The ViewModel has a reference to the Model, but not vice-versa.
    
    public init() {
        backgroundColor = model.backgroundColor
        productTitle = model.name
        price = model.price
        guard let url = NSURL(string: model.imageURL) else { return }
        imgURL = url
    }
}

struct MvvmModel {
    let backgroundColor: UIColor
    let imageURL: String
    let name: String
    let price: String
}