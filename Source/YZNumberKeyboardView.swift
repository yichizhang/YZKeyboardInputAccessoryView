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
	
	override init() {
		super.init()
		
		self.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
		self.backgroundColor = UIColor.blueColor()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
		self.backgroundColor = UIColor.blueColor()
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}