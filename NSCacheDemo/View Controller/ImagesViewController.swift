//
//  ViewController.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/8/23.
//

import UIKit

class ImagesViewController: UIViewController {
    
// MARK: @IBOutlet

    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    var viewModel: ThumbnailViewModel?
    var thumbnailArray: [ThumbnailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ThumbnailViewModel()
        viewModel?.fetchUsersData {
            DispatchQueue.main.async {
                self.thumbnailArray = self.viewModel?.thumbnailArray ?? []
                self.thumbnailCollectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        thumbnailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbnailCell", for: indexPath) as? ThumbnailCollectionViewCell else { return UICollectionViewCell() }
        let thumbnail = thumbnailArray[indexPath.row]
        ImageProvider.shared.fetchImage(stringToImage: thumbnail.thumbnailUrl ?? "") { [weak self] image in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
            }
        }
        return cell
    }
}


// MARK: UICollectionViewCell

class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
}

