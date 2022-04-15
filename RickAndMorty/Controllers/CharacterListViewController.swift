//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import UIKit

class CharacterListViewController: UITableViewController {

    private var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.fetchCharactersPage(from: K.fetchAllCharactersAPI) { character in
            self.character = character
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character?.results.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        
        cell.configure(with: character?.results[indexPath.row])
        
//        ImageManager.shared.fetchImage(from: currentCharacter?.image) { imageData in
//            cell.avatarImageView.image = UIImage(data: imageData!)
//        }
//
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let currentCharacter = character?.results[indexPath.row]
//        showCharacterInfo(characterInfo: currentCharacter)
        let characterId = character?.results[indexPath.row].id
        showCharacterInfo(characterId: characterId ?? -1)
    }

     // MARK: - Navigation

//    func showCharacterInfo(characterInfo: Result?) {
//        if let characterInfo = characterInfo {
//            let controller = storyboard?.instantiateViewController(withIdentifier: K.detailVCIndentifier) as! CharacterDetailViewController
//            controller.characterInfo = characterInfo
//            navigationController?.pushViewController(controller, animated: true)
//        }
//    }
    
    func showCharacterInfo(characterId: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: K.detailVCIndentifier) as! CharacterDetailViewController
        controller.characterId = characterId
        navigationController?.pushViewController(controller, animated: true)
    }

}
