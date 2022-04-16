//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import UIKit

class CharactersListViewController: UITableViewController {

    private var currentCharactersPage: CharactersPage?
    private var charactersList: [Character] = []
    private var isPaginating = false
    private var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        fetchCharactersList(pageURL: K.charactersListBaseAPI)
    }

    func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(didPullToRefresh),
                                            for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        isRefreshing = true
        fetchCharactersList(pageURL: K.charactersListBaseAPI)
    }
    
    func fetchCharactersList(pageURL: String, pagination: Bool = false) {
        NetworkManager.shared.fetchData(
            pagination: pagination,
            urlString: pageURL,
            expecting: CharactersPage.self
        ) { [weak self] callResult in
            
            if self?.isRefreshing == true {
                DispatchQueue.main.async {
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }
            
            if pagination {
                self?.isPaginating = false
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
            }
            
            switch callResult {
            case .success(let currentCharactersPage):
                
                self?.currentCharactersPage = currentCharactersPage
                
                if self?.isRefreshing == true {
                    self?.charactersList = currentCharactersPage.results
                } else {
                    for character in currentCharactersPage.results {
                        if !((self?.charactersList.contains(character))!) {
                            self?.charactersList.append(character)
                        }
                    }
                }
                    
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
            if self?.isRefreshing == true {
                self?.isRefreshing = false
            }
            
        }
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        cell.configure(for: charactersList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = charactersList[indexPath.row].id
        showCharacterInfo(characterId: characterId)
    }

    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if position > contentHeight - scrollView.frame.size.height && !isPaginating && !isRefreshing {
            if let pageURL = currentCharactersPage?.info.next {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = self.createSpinnerFooter()
                }
                isPaginating = true
                fetchCharactersList(pageURL: pageURL, pagination: true)
            }
        }
    }
    
     // MARK: - Navigation
    
    func showCharacterInfo(characterId: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: K.detailViewControllerIndentifier) as! CharacterDetailViewController
        controller.characterId = characterId
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
