//
//  UIView+Anchor.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
   func anchorView (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, enableInsets: Bool) {
          
          var topInset = CGFloat(0)
          var bottomInset = CGFloat(0)
          
          if #available(iOS 11, *), enableInsets {
              let insets = self.safeAreaInsets
              topInset = insets.top
              bottomInset = insets.bottom
          }
          
          translatesAutoresizingMaskIntoConstraints = false
          
          if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: Constant.paddingForView + topInset).isActive = true
          }
          if let left = left {
              self.leftAnchor.constraint(equalTo: left, constant: Constant.paddingForView).isActive = true
          }
          if let right = right {
              rightAnchor.constraint(equalTo: right, constant: -Constant.paddingForView).isActive = true
          }
          if let bottom = bottom {
              bottomAnchor.constraint(equalTo: bottom, constant: -Constant.paddingForView - bottomInset).isActive = true
          }
      }
    
    func anchorSize (width: CGFloat, height: CGFloat) {
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
