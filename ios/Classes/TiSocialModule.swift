//
//  TiSocialModule.swift
//  ti.social
//
//  Created by Your Name
//  Copyright (c) 2024 Your Company. All rights reserved.
//

import UIKit
import TitaniumKit
import Foundation

/**
 
 Titanium Swift Module Requirements
 ---
 
 1. Use the @objc annotation to expose your class to Objective-C (used by the Titanium core)
 2. Use the @objc annotation to expose your method to Objective-C as well.
 3. Method arguments always have the "[Any]" type, specifying a various number of arguments.
 Unwrap them like you would do in Swift, e.g. "guard let arguments = arguments, let message = arguments.first"
 4. You can use any public Titanium API like before, e.g. TiUtils. Remember the type safety of Swift, like Int vs Int32
 and NSString vs. String.
 
 */

@objc(TiSocialModule)
class TiSocialModule: TiModule {
  func moduleGUID() -> String {
    return "2941b716-c044-484f-890c-f815f08c7de8"
  }
  
  override func moduleId() -> String! {
    return "ti.social"
  }

  override func startup() {
    super.startup()
    debugPrint("[DEBUG] \(self) loaded")
  }

  @objc(share:)
  func share(arguments: Array<Any>?) {
        guard let args: [String: Any] = arguments?.first as? [String: Any] else { return }

        let message: String? = args["message"] as? String
        let file: String? = args["file"] as? String

		var items: [Any] = []

		if let message = message {
			items.append(message)
		}

        if let filePath = file {
            let fileURL: URL = URL(fileURLWithPath: filePath)
			items.append(fileURL)
        }

		let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)

		activityViewController.excludedActivityTypes = [UIActivity.ActivityType.mail]

        if var topController = UIApplication.shared.keyWindow?.rootViewController {
			if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = topController.view
                popoverController.sourceRect = CGRect(x: topController.view.bounds.midX, y: topController.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            topController.present(activityViewController, animated: true, completion: nil)
        }
    }
}
