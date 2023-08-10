//
//  TabBarController.swift
//  NewsApp
//
//  Created by Алексей Лосев on 10.08.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setupTabBarController()
        self.setupTabs()
    }
    
    private func setupTabs() {
        let news = self.createNav(with: "News", and: UIImage(systemName: "newspaper"), viewController: NewsViewController())
        
        let favourites = self.createNav(with: "Favourites", and: UIImage(systemName: "heart"), viewController: FavouritesViewController())
        
        self.setViewControllers([news, favourites], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationController?.title = title
        
        return nav
    }
    
    private func setupTabBarController() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Был выбран контроллер - \(viewController.title ?? "")")
        return true
    }
    
}
