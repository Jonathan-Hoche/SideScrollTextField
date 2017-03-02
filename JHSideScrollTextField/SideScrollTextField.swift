//
//  SideScrollTextField.swift
//  JHSideScrollTextField
//
//  Created by Jonathan Hoche on 21/02/2017.
//  Copyright © 2017 Jonathan Hoche. All rights reserved.
//

import UIKit

@IBDesignable
class SideScrollTextField: UIView {
    
    private enum AnimationType {
        case startInEndOut// single
        case startInRepeatOut // uses duplicateTextField
        case startOutEndOut // single
        case startOutRepeatEndOut // uses duplicateTextField
    }
    
    private func determineAnimationType() -> AnimationType {
        if startOutOfBounds {
            if repeatWhenOutOfBounds {
                return .startOutEndOut // single
            } else {
                return .startOutRepeatEndOut // uses duplicateTextField
            }
        } else {
            if repeatWhenOutOfBounds {
                return .startInEndOut// single
            } else {
                return .startInRepeatOut // uses duplicateTextField
            }
        }
    }
    
    
    private var isTextViewAddedAsSubview = false
    
    private let innerWidthBoundsSpace: CGFloat = 10 // space from left and right edges (5 from left - 5 from right)
    
    private var isTextFittingInView : Bool? //dont know until we check
    
    private var isScrolling = false // true while scrolling
    private var repeatCount = 0 // only incremented if scrollRepeat > 0
    private var isFirstScroll = true
    
    //Used in scrolling as the repeat when two have to appear at the same time
    private let duplicateTextField: UITextField  = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    let textField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    
    //FIRST OF ALL!!! You must set the text in the storyboard or programmatically. The didSet observer will get called and initilize the view correctly and add the textField as a subview.
    @IBInspectable
     var text: String = "" {
        didSet
        {
            //self.layer.removeAllAnimations()
            isScrolling = false
            if !isTextViewAddedAsSubview { //add textView as subview and set some view parameters
                textField.isEnabled = false
                self.addSubview(textField)
                isTextViewAddedAsSubview = true
      
                let grayish = UIColor(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
                self.layer.borderColor = grayish.cgColor
                self.layer.borderWidth = 1
                self.layer.cornerRadius = 5
                self.clipsToBounds = true
                textField.textColor = .black
            }
            
            textField.text = text
            //textField.sizeToFit()
            textField.bounds.size.width = self.bounds.width - innerWidthBoundsSpace
            textField.placeInCenterOfSuperView() // just an initial alignment
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var fontSizeAsView: Bool = false // true wiil ignore fontSizes and make the font size as big as the view (it's superview)
    
    @IBInspectable
    var fontSize: CGFloat = 17.0 {
        didSet{
            textField.font =  textField.font?.withSize(fontSize)
        }
    }// initial font size. will be ignored at runtime if maxFontSize OR minFontSize are bigger than 0. OR if fontSizeAsView = true
    
    @IBInspectable
    var maxFontSize: CGFloat = 0.0 // ignored when = 0 OR if fontSizeAsView = true
    
    @IBInspectable
    var minFontSize: CGFloat = 0.0 // ignored when = 0 OR if fontSizeAsView = true
    
    @IBInspectable
    var scrollLeft: Bool = true // false =  scroll right
    
    @IBInspectable
    var scrollOnlyWhenTooLong: Bool = false // only when the text is longer than the view (isTextFittingInView = false)
    
    @IBInspectable
    var scrollRepeat: Int = -1 // -1 = always. 0 = scrolls once with no repeat. 1...n = number of repeats.
    
    @IBInspectable
    var scrollTime: Double = 5 // seconds until scroll out of bounds and animation "round" finishes (0 = use scrollSpeed)
    // EXAMPLE: scrollTime = 10 will finish the eniter animation in 10 seconds
    
    @IBInspectable
    var scrollSpeed: Int = 0 // movment in points(pixels) per second (only works if scrollTime is at 0)
    // EXAMPLE: scrollSpeed = 10 will move 10 pixels every second ( the more pixels, the quicker the animation will end)
    
    @IBInspectable
    var repeatWhenOutOfBounds: Bool = true // text will repeat only when prior goes out of bounds
    
    @IBInspectable
    var repeatSpacing: Int = 50 // space between each repeat in points (ignored if repeatWhenOutOfBounds = true)
    
    @IBInspectable
    var delayAtStart: Double = 2 // delay in seconds before starting (only happens once if using repeatSpacing)
    
    @IBInspectable
    var delayAtEnd: Double = 0 // delay in seconds when each cycle ends (ignored if using repeatSpacing)
    
    @IBInspectable
    var startOutOfBounds: Bool = false // animation starts with the text out of bounds (text will be out of bounds even before start scroliing)
    
    private func prepareTextViewForScroll(){
        duplicateTextField.removeFromSuperview()
        
        textField.bounds.size.width = self.bounds.width - innerWidthBoundsSpace // textField width needs to be the same as its (superview - the spaces) intially
        if fontSizeAsView {
            textField.font = textField.font?.withSize(self.bounds.height)
            textField.sizeToFit()
            textField.placeInCenterOfSuperView() // just an initial alignment
        } else if maxFontSize <= 0 || minFontSize <= 0 {
            textField.font = textField.font?.withSize(fontSize)
            textField.sizeToFit()
            textField.placeInCenterOfSuperView() // just an initial alignment
        } else if maxFontSize >= minFontSize {
            textField.font = textField.font?.withSize(maxFontSize)
            textField.placeInCenterOfSuperView() // just an initial alignment
            textField.resizeFontToFit(fontMaxSize: Double(maxFontSize), fontMinSize: Double(minFontSize))
            textField.sizeToFit()
            textField.placeInCenterOfSuperView() // just an initial alignment
        } else {
            textField.sizeToFit()
            textField.placeInCenterOfSuperView() // just an initial alignment
        }
        
        isTextFittingInView = textField.isFontFitting(viewWidth: self.bounds.width - innerWidthBoundsSpace)
        
        switch determineAnimationType() {
        case .startInEndOut:
            duplicateTextField.removeFromSuperview() // remove if ever added
            if self.scrollLeft {
                textField.placeInLeftOfSuperView(offset: innerWidthBoundsSpace / 2)
            } else {
                textField.placeInRightOfSuperView(offset: -(innerWidthBoundsSpace / 2))
            }
        case .startInRepeatOut:
            if self.scrollLeft {
                textField.placeInLeftOfSuperView(offset: innerWidthBoundsSpace / 2)
            } else {
                textField.placeInRightOfSuperView(offset: -(innerWidthBoundsSpace / 2))
            }
            prepareDuplicateTextViewForScroll()
        case .startOutEndOut:
            duplicateTextField.removeFromSuperview() // remove if ever added
            if self.scrollLeft {
                textField.placeInRightOfSuperView(offset: textField.bounds.width)
            } else {
                textField.placeInLeftOfSuperView(offset: -(textField.bounds.width))
            }
        case .startOutRepeatEndOut:
            if self.scrollLeft {
                textField.placeInRightOfSuperView(offset: textField.bounds.width)
            } else {
                textField.placeInLeftOfSuperView(offset: -(textField.bounds.width))
            }
            prepareDuplicateTextViewForScroll()
        }
    }
    
    private func prepareDuplicateTextViewForScroll() {
        duplicateTextField.bounds.size.width = textField.bounds.width
        duplicateTextField.bounds.size.height = textField.bounds.height
        duplicateTextField.font = textField.font
        duplicateTextField.text = textField.text
        duplicateTextField.textColor = textField.textColor
        duplicateTextField.isEnabled = textField.isEnabled
        //TODO: - may need to add more to copy all of textField attributes
        self.addSubview(duplicateTextField)
        duplicateTextField.placeInCenterOfSuperView() // just an initial alignment
        
        if self.scrollLeft {
            duplicateTextField.placeOnRight(of: textField, offset: CGFloat(repeatSpacing))
        } else {
            duplicateTextField.placeOnLeft(of: textField, offset: -CGFloat(repeatSpacing))
        }
    }
    
    func startScroll() {
        if isScrolling {
            //ignore
        } else{
            //textField.layer.speed = 1
            //duplicateTextField.layer.speed = 1
            textField.resignFirstResponder() //dismiss keyboard
            textField.isEnabled = false // disable if enabled
            prepareToScroll()
        }
    }
    
    func stopScroll() {
        if isScrolling {
            isScrolling = false
            textField.layer.removeAllAnimations()
            duplicateTextField.layer.removeAllAnimations()
            //textField.layer.speed = 0 // another way to stop animation
            //duplicateTextField.layer.speed = 0
            //prepareTextViewForScroll()
        } else{
            //ignore
        }
    }
    
    private func prepareToScroll() {
        repeatCount = 0
        isFirstScroll = true
        prepareTextViewForScroll()
        if scrollOnlyWhenTooLong {
            if isTextFittingInView == false {
                isScrolling = true
                scroll()
            } else {
                print("MESSAGE from SideScrollTextField: scrollOnlyWhenTooLong = true - \(textField.text) text will not scroll since it is short enough to fit in its view")
            }
        } else {
            isScrolling = true
            scroll()
        }
        
    }
    
    //MARK: - Animations
    private func scroll() {
        switch determineAnimationType() {
        case .startInEndOut:
            startInEndOut()
        case .startInRepeatOut:
            startInRepeatOut()
        case .startOutEndOut:
            startOutEndOut()
        case .startOutRepeatEndOut:
            startOutRepeatEndOut()
        }
    }
    
    private func startInEndOut() {
        if isScrolling {
            let pixelsToTravelWholeRepeat = Double(self.bounds.width + textField.bounds.width)
            
            let delayTime = isFirstScroll ? delayAtStart : delayAtEnd
            let wholeTime =  scrollTime > 0.0 ? scrollTime : pixelsToTravelWholeRepeat / Double(scrollSpeed)
            
            let pixelsToTravelAtStart = Double(textField.bounds.width + (innerWidthBoundsSpace / 2))
            let pixelsStartPercentage = 100 / (pixelsToTravelWholeRepeat / pixelsToTravelAtStart)
            let beginingDurationTime = startOutOfBounds ? wholeTime : (pixelsStartPercentage * wholeTime) / 100
            //for a whole animation (out to out) of a 100width View, text that is 120width takes 220pixels...
            //the start animation is 120pixels + innerWidthBoundsSpace/2 = 125...
            //the pixels percentage of the start animation is  100% / (220/125) = 56.8181818182%...
            //56.8181818182% of 20seconds is (56.8181818182 * 20) / 100 = 11.3636363636
            
            
            let durationTime = isFirstScroll ? beginingDurationTime : wholeTime
            
            /*
            print("\(text)")
            print("\(text) isFirstScroll=\(isFirstScroll)")
            print("for scrollLeft=\(scrollLeft)... startOutOfBounds=\(startOutOfBounds):")
            print("durationTime: \(durationTime)")
            print("")
            */
            
                
            UIView.animate(withDuration: durationTime, delay: delayTime , options: [.curveLinear], animations: {
                if self.scrollLeft {
                    self.textField.placeInLeftOfSuperView(offset: -self.textField.frame.width)
                } else {
                    self.textField.placeInRightOfSuperView(offset: self.textField.frame.width)
                }
            }) { (completion) in
                //END
                if self.scrollLeft {
                    self.textField.placeInRightOfSuperView(offset: self.textField.frame.width)
                } else {
                    self.textField.placeInLeftOfSuperView(offset: -self.textField.frame.width)
                }
                
                self.isFirstScroll = false
                
                if self.isScrolling {
                    if self.scrollRepeat > 0 {
                        self.repeatCount +=  1
                    }
                    if self.scrollRepeat == 0 || (self.scrollRepeat > 0 && self.repeatCount > self.scrollRepeat) {
                        //DO NOTHING
                    } else {
                        self.startInEndOut() // repeat animation
                    }
                }
            }
        }
    }
    
    private func startInRepeatOut() {
        if isScrolling {
            
            let pixelsToTravelWholeRepeat = Double(self.bounds.width + textField.bounds.width)
            
            let delayTime = isFirstScroll ? delayAtStart : delayAtEnd
            let wholeTime =  scrollTime > 0.0 ? scrollTime : pixelsToTravelWholeRepeat / Double(scrollSpeed)
            
            
            let pixelsToTravelAtStart = Double(textField.bounds.width + (innerWidthBoundsSpace / 2))
            let pixelsStartPercentage: Double = 100 / (pixelsToTravelWholeRepeat / pixelsToTravelAtStart)
            //for a whole animation (out to out) of a 100width View, text that is 120width = 220pixels...
            //the start animation is 120pixels + innerWidthBoundsSpace/2 = 125...
            //the pixels percentage of the start animation is  100% / (220/125) = 56.8181818182%...
            //56.8181818182% of 20seconds is (56.8181818182 * 20) / 100 = 11.3636363636
            
            
            let slightPixelsRemainingFix:Double = scrollLeft ? 100 : 15 //light adjustments for scrolling left or right
            let pixelsRemainingPercentage: Double = 100 / (pixelsToTravelWholeRepeat / (Double(repeatSpacing) + Double(innerWidthBoundsSpace / 2) + slightPixelsRemainingFix))
            let remainingDurationTime = (pixelsRemainingPercentage * wholeTime) / 100
            
            /* PAST CALCULATION (keep for reference)
             // additionalTime is the time needed for the duplicateTextField to travel to textField start position, after textField goes out of bounds
             // let pixelsPerSecond = Double(pixelsToTravelWholeRepeat) / Double(beginingDurationTime)
             //let additionalTime = Double(repeatSpacing) / Double(pixelsPerSecond)
             //if to move 100width out of frame takes 20seconds...
             //to move an extra 10width (space) will take...
             //100 / 20 = 4pixels per second...
             //10 / 4 =  2.5seconds
             */
            
            let beginingDurationTime = startOutOfBounds ? wholeTime : (pixelsStartPercentage * wholeTime) / 100
            
            /*
            print("isFirstScroll=\(isFirstScroll)")
            print("for scrollLeft=\(scrollLeft)... startOutOfBounds=\(startOutOfBounds):")
            print("WholeTime: \(wholeTime) beginingTime: \(beginingDurationTime) remainingTime: \(remainingDurationTime)")
            print("\(beginingDurationTime) + \(remainingDurationTime) = \(beginingDurationTime + remainingDurationTime)")
            print("")
             */
            
            UIView.animate(withDuration: beginingDurationTime, delay: delayTime , options: [.curveLinear], animations: {
                if self.scrollLeft {
                    self.textField.placeInLeftOfSuperView(offset: -self.textField.frame.width)
                    self.duplicateTextField.placeOnRight(of: self.textField, offset: CGFloat(self.repeatSpacing))
                } else {
                    self.textField.placeInRightOfSuperView(offset: self.textField.frame.width)
                    self.duplicateTextField.placeOnLeft(of: self.textField, offset: CGFloat(-self.repeatSpacing))
                }
            }) { (completion) in
                //END
                
                UIView.animate(withDuration: remainingDurationTime, delay: 0, options: [.curveLinear], animations: {
                    if self.scrollLeft {
                        self.duplicateTextField.placeInLeftOfSuperView(offset: (self.innerWidthBoundsSpace / 2))
                    } else {
                        self.duplicateTextField.placeInRightOfSuperView(offset: -((self.innerWidthBoundsSpace / 2)))
                    }
                    
                }) { (completion) in
                    if self.isScrolling {
                        if self.scrollLeft {
                            self.textField.placeInLeftOfSuperView(offset: self.innerWidthBoundsSpace / 2)
                            self.duplicateTextField.placeOnRight(of: self.textField, offset: CGFloat(self.repeatSpacing))
                        } else {
                            self.textField.placeInRightOfSuperView(offset: -(self.innerWidthBoundsSpace / 2))
                            self.duplicateTextField.placeOnLeft(of: self.textField, offset: CGFloat(-self.repeatSpacing))
                        }
                        
                        self.isFirstScroll = false
                        
                        
                        if self.scrollRepeat > 0 {
                            self.repeatCount +=  1
                        }
                        if self.scrollRepeat == 0 || (self.scrollRepeat > 0 && self.repeatCount > self.scrollRepeat) {
                            //DO NOTHING
                        } else {
                            self.startInRepeatOut() // repeat animation
                        }
                    }
                }
            }
            
        }
    }
    
    private func startOutEndOut() {
        startInEndOut() // Exactly the same (just that the prepareTextViewForScroll() positioned the begining differntly)
    }
    
    private func startOutRepeatEndOut() {
        startInRepeatOut() // Exactly the same (just that the prepareTextViewForScroll() positioned the begining differntly)
    }
    
    
    /*
    private func initialize() {
        //prepareToScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //initialize()
    }
     */
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
}

extension UITextField {
    //TRIES to resize the font to fit in the bounds given a max and minimum size font pointSize
    func resizeFontToFit(fontMaxSize: Double, fontMinSize: Double) {
        guard let font = self.font, let text = self.text else {
            return
        }
        
        let textBounds = self.textRect(forBounds: self.bounds)
        let maxWidth = textBounds.size.width
        
        for fontSize in stride(from: fontMaxSize, through: fontMinSize, by: -0.5) {
            let size = (text as NSString).size(attributes: [NSFontAttributeName: font.withSize(CGFloat(fontSize))])
            self.font = font.withSize(CGFloat(fontSize))
            if size.width <= maxWidth {
                break // text fits
            }
        }
    }
    
    // returns true if the font with in its current size an width fits in a given width
    func isFontFitting(viewWidth: CGFloat) -> Bool? {
        guard let font = self.font, let text = self.text else {
            return nil
        }
        
         let size = (text as NSString).size(attributes: [NSFontAttributeName: font.withSize(font.pointSize)])
        if size.width <= viewWidth {
            return true // text fits
        } else {
            return false // text is longer
        }
    }
}
