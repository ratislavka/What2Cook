//
//  SceneDelegate.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 06.12.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .systemOrange
        
        window = UIWindow(windowScene: windowScene)
//        UserDefaultsManager.shared.hasCompletedOnboarding = false
        
        if UserDefaultsManager.shared.hasCompletedOnboarding {
            window?.rootViewController = createTabBarController()
        }
        else {
            let helloVC = HelloVC()
            let navController = UINavigationController(rootViewController: helloVC)
            navController.setNavigationBarHidden(true, animated: false) // Hide nav bar for onboarding
            window?.rootViewController = navController
            
        }

        window?.makeKeyAndVisible()
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homeVC = HomeVC()
        homeVC.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let fridgeVC = FridgeVC()
        fridgeVC.title = "Fridge"
        let fridgeNav = UINavigationController(rootViewController: fridgeVC)
        fridgeNav.tabBarItem = UITabBarItem(title: "Fridge", image: UIImage(systemName: "refrigerator"), tag: 1)

//        let familyVC = FamilyVC()
//        familyVC.title = "Family"
//        let familyNav = UINavigationController(rootViewController: familyVC)
//        familyNav.tabBarItem = UITabBarItem(title: "Family", image: UIImage(systemName: "person.3"), tag: 2)
     
        let helpVC = HelpVC()
        helpVC.title = "Help"
        let HelpNav = UINavigationController(rootViewController: helpVC)
        HelpNav.tabBarItem = UITabBarItem(title: "Help", image: UIImage(systemName: "questionmark.circle"), tag: 3)
     
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 4)
     
//        tabBarController.viewControllers = [homeNav, fridgeNav, familyNav, HelpNav, profileNav]
        tabBarController.viewControllers = [homeNav, fridgeNav, HelpNav, profileNav]
        tabBarController.tabBar.tintColor = .systemOrange
        
        return tabBarController
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

