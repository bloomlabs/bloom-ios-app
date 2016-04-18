//
//  Extensions.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 18/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation

extension UIView {
    func resizeToFitSubviews() {
        let subviewsRect = subviews.reduce(CGRect.zero) {
            $0.union($1.frame)
        }
        
        frame.size = subviewsRect.size
    }
}