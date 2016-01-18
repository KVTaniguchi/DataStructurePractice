//
//  MVP.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/17/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

//  https://ios.james.ooo/model-view-controller-presenter-8bb4149fa5ef#.fuhf7ojsp

import Foundation
import UIKit
import Kingfisher

class MVPresenter: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenterView = ModelPresenter(frame: CGRectZero)
        presenterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presenterView)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[presenter]|", options: [], metrics: nil, views: ["presenter":presenterView]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[presenter]|", options: [], metrics: nil, views: ["presenter":presenterView]))
    
        let model = MVPModel(backgroundColor: UIColor.orangeColor(), imageURL: "http://images.urbanoutfitters.com/is/image/UrbanOutfitters/20611299_021_b", name: "Nail Polish", price: "$10.0")
        presenterView.model = model
        
        // code for pushing to a pdp
    }
}

public class ModelPresenter: UIView {
    // the core of this pattern is the model presenter - in this case it is a view that does the heavy lifting of layout.  the UIViewController handles navigation and information flow into the presenter
    
    public private (set) var imageView = UIImageView()
    public private (set) var titleLabel = UILabel()
    public private (set) var priceLabel = UILabel()
    var model: MVPModel? {
        didSet {
            guard let mvpModel = model, url = NSURL(string: mvpModel.imageURL) else { return }
            imageView.kf_setImageWithURL(url)
            titleLabel.text = mvpModel.name
            priceLabel.text = mvpModel.price
            backgroundColor = mvpModel.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        addSubview(stackView)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: [], metrics: nil, views: ["stackView":stackView]))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MVPModel {
    let backgroundColor: UIColor
    let imageURL: String
    let name: String
    let price: String
}