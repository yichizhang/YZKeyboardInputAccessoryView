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
	lazy var dissmissButton:UIButton = {
		let b = UIButton.buttonWithType(.Custom) as UIButton
		b.setTitle("Close", forState: .Normal)
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
		self.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
		self.backgroundColor = UIColor.blueColor()
		
		dissmissButton.addTarget(self, action: "dissmissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
		addSubview(dissmissButton)
		
		for i in 1...10 {
			let key = "\(i%10)"
			let b = CYRKeyboardButton()
			b.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
			b.addTarget(self, action: "numberKeyTapped:", forControlEvents: .TouchUpInside)
			b.input = key
			
			numberKeyButtons.append(b)
			addSubview(b)
		}
		
		
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
		let size = self.dissmissButton.bounds.size
		self.dissmissButton.frame = CGRect(
			x: self.bounds.width - size.width,
			y: -size.height*0.5,
			width: size.width,
			height: size.height
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
				height: bounds.height - 2*padding - 10
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