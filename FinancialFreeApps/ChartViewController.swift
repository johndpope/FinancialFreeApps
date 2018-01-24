//
//  MasterViewController.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 22..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChartViewController: UITableViewController, Loggable {

    var viewModel: ChartViewModel? {
        didSet {
            logd(debugMessage: "viewModel didSet")
            viewModel?.didModelUpdated = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView?.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var detailViewController: DetailViewController? = nil

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defer { self.viewModel = AppModelList() }
        logd(debugMessage: "ChartView init ends")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let app = viewModel?.app(forRow: indexPath.row)
                let view = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                view.detailItem = app
                view.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                view.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfApps() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChartTableViewCell {

            if let app = viewModel?.app(forRow: indexPath.row) {
                cell.rank.text = String(indexPath.row + 1)
                cell.appName.text = app.name
                cell.appIcon.setImage(from: app.iconUrl, placeHolder: "AppIconPlaceHolder")
                cell.appLink = app.link
            }
            
            return cell
        }
        return UITableViewCell()
    }

    

}

