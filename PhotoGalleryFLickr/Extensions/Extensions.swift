//
//  Extensions.swift
//  PhotoGalleryFLickr
//
//  Created by Сергей Кудинов on 12.10.2022.
//
import Alamofire
import UIKit

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func getJson(url: String, completion: @escaping (TopPhotos) -> Void) {
        AF.request(url)
            .validate()
            .responseData { data in
                switch data.result {
                    
                case .success(let data):
                    guard let results = try? JSONDecoder().decode(TopPhotos.self, from: data) else { return }
        
                    completion(results)
                    print("------")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url)
            .validate()
            .responseData { imageData in
                switch imageData.result {
                    
                case .success(let data):
                    completion(UIImage(data: data)!)
                case .failure(_):
                    print("error")
                }
            }
    }
}

extension GalleryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != "" {
            let newLink = textField.text!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            getJson(url: urlForSearch + newLink, completion: { data in
                print(data)
                
                DispatchQueue.main.async {
                    self.itemsInCollection = 0
                    self.collectionView.reloadData()
                    self.results = data
                    self.itemsInCollection = data.photos?.photo?.count ?? 0
                    self.collectionView.reloadData()
                }
            })
        } else {
            getJson(url: topPhotoURL, completion: { data in
                print(data)
                
                DispatchQueue.main.async {
                    self.results = data
                    self.itemsInCollection = data.photos?.photo?.count ?? 0
                    self.collectionView.reloadData()
                }
            })
        }
        searchTextField.resignFirstResponder()
        return true
    }
}
