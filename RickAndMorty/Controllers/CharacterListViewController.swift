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
        fetchCharactersPage()
    }

    func fetchCharactersPage() {
        NetworkManager.shared.fetchData(
            urlString: K.fetchAllCharactersAPI,
            expecting: Character.self
        ) { [weak self] callResult in
            switch callResult {
            case .success(let character):
                DispatchQueue.main.async {
                    self?.character = character
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character?.results.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        cell.configure(with: character?.results[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = character?.results[indexPath.row].id
        showCharacterInfo(characterId: characterId ?? -1)
    }

     // MARK: - Navigation
    
    func showCharacterInfo(characterId: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: K.detailVCIndentifier) as! CharacterDetailViewController
        controller.characterId = characterId
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
