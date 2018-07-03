//
//  PhotosViewController.swift
//  FlickrSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"
private let headerReuseIdentifier = "HeaderCell"

class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos = [PhotoData.Photo]()
    var tagFilteredPhotos = [PhotoData.Photo]()
    var searchActive = false
    
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Tags"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = .darkGreen
        s.barStyle = .default
        s.sizeToFit()
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)

        
        navigationItem.title = "Flickr Photos"
        
        view.backgroundColor = .darkGreen
        
        collectionView?.backgroundColor = .darkGreen
        
        queryPhotos()
        
    }
    
    private func queryPhotos() {
        
        
        
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else { return }
            
        let session = URLSession(configuration: .default)
            let apiClient = APIClient(session: session)
            
            apiClient.get(url: url) { (data, error) in
                if let err = error {
                    print("Error retrieving photos from Flickr", err)
                }
                
                
                guard let jsonData = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let photoData = try decoder.decode(PhotoData.self, from: jsonData)
                    self.photos = photoData.photos
                    self.photos.sort(by: { (p1, p2) -> Bool in
                        return p1.published?.compare(p2.published ?? "") == .orderedDescending
                    })
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        
                    }
                    
                } catch let err {
                    print("Error decoding episodes from JSON", err)
                }
            }
            
        
        
    }



    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBar.text?.isEmpty == true {
        return photos.count
        } else {
            return tagFilteredPhotos.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        if searchBar.text?.isEmpty == true {
        
        let photo = photos[indexPath.row]
        cell.photo = photo
        } else {
            let photo = tagFilteredPhotos[indexPath.row]
            cell.photo = photo
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 + 60
        height += view.frame.width
        
        // TO DO: This doesn't work yet
        
//        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
        
        
//        if cell.userAuthorized {
            height += 50
//        }
//        }

        return CGSize(width: view.frame.width-16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
    

}
