//
//  CharacterDetailV2ViewController.swift
//  RickAndMorty
//
//  Created by Ilya on 15.04.2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var characterId = -1
    var numberOfEpisodes = 0
    var characterInfo: Result? {
        didSet {
            setImage()
            setName()
//            if let characterInfo = characterInfo {
//                ImageManager.shared.fetchImage(from: characterInfo.image) { imageData in
//                    self.imageView.image = UIImage(data: imageData)
//                }
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //nameLabel.text = characterInfo.name
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        if characterId != -1 {
        
            NetworkManager.shared.fetchCharacterDetails(from: K.fetchCharacterDetailAPI.replacingOccurrences(of: "$", with: String(characterId))) { characterInfo in
                self.characterInfo = characterInfo
                self.numberOfEpisodes = characterInfo.episode.count
                self.tableView.reloadData()
            }
        
        }
            
        //setImage()
        
    }
    
    func setImage() {
        
//        let imageData = ImageManager.shared.fetchImage(from: characterInfo.image)
//        if let imageData = imageData {
//            imageView.image = UIImage(data: imageData)
//        }
        
        if let characterInfo = characterInfo {
            ImageManager.shared.fetchImage(from: characterInfo.image) { imageData in
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func setName() {
        nameLabel.text = characterInfo?.name
    }
    
}

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.detailCellIdentifier, for: indexPath)
        
        var cellText = ""
        
        switch indexPath.section {
        case 0: cellText = characterInfo?.status ?? ""
        case 1: cellText = characterInfo?.gender ?? ""
        case 2: cellText = characterInfo?.species ?? ""
        case 3: cellText = characterInfo?.location.name ?? ""
        case 4: cellText = numberOfEpisodes > 0 ? String(numberOfEpisodes) : ""
        default: cellText = ""
        }
        
        if #available(iOS 14.0, *) {
            var cellConfiguration = cell.defaultContentConfiguration()
            cellConfiguration.text = cellText
            cell.contentConfiguration = cellConfiguration
        } else {
            cell.textLabel?.text = cellText
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Status"
        case 1: return "Gender"
        case 2: return "Species"
        case 3: return "Location"
        case 4: return "Number of episodes"
        default: return nil
        }
        
    }
    
}
