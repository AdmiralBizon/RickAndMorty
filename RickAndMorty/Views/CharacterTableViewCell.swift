//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    func configure(with characterInfo: Result!) {
        
        DispatchQueue.main.async {
            self.nameLabel.text = characterInfo.name
            self.speciesLabel.text = characterInfo.species
            self.genderLabel.text = characterInfo.gender
        }
        
        let imageData = ImageManager.shared.fetchImage(from: characterInfo.image)
        
        if let imageData = imageData {
            DispatchQueue.main.async {
                self.avatarImageView.image = UIImage(data: imageData)
            }
        }

    }
}
