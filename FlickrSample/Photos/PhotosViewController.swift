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

class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var photos = [PhotoData.Photo]()
    
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
        
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
        
        
        if let url = url {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Error retrieving photos from Flickr", err)
                }
                
                
                guard let jsonData = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let photoData = try decoder.decode(PhotoData.self, from: jsonData)
                    self.photos = photoData.photos
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()

                    }
                    
                } catch let err {
                    print("Error decoding episodes from JSON", err)
                }
                }.resume()
        }
        
        
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        let photo = photos[indexPath.row]
        
       cell.photo = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 // username userProfileImageView
        height += view.frame.width
        height += 60
        
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
