//
//  TableShowViewController.swift
//  ArsStat
//
//  Created by Администратор on 09.02.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class TableShowViewController: UIViewController {
    
    var imageName: String!

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBAction func didTapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.image = UIImage(named: imageName)
    }

}
