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
    
    func configure(for character: Character) {
        
        DispatchQueue.main.async {
            self.nameLabel.text = character.name
            self.speciesLabel.text = character.species
            self.genderLabel.text = character.gender
        }
        
        ImageManager.shared.fetchImage(from: character.image) { imageData in
            DispatchQueue.main.async {
                self.avatarImageView.image = UIImage(data: imageData)
            }
        }

    }
}
