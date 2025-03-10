//
//  AppDelegate.swift
//  TransitionWithCell
//
//  Created by Ketan Chopda on 01/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

/// Helper protocol for load view from nib
protocol SSNibLoadable where Self: UIView {
    func ssFromNib() -> UIView?
}

// MARK: -
extension SSNibLoadable {
    @discardableResult
    func ssFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let contentView = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView ?? UIView()
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.setConstraints(to: self)
        return contentView
    }
}
