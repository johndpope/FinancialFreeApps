//
//  MasterViewController.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 22..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChartViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var apps = [AppModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.asyncDataTask(with: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json") { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            if let json = try? JSON(data: data) {
                for item in json["feed"]["entry"].arrayValue {
                    let name = item["im:name"]["label"].string!
                    let iconUrl = item["im:image"].arrayValue[2]["label"].string!
                    let link = item["link"]["attributes"]["href"].string!
                    self?.apps.append(AppModel(name: name, iconUrl: iconUrl, link: link))
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
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
                let app = apps[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = app
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChartTableViewCell {

            let app = apps[indexPath.row]
            cell.rank.text = String(indexPath.row + 1)
            cell.appName.text = app.name
            Network.asyncDataTask(with: app.iconUrl, completionHandler: { (data, response, error) in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    cell.appIcon.image = UIImage(data: data)
                }
            })
            cell.appLink = app.link
            
            return cell
        }
        return UITableViewCell()
    }

    

}

