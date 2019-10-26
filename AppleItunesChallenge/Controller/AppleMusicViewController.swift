//
//  ViewController.swift
//  AppleItunesChallenge
//
//  Created by Kinney Kare on 10/19/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import UIKit
//import SDWebImage

class AppleMusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    @IBOutlet weak var myTableView: UITableView!
    
    var dataFromAppleStore = [TheResults]() {
        
        didSet {
            DispatchQueue.main.async {
            self.myTableView.reloadData()
            self.navigationItem.title = "New Releases"
           }
        }
    }
    
    override func viewDidLoad() {
       myTableView.delegate = self
       myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 159
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromAppleStore.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appleStorecell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath) as? AppleMusicTableViewCell else {
            print("Not working")
            return UITableViewCell() //This will return an empty tableViewCell if no data is found.
        }
        
        let results = dataFromAppleStore[indexPath.row]
        //let stringWithURL = results.artworkUrl100
//        let newImage = appleStorecell.appleStoreArtWorkImage.sd_setImage(with: URL(string: stringWithURL), placeholderImage: UIImage(named: "AppleLogo"))
        
        appleStorecell.albumNameLabel.text = results.name
        appleStorecell.artistNameLabel.text = results.artistName
        appleStorecell.releaseDateLabel.text = results.releaseDate
//        appleStorecell.appleStoreArtWorkImage.image = newImage
        return appleStorecell
    }

    @IBAction func loadDataButtonTapped(_ sender: Any) {
        
        let itunesRequest = ItunesRequest()
        itunesRequest.getAppleMusicData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let theData):
                self?.dataFromAppleStore = theData
            }
        }        
    }
}



