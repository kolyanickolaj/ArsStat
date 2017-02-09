//
//  ViewController.swift
//  ArsStat
//
//  Created by Администратор on 31.01.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var GoButton: UIButton!
    
    @IBOutlet weak var InfoButton: UIButton!
    
    @IBOutlet weak var PlayerPicker: UIPickerView!
    
    var names = ["Alexis Sanchez", "Olivier Giroud", "Danny Welbeck", "Theo Walcott", "Lucas Perez", "Alex Iwobi", "Aaron Ramsey", "Mesut Ozil", "Santi Cazorla", "Alex Oxlade-Chamberlain", "Granit Xhaka", "Francis Coquelin", "Mohamed Elneny", "Jeff Reine-Adelaide", "Laurent Koscielny", "Shkodran Mustafi", "Hector Bellerin", "Nacho Monreal", "Kieran Gibbs", "Mathieu Debuchy", "Gabriel", "Carl Jenkinson", "Per Mertesacker", "Rob Holding", "Petr Cech", "David Ospina", "Emiliano Martinez"]
    // func pick
    
//    private func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: String) -> String? {
//                return "\(names[row])"
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return names.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return "\(names[row])"
    }

}

