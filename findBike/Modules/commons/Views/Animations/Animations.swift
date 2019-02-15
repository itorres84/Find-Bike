//
//  Animations.swift
//  findBike
//
//  Created by Israel on 2/14/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import UIKit

class Animation
{
    static let sharedInstance = Animation()
    
    //MARK:- Translate
    
    func translateTo(view:UIView, x:CGFloat, y:CGFloat)
    {
        let deltaX = x - view.center.x
        let deltaY = y - view.center.y
        
        translate(view: view, x: deltaX, y: deltaY)
    }
    
    func translateToWithAnimation(view:UIView, x:CGFloat, y:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations:
            {
                self.translateTo(view: view, x: x, y: y)
        },
                       completion:completion)
    }
    
    func translate(view:UIView, x:CGFloat, y:CGFloat)
    {
        if ConstraintManager.sharedInstance.hasConstraints(view: view, constraint: Constraint.PositionX)
        {
            translateConstraint(view: view, constraintType: Constraint.PositionX, x: x, y: y)
            view.superview?.layoutIfNeeded()
        }
        else
        {
            view.center.x += x
        }
        
        if ConstraintManager.sharedInstance.hasConstraints(view: view, constraint: Constraint.PositionY)
        {
            translateConstraint(view: view, constraintType: Constraint.PositionY, x: x, y: y)
            view.superview?.layoutIfNeeded()
        }
        else
        {
            view.center.y += y
        }
    }
    
    func translateWithAnimation(view:UIView, x:CGFloat, y:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations:
            {
                self.translate(view: view, x: x, y: y)
        },
                       completion:completion)
    }
    
    func translateConstraint(view:UIView, constraintType:Constraint, x:CGFloat, y:CGFloat)
    {
        let constraints = ConstraintManager.sharedInstance.getConstraints(view: view, constraint: constraintType)
        
        switch constraintType
        {
        case .PositionX:
            for constraint in constraints
            {
                switch constraint.firstAttribute
                {
                case NSLayoutConstraint.Attribute.centerX:
                    constraint.constant += x
                    break
                default:
                    break
                }
            }
            break
        case .PositionY:
            for constraint in constraints
            {
                switch constraint.firstAttribute
                {
                case NSLayoutConstraint.Attribute.centerY:
                    constraint.constant += y
                    break
                case NSLayoutConstraint.Attribute.bottom:
                    constraint.constant -= y
                    break
                case NSLayoutConstraint.Attribute.top:
                    constraint.constant += y
                    break
                default:
                    break
                }
            }
            
            break
        default:
            break
        }
        
        
    }
    
    //MARK:- Scale
    
    func scale(view:UIView, scale:CGFloat)
    {
        resize(view: view, width: view.frame.size.width * scale, height: view.frame.size.height * scale)
    }
    
    func scaleWithAnimation(view:UIView, scale:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations:
            {
                self.scale(view: view, scale: scale)
        },
                       completion:completion)
    }
    
    //MARK:- Resize
    
    func resize(view:UIView, width:CGFloat, height:CGFloat)
    {
        let center = view.center
        
        if ConstraintManager.sharedInstance.hasConstraints(view: view, constraint: Constraint.SizeWidth)
        {
            resizeConstraint(view: view, constraintType: Constraint.SizeWidth, width: width, height: height)
            translateTo(view: view, x: center.x, y: center.y)
            view.superview?.layoutIfNeeded()
        }
        else
        {
            view.frame.size.width = width
            view.center.x = center.x
        }
        
        if ConstraintManager.sharedInstance.hasConstraints(view: view, constraint: Constraint.SizeHeight)
        {
            resizeConstraint(view: view, constraintType: Constraint.SizeHeight, width: width, height: height)
            translateTo(view: view, x: center.x, y: center.y)
            view.superview?.layoutIfNeeded()
        }
        else
        {
            view.frame.size.height = height
            view.center.y = center.y
        }
    }
    
    func resizeWithAnimation(view:UIView, width:CGFloat, height:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations:
            {
                self.resize(view: view, width: width, height: height)
        },
                       completion:completion)
    }
    
    func resizeConstraint(view:UIView, constraintType:Constraint, width:CGFloat, height:CGFloat)
    {
        let constraints = ConstraintManager.sharedInstance.getConstraints(view: view, constraint: constraintType)
        
        switch constraintType
        {
        case .SizeWidth:
            for constraint in constraints
            {
                switch constraint.firstAttribute
                {
                case NSLayoutConstraint.Attribute.width:
                    constraint.constant = width
                    break
                default:
                    break
                }
            }
            break
        case .SizeHeight:
            for constraint in constraints
            {
                switch constraint.firstAttribute
                {
                case NSLayoutConstraint.Attribute.height:
                    constraint.constant = height
                    break
                default:
                    break
                }
            }
            break
        default:
            break
        }
        
        
    }
    
    //MARK:- Rotate
    func rotateWithAnimation(view:UIView, degrees:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration:duration, delay: delay, options: options, animations:
            {
                
        },
                       completion:completion)
    }
    
    //MARK:- Alpha
    func alphaWithAnimation(view:UIView, alpha:CGFloat, duration: TimeInterval, delay:TimeInterval, options:UIView.AnimationOptions, completion:((Bool) -> Void)?)
    {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations:
            {
                view.alpha = alpha
                view.layoutIfNeeded()
        },
                       completion:completion)
    }
    
    
    
    
}
