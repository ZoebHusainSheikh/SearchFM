//
//  SearchTableViewCell.swift
//  SearchFM
//
//  Created by mymac on 29/08/20.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var recordImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(by record: Record) {
        titleLabel.text = record.name
        subtitleLabel.isHidden = true
        if let url: URL = record.displayImageURL {
            recordImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
        }
    }
}
