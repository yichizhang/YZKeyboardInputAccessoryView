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
	init(keyboardSize: CGSize) {
 
		let width = keyboardSize.width
		
		var keyHeight:CGFloat = 0
		
		var topInset:CGFloat = 0
		var sideInset:CGFloat = 0
		
		switch width {
		case 320:
			// iPhone 5 or older
			spaceInBetweenKeys = 6
			spaceInBetweenRows = 15
			keyHeight = 39
			
			topInset = 12
			sideInset = 3
			
		case 375:
			// iPhone 6
			spaceInBetweenKeys = 6
			spaceInBetweenRows = 11
			keyHeight = 43 // = width * 0.115
			
			topInset = 10
			sideInset = 3
			
		case 414:
			// iPhone 6 Plus or larger
			spaceInBetweenKeys = 6
			spaceInBetweenRows = 10
			keyHeight = 46 // = width * 0.111
			
			topInset = 8
			sideInset = 4
			
		case 480:
			// iPhone 4 landscape
			spaceInBetweenKeys = 6
			spaceInBetweenRows = 7
			// keyWidth = 42
			keyHeight = 33
			
			topInset = 5
			sideInset = 3
			
		case 568:
			// iPhone 5 landscape
			spaceInBetweenKeys = 5
			spaceInBetweenRows = 7
			// keyWidth = 51
			keyHeight = 33
			
			topInset = 5
			sideInset = 3
			
		case 667...736:
			// iPhone 6 landscape and iPhone 6 Plus landscape
			spaceInBetweenKeys = 5
			spaceInBetweenRows = 7
			// keyWidth = 48
			keyHeight = 33
			
			topInset = 6
			sideInset = 3
			
		default:
			spaceInBetweenKeys = 6
			spaceInBetweenRows = 15
			keyHeight = 39
			
			topInset = 12
			sideInset = 3
		}
		
		keyboardInset = UIEdgeInsets(top: topInset, left: sideInset, bottom: sideInset, right: sideInset)
		
		let keyCount:CGFloat = 10
		let keyWidth:CGFloat =
			(
				(width - keyboardInset.left - keyboardInset.right) - ( (keyCount - 1) * spaceInBetweenKeys )
			) / keyCount
		
		keySize = CGSize(width: keyWidth, height: keyHeight)
	}
	var spaceInBetweenKeys:CGFloat = 0
	var keyboardInset = UIEdgeInsetsZero
	var spaceInBetweenRows:CGFloat = 0
	var keySize = CGSizeZero
}

class YZNumberKeyboardView : UIView, UIInputViewAudioFeedback {
	
	weak var textField:UITextField?
	weak var textView:UITextView?
	
	var numberKeyButtons:[CYRKeyboardButton] = Array()
	var numberKeyButtonsContainerView = UIView()
	
	var keyboardConstants = YZKeyboardConstants(keyboardSize: CGSizeZero)
	
	var heightOfView:CGFloat {
		let c = self.keyboardConstants
		return (c.spaceInBetweenRows - c.keyboardInset.top) + c.keySize.height + c.keyboardInset.top + self.dismissTouchAreaHeight
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
	
	// MARK: UIInputViewAudioFeedback
	var enableInputClicksWhenVisible:Bool {
		return true
	}
	
	// MARK: Attach to a text input.	
	func attachTo(#textInput:UITextInput) {
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
	func commonInit() {
		backgroundColor = keyboardBackgroundColor
		
		addSubview(numberKeyButtonsContainerView)
		numberKeyButtonsContainerView.backgroundColor = keyboardBackgroundColor
		
		let begin = 1, end = 8
		for i in begin...end{
			let key = "\(i%10)"
			let b = CYRKeyboardButton()
			b.addTarget(self, action: "numberKeyTapped:", forControlEvents: .TouchUpInside)
			b.input = key
			
			numberKeyButtons.append(b)
			numberKeyButtonsContainerView.addSubview(b)
		}
		
		dismissTouchArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dissmissButtonTapped:"))
		addSubview(dismissTouchArea)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
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
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	// MARK: Set up layout
	override func layoutSubviews() {
		superview?.layoutSubviews()
		
		configureSubviewFrames()
	}
	
	func configureSubviewFrames() {
		
		dismissTouchArea.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: dismissTouchAreaHeight
		)
		
		let keyCount = CGFloat(numberKeyButtons.count)
		
		let c = keyboardConstants
		let inset = c.keyboardInset
		
		var lastX:CGFloat = 0
		for (index, keyButton) in enumerate(numberKeyButtons) {
			let i = CGFloat(index)
			let x = (c.spaceInBetweenKeys + c.keySize.width) * i
			keyButton.frame = CGRect(
				origin: CGPoint(x: x, y: 0),
				size: c.keySize
			)
			lastX = x
		}
		
		let keysWidth = lastX + c.keySize.width
		numberKeyButtonsContainerView.frame = CGRect(
			origin: CGPoint(x: bounds.midX - keysWidth / 2, y: dismissTouchAreaHeight + inset.top ),
			size: CGSize(width: keysWidth, height: c.keySize.height)
		)
	}
	
	func configureHeightConstraint() {
		if let viewConstraints = constraints() as? [NSLayoutConstraint] {
			if let constraint = viewConstraints.first {
				constraint.constant = self.heightOfView
			}
		}
	}
	
	// MARK: Keyboard show
	func keyboardWillShow(notification:NSNotification) {
		configureKeyboardConstantsAndViewHeightUsing(notification)
		setNeedsLayout()
	}
	
	func keyboardWillChangeFrame(notification:NSNotification) {
		configureKeyboardConstantsAndViewHeightUsing(notification)
	}
	
	private func configureKeyboardConstantsAndViewHeightUsing(notification:NSNotification) {
		if let info = notification.userInfo {
			if let keyboardSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size {
				keyboardConstants = YZKeyboardConstants(keyboardSize: keyboardSize)
			}
		}
		configureHeightConstraint()
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
