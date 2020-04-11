//
//  TableViewCellDetailsTableViewCell.swift
//  checkListNoBreaks
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

class TableViewCellDetails: UITableViewCell, UpdateLabelTextDelegate {
    
    
    @IBOutlet weak var recieveTitleLabel: UILabel!
    
    @IBOutlet weak var recieveTitleEDIT: UILabel!
    @IBOutlet weak var recieveDateLabel: UILabel!
    @IBOutlet weak var recieveDateEDIT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func updateLabelText(withText text: String) {
        recieveTitleLabel.text = text
        recieveTitleEDIT.text = text
        recieveDateLabel.text = text
        recieveDateEDIT.text = text

        
        
    }
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//     { todoItems[indexPath.row].title = update
//    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
