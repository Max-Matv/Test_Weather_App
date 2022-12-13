//
//  SceneDelegate.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 6.12.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let cityVc = CityListViewController()
        cityVc.viewModel = CityListViewModel(viewController: cityVc)
        window.rootViewController = cityVc
        window.makeKeyAndVisible()
        self.window = window
    }

}

