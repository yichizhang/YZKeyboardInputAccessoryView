//
//  YZNumberKeyboardView.swift
//  NumberKeyboardViewDemo
//
//  Created by Yichi on 12/03/2015.
//  Copyright (c) 2015 Yichi. All rights reserved.
//

import Foundation
import UIKit

class YZNumberKeyboardView : UIView, UIInputViewAudioFeedback {
	weak var textField:UITextField?
	weak var textView:UITextView?
	var numberKeyButtons:[CYRKeyboardButton] = Array()
	var numberKeyButtonsContainerView = UIView()
	var numberKeyButtonsContainerHeight:CGFloat = 60
	var numberKeyButtonsContainerOriginY:CGFloat = 12
	lazy var dissmissButton:UIButton = {
		let b = UIButton.buttonWithType(.Custom) as UIButton
		let image = YZNumberKeyboardViewStyle.imageOfDismissKeyBoardImage
		b.setImage(image, forState: .Normal)
		b.setImage(image, forState: .Highlighted)
		return b
	}()
	// UIInputViewAudioFeedback
	var enableInputClicksWhenVisible:Bool {
		return true
	}
	
	class func attachTo(#textInput:UITextInput) {
		let view = YZNumberKeyboardView()
		
		if(textInput.isKindOfClass(UITextField)) {
			var t = textInput as UITextField;
			t.inputAccessoryView = view
			view.textField = t
		}
		else if(textInput.isKindOfClass(UITextView)) {
			var t = textInput as UITextView;
			t.inputAccessoryView = view
			view.textView = t
		}
	}
	
	func commonInit() {
		self.frame = CGRect(
			x: 0,
			y: 0,
			width: 0,
			height: numberKeyButtonsContainerHeight + numberKeyButtonsContainerOriginY
		)
		backgroundColor = YZNumberKeyboardViewStyle.keyboardBackgroundColor
		//UIColor.clearColor()
		
		addSubview(numberKeyButtonsContainerView)
		numberKeyButtonsContainerView.backgroundColor = YZNumberKeyboardViewStyle.keyboardBackgroundColor
		for i in 1...10 {
			let key = "\(i%10)"
			let b = CYRKeyboardButton()
			b.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
			b.addTarget(self, action: "numberKeyTapped:", forControlEvents: .TouchUpInside)
			b.input = key
			
			numberKeyButtons.append(b)
			numberKeyButtonsContainerView.addSubview(b)
		}
		
		dissmissButton.addTarget(self, action: "dissmissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
		addSubview(dissmissButton)
		
	}
	
	override init() {
		super.init()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		superview?.layoutSubviews()
		
		self.dissmissButton.sizeToFit()
		let dissmissButtonSize = self.dissmissButton.bounds.size
		self.dissmissButton.frame = CGRect(
			x: bounds.width - dissmissButtonSize.width,
			y: 0,
			width: dissmissButtonSize.width,
			height: dissmissButtonSize.height
		)
		
		numberKeyButtonsContainerView.frame = CGRect(
			x: 0,
			y: numberKeyButtonsContainerOriginY,
			width: bounds.width,
			height: numberKeyButtonsContainerHeight
		)
		
		
		let padding = CGFloat(4)
		let keyCount = CGFloat(numberKeyButtons.count)
		let keyWidth = (self.bounds.width - padding * (keyCount + 1)) / keyCount
		
		for (index, keyButton) in enumerate(numberKeyButtons) {
			let i = CGFloat(index)
			keyButton.frame = CGRect(
				x: padding * (i+1.0) + keyWidth * i,
				y: padding + 10,
				width: keyWidth,
				height: numberKeyButtonsContainerHeight - 2*padding - 10
			)
		}
	}
	
	// MARK: Dissmiss button tapped.
	func dissmissButtonTapped(sender:AnyObject) {
		textField?.resignFirstResponder()
		textView?.resignFirstResponder()
	}
	
	// MARK: Number button tapped
	func numberKeyTapped(sender:CYRKeyboardButton) {
		UIDevice.currentDevice().playInputClick()
		self.textView?.insertText(sender.input)
		self.textField?.insertText(sender.input)
	}
	
}


public class YZNumberKeyboardViewStyle : NSObject {

	//// Drawing Methods
	
	public class func drawDismissKeyBoardImage() {
		//// Color Declarations
		let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
		
		//// Rectangle 12 Drawing
//		var rectangle12Path = UIBezierPath(roundedRect: CGRectMake(0, 0, 50, 24), byRoundingCorners: UIRectCorner.TopLeft | UIRectCorner.TopRight, cornerRadii: CGSizeMake(2, 2))
//		rectangle12Path.closePath()
		
		let rectangle12Path = UIBezierPath(rect: CGRectMake(0, 0, 50, 24))
		YZNumberKeyboardViewStyle.keyboardBackgroundColor.setFill()
		rectangle12Path.fill()
		
		
		//// Group
		//// Rectangle Drawing
		let rectanglePath = UIBezierPath(roundedRect: CGRectMake(8, 4, 24, 15), cornerRadius: 3)
		color.setStroke()
		rectanglePath.lineWidth = 2
		rectanglePath.stroke()
		
		
		//// Rectangle 2 Drawing
		let rectangle2Path = UIBezierPath(rect: CGRectMake(11, 6.5, 2, 2))
		color.setFill()
		rectangle2Path.fill()
		
		
		//// Rectangle 3 Drawing
		let rectangle3Path = UIBezierPath(rect: CGRectMake(15, 6.5, 2, 2))
		color.setFill()
		rectangle3Path.fill()
		
		
		//// Rectangle 4 Drawing
		let rectangle4Path = UIBezierPath(rect: CGRectMake(19, 6.5, 2, 2))
		color.setFill()
		rectangle4Path.fill()
		
		
		//// Rectangle 5 Drawing
		let rectangle5Path = UIBezierPath(rect: CGRectMake(23, 6.5, 2, 2))
		color.setFill()
		rectangle5Path.fill()
		
		
		//// Rectangle 6 Drawing
		let rectangle6Path = UIBezierPath(rect: CGRectMake(27, 6.5, 2, 2))
		color.setFill()
		rectangle6Path.fill()
		
		
		//// Rectangle 7 Drawing
		let rectangle7Path = UIBezierPath(rect: CGRectMake(25, 10.5, 2, 2))
		color.setFill()
		rectangle7Path.fill()
		
		
		//// Rectangle 8 Drawing
		let rectangle8Path = UIBezierPath(rect: CGRectMake(21, 10.5, 2, 2))
		color.setFill()
		rectangle8Path.fill()
		
		
		//// Rectangle 9 Drawing
		let rectangle9Path = UIBezierPath(rect: CGRectMake(17, 10.5, 2, 2))
		color.setFill()
		rectangle9Path.fill()
		
		
		//// Rectangle 10 Drawing
		let rectangle10Path = UIBezierPath(rect: CGRectMake(13, 10.5, 2, 2))
		color.setFill()
		rectangle10Path.fill()
		
		
		//// Rectangle 11 Drawing
		let rectangle11Path = UIBezierPath(rect: CGRectMake(14, 14.5, 12, 2))
		color.setFill()
		rectangle11Path.fill()
		
		
		
		
		//// Bezier Drawing
		var bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(36, 12))
		bezierPath.addLineToPoint(CGPointMake(38, 12))
		bezierPath.addLineToPoint(CGPointMake(38, 5))
		bezierPath.addLineToPoint(CGPointMake(39, 5))
		bezierPath.addLineToPoint(CGPointMake(39, 12))
		bezierPath.addLineToPoint(CGPointMake(41, 12))
		bezierPath.addLineToPoint(CGPointMake(38.5, 18))
		bezierPath.addLineToPoint(CGPointMake(36, 12))
		bezierPath.closePath()
		color.setFill()
		bezierPath.fill()
	}
	
	//// Generated Images
	
	public class var imageOfDismissKeyBoardImage: UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 24), false, 0)
		YZNumberKeyboardViewStyle.drawDismissKeyBoardImage()
		
		let imageOfDismissKeyBoardImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return imageOfDismissKeyBoardImage
	}
	
	public class var keyboardBackgroundColor: UIColor {
		return UIColor(red:0.784, green:0.800, blue:0.824, alpha:1.000)
	}
	
}
