//
//  PlaceIn.swift
//  JHPlaceUIView-UIViewExtension
//
//  Created by Jonathan Hoche on 01/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

/*  PlaceIn... - UIView Extension
        Helps with positioning a UIViews programmatically within its parent view (superview) and also within other UIViews.
        Use in conjuction with PlaceOn...

    WARNINGS:
        1. Call/Use only after the UIView has been initilized!!!
        2. If the UIView has constraints - set its property translatesAutoresizingMaskIntoConstraints = true
        3. May experience unexpected results when tryin to position a UIView in a UIView that is not its immediate superview
*/

extension UIView {
    //MARK: - Centering X and Y positions
    
    // Center in a view X and Y axis
    func placeInCenter(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInMidX(of: view, offset: offsetX)
        placeInMidY(of: view, offset: offsetY)
    }

    //MARK: - X position ONLY
    
    // Place just inside the left of a view (within - inwards)
    func placeInLeft(of view: UIView, offset: CGFloat = 0){
        if (self.superview == view) {
            self.frame.origin.x = view.bounds.origin.x + (offset)
        } else {
            self.frame.origin.x = view.frame.origin.x + (offset)
        }
    }
    
    // Place just inside the right of a view (within - inwards)
    func placeInRight(of view: UIView, offset: CGFloat = 0) {
        
        if (self.superview == view) {
            self.frame.origin.x = view.bounds.origin.x + view.bounds.width - self.bounds.width + (offset)
        } else {
            self.frame.origin.x = view.frame.origin.x + view.bounds.width - self.bounds.width + (offset)
        }
    }
    
    // Center inside a view X axis
    func placeInMidX(of view: UIView, offset: CGFloat = 0) {
        let halfWidthOfViewToBeCenteredIn = view.frame.width / 2
        let halfWidth = self.bounds.width / 2
        
        if (self.superview == view) {
            self.frame.origin.x = view.bounds.origin.x + halfWidthOfViewToBeCenteredIn - halfWidth + (offset)
        } else {
            self.frame.origin.x = view.frame.origin.x + halfWidthOfViewToBeCenteredIn - halfWidth + (offset)
        }
    }
    
    //MARK: - Y position ONLY
    
    // Place just inside the top of a view (within - inwards)
    func placeInTop(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view) {
            self.frame.origin.y = view.bounds.origin.y + (offset)
        } else {
            self.frame.origin.y = view.frame.origin.y + (offset)
        }
    }
    
    // Place just inside the bottom of a view (within - inwards)
    func placeInBottom(of view: UIView, offset: CGFloat = 0) {
        if (self.superview == view) {
            self.frame.origin.y = view.bounds.origin.y + view.bounds.height - self.bounds.height + (offset)
        } else {
            self.frame.origin.y = view.frame.origin.y + view.bounds.height - self.bounds.height + (offset)
        }
    }
    
    // Center inside a view Y axis
    func placeInMidY(of view: UIView, offset: CGFloat = 0) {
        let halfHeightOfViewToBeCenteredIn = view.bounds.height / 2
        let halfHeight = self.bounds.height / 2
        
        if (self.superview == view) {
            self.frame.origin.y = view.bounds.origin.y + halfHeightOfViewToBeCenteredIn - halfHeight + (offset)
        } else {
            self.frame.origin.y = view.frame.origin.y + halfHeightOfViewToBeCenteredIn - halfHeight + (offset)
        }
    }
}


// "Shorthands" for positioning in x and y axis
extension UIView {
    
    //MARK: - "Shorthands" X and Y position
    
    func placeInTopLeft(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInTop(of: view, offset: offsetY)
        placeInLeft(of: view, offset: offsetX)
    }
    
    func placeInTopRight(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInTop(of: view, offset: offsetY)
        placeInRight(of: view, offset: offsetX)
    }
    
    func placeInBottomLeft(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInBottom(of: view, offset: offsetY)
        placeInLeft(of: view, offset: offsetX)
    }
    
    func placeInBottomRight(of view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInBottom(of: view, offset: offsetY)
        placeInRight(of: view, offset: offsetX)
    }
}


// "Shorthands" for positioning a view in it's own parent view (superview)
extension UIView {
    
    //MARK: - superview "Shorthands" Centering X and Y position
    
    // Center inside the superview X and Y axis
    func placeInCenterOfSuperView(offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInCenter(of: superview!, offsetX: offsetX, offsetY: offsetY)
    }
    
    //MARK: - superview "Shorthands" X position ONLY
    
    // Place just inside the left of the superview (within - inwards)
    func placeInLeftOfSuperView(offset: CGFloat = 0){
        placeInLeft(of: superview!, offset: offset)
    }
    
    // Place just inside the right of the superview (within - inwards)
    func placeInRightOfSuperView(offset: CGFloat = 0){
        placeInRight(of: superview!, offset: offset)
    }
    
    // Place in the middle X position of the superview
    func placeInMidXOfSuperView(offset: CGFloat = 0) {
        placeInMidX(of: superview!, offset: offset)
    }
    
    //MARK: - superview "Shorthands" Y position ONLY
    
    // Place just inside the top of the superview (within - inwards)
    func placeInTopOfSuperView(offset: CGFloat = 0) {
        placeInTop(of: superview!, offset: offset)
    }
    
    // Place just inside the bottom of the superview (within - inwards)
    func placeInBottomOfSuperView(offset: CGFloat = 0) {
        placeInBottom(of: superview!, offset: offset)
    }
    
    // Place in the middle Y position of the superview
    func placeInMidYOfSuperView(offset: CGFloat = 0) {
        placeInMidY(of: superview!, offset: offset)
    }
    
    //MARK: - superview "Shorthands" X and Y position
    
    func placeInTopLeftOfSuperView(offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInTop(of: superview!, offset: offsetY)
        placeInLeft(of: superview!, offset: offsetX)
    }
    
    func placeInTopRightOfSuperView(offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInTop(of: superview!, offset: offsetY)
        placeInRight(of: superview!, offset: offsetX)
    }
    
    func placeInBottomLeftOfSuperView(offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInBottom(of: superview!, offset: offsetY)
        placeInLeft(of: superview!, offset: offsetX)
    }
    
    func placeInBottomRightOfSuperView(offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        placeInBottom(of: superview!, offset: offsetY)
        placeInRight(of: superview!, offset: offsetX)
    }
}

