//
//  ViewControllerBase.swift
//  DogsTests
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import XCTest
@testable import Dogs

class ViewControllerBase: XCTestCase {
    func retrieveController(inStoryboard storyboard: String, controllerIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerIdentifier)
        return viewController
    }

    func setup(forViewController viewController: UIViewController) {
        let keyWindow: UIWindow? = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        keyWindow?.rootViewController = viewController
    }
}
