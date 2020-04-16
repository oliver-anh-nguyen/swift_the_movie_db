//
//  ViewController.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUINavigation()
    }

    // MARK: Setup UI
    private func setupUINavigation() {
        // custom navigation bar
        self.customNavigationBar()
        
        // add logo to navigationbar
        self.createLogoTitleView()
        
        // add profile button to left navigation bar
        self.createLeftBarButton()
        
        // add search button to right navigation bar
        self.createRightBarButton()
    }
    
    private func customNavigationBar() {
        // set background color for navigation bar
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        // create shadow below navigation bar
        self.navigationController?.navigationBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.23).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 20.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 10.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    private func createLogoTitleView() {
        let logo = UIImage(named: image_home_logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    private func createLeftBarButton() {
        let leftBarButton = UIBarButtonItem(image: renderImgOriginal(named: image_home_navi_profile), landscapeImagePhone: nil, style: .done, target: self, action: #selector(profileClicked))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func createRightBarButton() {
        let rightBarButton = UIBarButtonItem(image: renderImgOriginal(named: image_home_navi_search), landscapeImagePhone: nil, style: .done, target: self, action: #selector(searchClicked))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func renderImgOriginal(named: String) -> UIImage {
        let imageView = UIImageView(image: UIImage(named: named))
        imageView.image = imageView.image!.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = UIColor.clear
        return imageView.image ?? UIImage()
    }

    // MARK: Action button
    @objc private func profileClicked() {
    }
    
    @objc private func searchClicked() {
    }
    
    
}

