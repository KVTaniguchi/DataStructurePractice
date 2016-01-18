//
//  MVC.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/17/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public class MVCViewController: UIViewController {
    public private (set) var imageView = UIImageView()
    public private (set) var titleLabel = UILabel()
    public private (set) var priceLabel = UILabel()
    var model: MVCModel? {
        didSet {
            guard let mvpModel = model, url = NSURL(string: mvpModel.imageURL) else { return }
            imageView.kf_setImageWithURL(url)
            titleLabel.text = mvpModel.name
            priceLabel.text = mvpModel.price
            view.backgroundColor = mvpModel.backgroundColor
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .ScaleAspectFit
        imageView.heightAnchor.constraintEqualToConstant(200).active = true
        imageView.widthAnchor.constraintEqualToConstant(100).active = true
        _ = [titleLabel, priceLabel].map({ (label) -> UILabel in
            label.textAlignment = .Center
            label.backgroundColor = UIColor.whiteColor()
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
   
        // The View/Controller handles the bulk of layout and navigation
        model = MVCModel(backgroundColor: UIColor.blueColor(), imageURL: "http://images.urbanoutfitters.com/is/image/UrbanOutfitters/20611299_021_b", name: "Nail Polish", price: "$10.0")
    }
}

struct MVCModel {
    let backgroundColor: UIColor
    let imageURL: String
    let name: String
    let price: String
}