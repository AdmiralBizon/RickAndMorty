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
    var character: Character? {
        didSet {
            setImage()
            setName()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        if characterId != -1 {
            fetchCharacterInfo()
        }
        
    }
    
    func fetchCharacterInfo() {
        
        let urlString = K.characterDetailsAPI.replacingOccurrences(of: "$", with: String(characterId))
        
        NetworkManager.shared.fetchData(
            urlString: urlString,
            expecting: Character.self
        ) { [weak self] callResult in
            switch callResult {
            case .success(let character):
                self?.character = character
                self?.numberOfEpisodes = character.episode.count
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func setImage() {
        
        if let character = character {
            ImageManager.shared.fetchImage(from: character.image) { imageData in
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func setName() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.character?.name
        }
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
        case 0: cellText = character?.status ?? ""
        case 1: cellText = character?.gender ?? ""
        case 2: cellText = character?.species ?? ""
        case 3: cellText = character?.location.name ?? ""
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
