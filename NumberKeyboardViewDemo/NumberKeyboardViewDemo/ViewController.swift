//
//  ViewController.swift
//  NumberKeyboardViewDemo
//
//  Created by Yichi on 10/03/2015.
//  Copyright (c) 2015 Yichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!
	var numberKeyboardView = YZNumberKeyboardView()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		view.backgroundColor = UIColor.darkGrayColor()
		textField.autocorrectionType = .No
		numberKeyboardView.attachTo(textInput: textField)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

