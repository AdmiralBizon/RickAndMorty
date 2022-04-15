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
    
    var CharacterInfo: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.title = CharacterInfo.name
        
        nameLabel.text = CharacterInfo.name
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        
        
        setImage()
        
    }
    
    func setImage() {
        
        let imageData = ImageManager.shared.fetchImage(from: CharacterInfo.image)
        if let imageData = imageData {
            imageView.image = UIImage(data: imageData)
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
        case 0: cellText = CharacterInfo.status
        case 1: cellText = CharacterInfo.gender
        case 2: cellText = CharacterInfo.species
        case 3: cellText = CharacterInfo.location.name
        case 4: cellText = String(CharacterInfo.episode.count)
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
