//
//  GalleryViewController.swift
//  PhotoGalleryFLickr
//
//  Created by Сергей Кудинов on 12.10.2022.
//

import UIKit

private let reuseIdentifier = "Cell"


class GalleryViewController: UICollectionViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    let topPhotoURL = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=66a0f6ff3a7a99df07e946a5728ecaa6&format=json&nojsoncallback=1&extras=url_s"
    let urlForSearch = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=66a0f6ff3a7a99df07e946a5728ecaa6&format=json&nojsoncallback=1&extras=url_s&text="
    
    var results: TopPhotos?
    var itemsInCollection = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self

        getJson(url: topPhotoURL, completion: { data in
            DispatchQueue.main.async {
                self.results = data
                self.itemsInCollection = data.photos?.photo?.count ?? 0
                self.collectionView.reloadData()
            }
        })
        
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInCollection
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell

        if results != nil {
            getImage(url: results?.photos?.photo?[indexPath.item].urlS ?? "") { image in
                cell.imageOutlet.image = image
            }
        }
        return cell
    }
}
