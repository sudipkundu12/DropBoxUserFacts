//
//  SceneDelegate.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            self.window?.makeKeyAndVisible()
            window?.rootViewController = UINavigationController(rootViewController: FactsListTableViewController())
            (UIApplication.shared.delegate as? AppDelegate)?.self.window = window
            }
    }
}
