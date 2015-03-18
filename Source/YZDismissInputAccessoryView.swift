//
//  YZDismissInputAccessoryView.swift
//  NumberKeyboardViewDemo
//
//  Created by Yichi on 12/03/2015.
//  Copyright (c) 2015 Yichi. All rights reserved.
//

import Foundation

class YZDismissInputAccessoryView : UIView, UIInputViewAudioFeedback {
	
	weak var textField:UITextField?
	weak var textView:UITextView?
	
	lazy var dismissTouchArea:UIView = {
		let v = UIImageView(image: YZKeyboardStyle.imageOfArrowLight)
		v.contentMode = UIViewContentMode.Center
		v.backgroundColor = UIColor(red:0.684, green:0.700, blue:0.724, alpha:1.000)
		v.userInteractionEnabled = true
		return v
		}()
	
	var dismissTouchAreaHeight:CGFloat = 9
	
	var keyboardBackgroundColor:UIColor {
		return UIColor(red:0.784, green:0.800, blue:0.824, alpha:1.000)
	}
	
	// MARK: UIInputViewAudioFeedback
	var enableInputClicksWhenVisible:Bool {
		return true
	}
	
	// MARK: Attach to a text input.
	func attachTo(#textInput:UITextInput) {
		textField = nil
		textView = nil
		if(textInput.isKindOfClass(UITextField)) {
			var t = textInput as UITextField
			t.inputAccessoryView = self
			textField = t
		}
		else if(textInput.isKindOfClass(UITextView)) {
			var t = textInput as UITextView
			t.inputAccessoryView = self
			textView = t
		}
	}
	
	// MARK: Init methods
	override init() {
		super.init(frame:CGRect(
			origin: CGPointZero,
			size: CGSize(width: 320, height: dismissTouchAreaHeight)
			)
		)
		
		backgroundColor = keyboardBackgroundColor
		
		dismissTouchArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dissmissButtonTapped:"))
		addSubview(dismissTouchArea)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: Set up layout
	override func layoutSubviews() {
		superview?.layoutSubviews()
		
		dismissTouchArea.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: dismissTouchAreaHeight
		)
	}
	
	func configureHeightConstraint() {
		if let viewConstraints = constraints() as? [NSLayoutConstraint] {
			if let constraint = viewConstraints.first {
				constraint.constant = self.dismissTouchAreaHeight
			}
		}
	}
	
	// MARK: Dissmiss button tapped.
	func dissmissButtonTapped(sender:AnyObject) {
		textField?.resignFirstResponder()
		textView?.resignFirstResponder()
	}
}