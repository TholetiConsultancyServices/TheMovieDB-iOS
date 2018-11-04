//
//  UserAlert.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func present(withTitle title: String, description: String? = nil, from: UIViewController) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissAction)
        from.present(alert, animated: true, completion: nil)
    }
    
}
