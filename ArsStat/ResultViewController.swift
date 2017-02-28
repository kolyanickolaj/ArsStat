//
//  ResultViewController.swift
//  ArsStat
//
//  Created by Администратор on 28.02.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName: String!
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var segmentParametr: UISegmentedControl!
    
    @IBAction func didTapBack(_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    var data = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! ShowTableViewCell
        cell.parameterLabel.text = data[indexPath.row]
        cell.selectionStyle = .none
        tableView.rowHeight = (tableView.frame.maxY - tableView.frame.minY) / CGFloat(data.count)
    
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.image = UIImage(named: imageName)
    }

  }
