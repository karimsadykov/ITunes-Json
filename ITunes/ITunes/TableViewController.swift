//
//  ViewController.swift
//  ITunes
//
//  Created by Карим Садыков on 20.06.2022.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {

    let networkDataFetcher = NetworkDataFetcher()
    var tracks = [Track]()
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
    private func setup() {

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func fetchTrack(track: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(track)&limit=15"
        
        self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponse) in
            
            guard let searchResponse = searchResponse else { return }
            self.tracks = searchResponse.results
            
            self.tableView.reloadData()
        }
    }
        



// MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        let track = tracks[indexPath.row]
        cell.set(track: track)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
   

}
// MARK: - UISearchBarDelegate
extension TableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchTrack(track: text!)
            })
        }
        
    }
}


