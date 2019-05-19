//
//  UIViewExtension.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 19/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
