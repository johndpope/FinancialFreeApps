//
//  ChartTableViewCell.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 23..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    var appLink: URL?

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var installButton: UIButton!
    @IBAction func didTapInstall(_ sender: Any) {
        if let url = self.appLink {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        appIcon.layer.cornerRadius = 12
        appIcon.layer.borderWidth = 1
        appIcon.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5).cgColor
        appIcon.clipsToBounds = true
        
        installButton.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
