//
//  TableViewCell.swift
//  ITunes
//
//  Created by Карим Садыков on 21.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseId = "cell"
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(track: Track) {

        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        collectionNameLabel.text = track.collectionName
        
        guard let url = URL(string: track.artworkUrl60 ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
}
