//
//  DetailVideoCollectionCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class DetailVideoCollectionCell: BaseCollectionCell {
    
    var arrVideos = [MovieVideo]()
    
    override func sizeCollection() -> CGSize {
        return size_detail_video
    }
    
    override func registerCell() {
        self.collectionView.register(DetailVideoViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension DetailVideoCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailVideoViewCell.self), for: indexPath) as? DetailVideoViewCell else {
            fatalError()
        }
        cell.configure(viewModel: self.arrVideos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.arrVideos[indexPath.row]
        let player = AVPlayer(url: movie.youtubeURL!)
        let vc = AVPlayerViewController()
        vc.player = player
        UINavigationController.currentActiveNavigationController()?.topViewController?.present(vc, animated: true, completion: {
            vc.player?.play()
        })
    }
    
}

extension DetailVideoCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: marginCell, bottom: 0, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
