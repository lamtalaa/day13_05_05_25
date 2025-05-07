//
//  ResultsTableViewCell.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/6/25.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var firstURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
