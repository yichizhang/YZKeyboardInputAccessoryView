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
	weak var textInput:UITextInput?
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
		view.textInput = textInput
		
		if(textInput.isKindOfClass(UITextField)) {
			var t = textInput as UITextField;
			t.inputAccessoryView = view
		}
		else if(textInput.isKindOfClass(UITextView)) {
			var t = textInput as UITextView;
			t.inputAccessoryView = view
		}
	}
	
	func commonInit() {
		self.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
		self.backgroundColor = UIColor.blueColor()
		
		self.addSubview(self.dissmissButton)
	}
	
	override init() {
		super.init()
		commonInit()
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
			y: -size.height,
			width: size.width,
			height: size.height
		)
	}
	
}