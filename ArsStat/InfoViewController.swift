//
//  InfoViewController.swift
//  ArsStat
//
//  Created by Администратор on 13.02.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBAction func didTapThanks(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
     // navigationItem.rightBarButtonItem = UIBarButtonItem(title:"DONE", style: .done, target: self, action: #selector(done))
    }
    
//    func done (sender: Any?) {
//        dismiss(animated: true, completion: nil)
//    }

}
