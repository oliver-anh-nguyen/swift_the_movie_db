//
//  ViewController.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct HomeSection {
    static let recommendation = 0
    static let category = 1
    static let popular = 2
    static let toprated = 3
    static let upcoming = 4
}

let fullWidth: CGFloat = UIScreen.main.bounds.size.width

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUINavigation()
        self.setupLayoutCollectionView()
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
        self.navigationController?.navigationBar.layer.shadowRadius = 20.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.6
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
    
    private func setupLayoutCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(HomeRecommendCollectionCell.self, self.collectionView)
        self.collectionView.register(HomeCategoryCollectionCell.self, self.collectionView)
        self.collectionView.register(HomeFilmCollectionCell.self, self.collectionView)
        self.collectionView.registerHeader(HomeHeaderSection.self, self.collectionView)
    }
    
    //MARK: Util function
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == HomeSection.recommendation {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeRecommendCollectionCell.self), for: indexPath) as? HomeRecommendCollectionCell else {
                fatalError()
            }
            return cell
        }
        if indexPath.section == HomeSection.category {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCategoryCollectionCell.self), for: indexPath) as? HomeCategoryCollectionCell else {
                fatalError()
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeFilmCollectionCell.self), for: indexPath) as? HomeFilmCollectionCell else {
            fatalError()
        }
        if indexPath.section == HomeSection.popular {
        }
        if indexPath.section == HomeSection.toprated {
        }
        if indexPath.section == HomeSection.upcoming {
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier:String(describing: HomeHeaderSection.self),
                                                                         for: indexPath) as! HomeHeaderSection
        headerView.backgroundColor = .white
        if indexPath.section == HomeSection.recommendation {
            headerView.title.font = UIFont(name: font_helvetica, size: 20)
            headerView.title.text = str_home_section_recommend
            headerView.moreButton = {
                print("see full recommendation list")
            }
        }
        if indexPath.section == HomeSection.category {
            headerView.title.text = str_home_section_category
            headerView.moreButton = {
                print("see full category list")
            }
        }
        if indexPath.section == HomeSection.popular {
            headerView.title.text = str_home_section_popular
            headerView.moreButton = {
                print("see full popular list")
            }
        }
        if indexPath.section == HomeSection.toprated {
            headerView.title.text = str_home_section_toprated
            headerView.moreButton = {
                print("see full top rated list")
            }
        }
        if indexPath.section == HomeSection.upcoming {
            headerView.title.text = str_home_section_upcoming
            headerView.moreButton = {
                print("see full upcoming list")
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == HomeSection.recommendation {
            return CGSize(width: fullWidth, height: 50)
        }
        if section == HomeSection.category {
            return CGSize(width: fullWidth, height: 30)
        }
        return CGSize(width: fullWidth, height: 30)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == HomeSection.recommendation {
            return CGSize(width: fullWidth, height: 190)
        }
        if indexPath.section == HomeSection.category {
            return CGSize(width: fullWidth, height: 106)
        }
        return CGSize(width: fullWidth, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
