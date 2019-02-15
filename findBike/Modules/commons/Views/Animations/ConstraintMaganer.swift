//
//  ConstraintMaganer.swift
//  findBike
//
//  Created by Israel on 2/14/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import UIKit

enum Constraint:Int
{
    case PositionX
    case PositionY
    case SizeWidth
    case SizeHeight
    
    func getLayoutAttibutes()->([NSLayoutConstraint.Attribute])
    {
        switch self
        {
        case .PositionX:
            return [NSLayoutConstraint.Attribute.centerX, NSLayoutConstraint.Attribute.leading, NSLayoutConstraint.Attribute.left, NSLayoutConstraint.Attribute.leadingMargin, NSLayoutConstraint.Attribute.leftMargin, NSLayoutConstraint.Attribute.trailing, NSLayoutConstraint.Attribute.right, NSLayoutConstraint.Attribute.trailingMargin, NSLayoutConstraint.Attribute.rightMargin]
        case .PositionY:
            return [NSLayoutConstraint.Attribute.centerY, NSLayoutConstraint.Attribute.top, NSLayoutConstraint.Attribute.topMargin, NSLayoutConstraint.Attribute.bottom, NSLayoutConstraint.Attribute.bottomMargin]
        case .SizeWidth:
            return [NSLayoutConstraint.Attribute.width, NSLayoutConstraint.Attribute.leading, NSLayoutConstraint.Attribute.left, NSLayoutConstraint.Attribute.leadingMargin, NSLayoutConstraint.Attribute.leftMargin, NSLayoutConstraint.Attribute.trailing, NSLayoutConstraint.Attribute.right, NSLayoutConstraint.Attribute.trailingMargin, NSLayoutConstraint.Attribute.rightMargin]
        case .SizeHeight:
            return [NSLayoutConstraint.Attribute.height, NSLayoutConstraint.Attribute.top, NSLayoutConstraint.Attribute.topMargin, NSLayoutConstraint.Attribute.bottom, NSLayoutConstraint.Attribute.bottomMargin]
        }
    }
}


class ConstraintManager
{
    static let sharedInstance = ConstraintManager()
    
    func getConstraints(view:UIView, constraint:Constraint) -> [NSLayoutConstraint]
    {
        let attributes:[NSLayoutConstraint.Attribute] = constraint.getLayoutAttibutes()
        var arrayConstraints:[NSLayoutConstraint] = []
        
        for constraint in (view.superview?.constraints)!
        {
            if let _ = constraint.firstItem
            {
                if (constraint.firstItem?.isEqual(view))!
                {
                    if attributes.contains(constraint.firstAttribute)
                    {
                        arrayConstraints.append(constraint)
                    }
                }
            }
            
            if let _ = constraint.secondItem
            {
                if (constraint.secondItem?.isEqual(view))!
                {
                    if attributes.contains(constraint.secondAttribute)
                    {
                        arrayConstraints.append(constraint)
                    }
                }
            }
        }
        
        for constraint in view.constraints
        {
            if attributes.contains(constraint.firstAttribute)
            {
                arrayConstraints.append(constraint)
            }
        }
        
        return arrayConstraints
    }
    
    func hasConstraints(view:UIView, constraint:Constraint) -> Bool
    {
        let attributes:[NSLayoutConstraint.Attribute] = constraint.getLayoutAttibutes()
        
        for constraint in (view.superview?.constraints)!
        {
            if let _ = constraint.firstItem
            {
                if (constraint.firstItem?.isEqual(view))!
                {
                    if attributes.contains(constraint.firstAttribute)
                    {
                        return true
                    }
                }
            }
            
            if let _ = constraint.secondItem
            {
                if (constraint.secondItem?.isEqual(view))!
                {
                    if attributes.contains(constraint.secondAttribute)
                    {
                        return true
                    }
                }
            }
        }
        
        for constraint in view.constraints
        {
            if attributes.contains(constraint.firstAttribute)
            {
                return true
            }
        }
        
        return false
    }
}
