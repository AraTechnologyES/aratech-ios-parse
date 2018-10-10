//
//  ViewController.swift
//  Test App
//
//  Created by Nicolás Landa on 7/5/18.
//  Copyright © 2018 AraTech. All rights reserved.
//

import UIKit
import Parse
import ATParse

class ViewController: UIViewController {

	class ParseSubclass: PFObject, PFSubclassing {
		static func parseClassName() -> String {
			return "ParseSubclass"
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let fetchOperation = ATParse.default.fetchObjects(withQuery: PFQuery<ParseSubclass>())
		
		PFConfig.current()[.test]
	}
}

extension PFConfigKeys {
	static let test = PFConfigKey<String>(forKey: "test")
}
