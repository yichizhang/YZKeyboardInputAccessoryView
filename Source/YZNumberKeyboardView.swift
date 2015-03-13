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
	lazy var dismissTouchArea:UIView = {
		let v = UIImageView(image: YZNumberKeyboardViewStyle.imageOfArrowLight)
		v.contentMode = UIViewContentMode.Center
		v.backgroundColor = UIColor(red:0.684, green:0.700, blue:0.724, alpha:1.000)
		v.userInteractionEnabled = true
		return v
	}()
	var dismissTouchAreaHeight:CGFloat = 12
	var numberKeyButtonsContainerOriginY:CGFloat = 12
	var keyboardBackgroundColor:UIColor {
		return UIColor(red:0.784, green:0.800, blue:0.824, alpha:1.000)
	}
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
		
		// dissmissButton.addTarget(self, action: "dissmissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
		// addSubview(dissmissButton)
		
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
		
		/*
		self.dissmissButton.sizeToFit()
		let dissmissButtonSize = self.dissmissButton.bounds.size
		self.dissmissButton.frame = CGRect(
			x: bounds.width - dissmissButtonSize.width,
			y: 0,
			width: dissmissButtonSize.width,
			height: dissmissButtonSize.height
		)
		*/
		
		dismissTouchArea.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: dismissTouchAreaHeight
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
