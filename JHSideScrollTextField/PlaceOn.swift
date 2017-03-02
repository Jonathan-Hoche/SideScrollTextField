//
//  PlaceOn.swift
//  JHPlaceUIView-UIViewExtension
//
//  Created by Jonathan Hoche on 01/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

/*  PlaceOn... - UIView Extension
        Helps with positioning a UIViews programmatically "around" - the outside of other UIViews.
        Use in conjuction with PlaceIn...
 
    WARNINGS:
        1. Call/Use only after the UIView has been initilized!!!
        2. If the UIView has constraints - set its property translatesAutoresizingMaskIntoConstraints = true
        3. May experience unexpected results when tryin to position a UIView in a view that is not its immediate superview
*/

extension UIView {
    
    //MARK: - X position ONLY
    
    func placeOnLeft(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view){
            self.frame.origin.x = view.bounds.origin.x - self.bounds.width + (offset)
        } else {
            self.frame.origin.x = view.frame.origin.x - self.bounds.width + (offset)
        }
    }
    
    func placeOnRight(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view){
            self.frame.origin.x = view.bounds.origin.x + view.bounds.width + (offset)
        } else {
            self.frame.origin.x = view.frame.origin.x + view.bounds.width + (offset)
        }
    }
    
    //MARK: - Y position ONLY
    
    func placeOnBottom(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view){
            self.frame.origin.y = view.bounds.origin.y + view.bounds.height + (offset)
        } else {
            self.frame.origin.y = view.frame.origin.y + view.bounds.height + (offset)
        }
    }
    
    func placeOnTop(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view){
            self.frame.origin.y = view.bounds.origin.y - self.bounds.height + (offset)
        } else {
            self.frame.origin.y = view.frame.origin.y - self.bounds.height + (offset)
        }
    }
}

extension UIView {
    
    //MARK: - X position ONLY
    
    func placeOnTopLeft(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeOnTop(of: view, offset: offsetY)
        placeOnLeft(of: view, offset: offsetX)
    }
    
    func placeOnTopRight(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeOnTop(of: view, offset: offsetY)
        placeOnRight(of: view, offset: offsetX)
    }
    
    //MARK: - Y position ONLY
    
    func placeOnBottomLeft(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeOnBottom(of: view, offset: offsetY)
        placeOnLeft(of: view, offset: offsetX)
    }
    
    func placeOnBottomRight(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeOnBottom(of: view, offset: offsetY)
        placeOnRight(of: view, offset: offsetX)
    }
}
