//
//  ViewController.swift
//  NumberKeyboardViewDemo
//
//  Created by Yichi on 10/03/2015.
//  Copyright (c) 2015 Yichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var textField1: UITextField!
	@IBOutlet weak var textField2: UITextField!
	@IBOutlet weak var textField3: UITextField!
	
	var numberKeyboardView = YZNumberKeyboardInputAccessoryView()
	var emojiKeyboardView = YZKeyboardInputAccessoryView(keys: "😀 😁 😂 😃 😄 😅 😆 😇".componentsSeparatedByString(" "))

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		view.backgroundColor = UIColor.darkGrayColor()
		
		textField1.delegate = self
		textField2.delegate = self
		textField3.delegate = self
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		if textField == textField1 {
			textField.autocorrectionType = .No
			numberKeyboardView.attachTo(textInput: textField)
		}
		if textField == textField3 {
			textField.autocorrectionType = .No
			emojiKeyboardView.attachTo(textInput: textField)
		}
		return true
	}
}

