//
//  DetailViewController.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 22..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import UIKit
import SwiftyJSON

class AppDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var viewModel: AppDetailViewModel? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detailItem = viewModel?.detail {
            DispatchQueue.main.async {
                self.title = detailItem["trackName"].string
                self.detailDescriptionLabel.text = detailItem["description"].string
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}

