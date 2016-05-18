//
//  Wireframe.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

extension UIStoryboard {

    func instantiateViewControllerWithIdentifier<T where T: UIViewController>(identifier: String) -> T {
        return self.instantiateViewControllerWithIdentifier(identifier) as! T
    }

    func instantiateInitialViewController<T where T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }


}
