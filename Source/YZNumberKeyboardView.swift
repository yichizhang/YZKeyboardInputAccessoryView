//
//  YZNumberKeyboardView.swift
//  NumberKeyboardViewDemo
//
//  Created by Yichi on 12/03/2015.
//  Copyright (c) 2015 Yichi. All rights reserved.
//

import Foundation
import UIKit

struct YZKeyboardConstants {
	init(width:CGFloat) {
 
		spaceInBetweenKeys = 6
		var topInset:CGFloat = 0
		var sideInset:CGFloat = 0
		
		if width == 320 {
			// iPhone 5 or older
			spaceInBetweenRows = 15
			keyHeight = 39
			
			topInset = 12
			sideInset = 3
			
		} else if width == 375 {
			// iPhone 6
			spaceInBetweenRows = 11
			keyHeight = 43
			
			topInset = 10
			sideInset = 3
			
		} else if width > 375 {
			// iPhone 6 Plus or larger
			spaceInBetweenRows = 10
			keyHeight = 46
			
			topInset = 8
			sideInset = 4
			
		}
		
		keyboardInset = UIEdgeInsets(top: topInset, left: sideInset, bottom: sideInset, right: sideInset)
		
		let keyCount:CGFloat = 10
		keyWidth =
			(
				(width - keyboardInset.left - keyboardInset.right) - ( (keyCount - 1) * spaceInBetweenKeys )
			) / keyCount
		
	}
	var spaceInBetweenKeys:CGFloat = 0
	var keyboardInset = UIEdgeInsetsZero
	var spaceInBetweenRows:CGFloat = 0
	var keyHeight:CGFloat = 0
	var keyWidth:CGFloat = 0
}

class YZNumberKeyboardView : UIView, UIInputViewAudioFeedback {
	
	weak var textField:UITextField?
	weak var textView:UITextView?
	
	var numberKeyButtons:[CYRKeyboardButton] = Array()
	var numberKeyButtonsContainerView = UIView()
	
	let keyboardConstants = YZKeyboardConstants(width: UIScreen.mainScreen().bounds.width)
	
	var heightOfView:CGFloat {
		let c = self.keyboardConstants
		return
			(c.spaceInBetweenRows - c.keyboardInset.top) + c.keyHeight + c.keyboardInset.top + self.dismissTouchAreaHeight
	}
	
	lazy var dismissTouchArea:UIView = {
		let v = UIImageView(image: YZNumberKeyboardViewStyle.imageOfArrowLight)
		v.contentMode = UIViewContentMode.Center
		v.backgroundColor = UIColor(red:0.684, green:0.700, blue:0.724, alpha:1.000)
		v.userInteractionEnabled = true
		return v
	}()
	var dismissTouchAreaHeight:CGFloat = 12
	
	var keyboardBackgroundColor:UIColor {
		return UIColor(red:0.784, green:0.800, blue:0.824, alpha:1.000)
	}
	
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
			height: heightOfView
		)
		backgroundColor = keyboardBackgroundColor
		//UIColor.clearColor()
		
		addSubview(numberKeyButtonsContainerView)
		numberKeyButtonsContainerView.backgroundColor = keyboardBackgroundColor
		for i in 1...10 {
			let key = "\(i%10)"
			let b = CYRKeyboardButton()
			b.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
			b.addTarget(self, action: "numberKeyTapped:", forControlEvents: .TouchUpInside)
			b.input = key
			
			numberKeyButtons.append(b)
			numberKeyButtonsContainerView.addSubview(b)
		}
		
		dismissTouchArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dissmissButtonTapped:"))
		addSubview(dismissTouchArea)
		
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
		
		dismissTouchArea.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: dismissTouchAreaHeight
		)
		
		let keyCount = CGFloat(numberKeyButtons.count)
		
		let c = keyboardConstants
		let inset = c.keyboardInset
		
		numberKeyButtonsContainerView.frame = CGRect(
			x: inset.left,
			y: dismissTouchAreaHeight + inset.top,
			width: bounds.width - inset.left - inset.right,
			height: c.keyHeight
		)
		
		for (index, keyButton) in enumerate(numberKeyButtons) {
			let i = CGFloat(index)
			keyButton.frame = CGRect(
				x: (c.spaceInBetweenKeys + c.keyWidth) * i,
				y: 0,
				width: c.keyWidth,
				height: c.keyHeight
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
