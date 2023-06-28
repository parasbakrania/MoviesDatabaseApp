//
//  AppDelegate.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    ///Dependency injection container object
    let container: DIC = {
        let container = DIC()
        container.register(type: DataUtilityProtocol.self) { _ in
            return FileUtility()
        }
        container.register(type: ResponseHandlerProtocol.self) { _ in
            return ResponseDecoder(decoder: JSONDecoder())
        }
        container.register(type: MovieResourceProtocol.self) { dic in
            return MovieResource(container: dic)
        }
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

