//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Алексей Лосев on 10.08.2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
