//
//  AppDelegate.swift
//  TransitionWithCell
//
//  Created by Ketan Chopda on 01/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

// MARK: - UIView + AutoLayout extension
extension UIView {
    
    /// Constrain 4 edges of `self` to specified `view`.
    func setConstraints(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
    
}
