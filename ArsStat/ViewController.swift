//
//  ViewController.swift
//  ArsStat
//
//  Created by Администратор on 31.01.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    private var index = 0
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var playerPicker: UIPickerView!
 
    
    let names = ["Alexis Sanchez", "Olivier Giroud", "Danny Welbeck", "Theo Walcott", "Lucas Perez", "Alex Iwobi", "Aaron Ramsey", "Mesut Ozil", "Santi Cazorla", "Alex Oxlade-Chamberlain", "Granit Xhaka", "Francis Coquelin", "Mohamed Elneny", "Jeff Reine-Adelaide", "Laurent Koscielny", "Shkodran Mustafi", "Hector Bellerin", "Nacho Monreal", "Kieran Gibbs", "Mathieu Debuchy", "Gabriel", "Carl Jenkinson", "Per Mertesacker", "Rob Holding", "Petr Cech", "David Ospina", "Emiliano Martinez"]
    
    let namez = ["Alexis Sanchez", "Olivier Giroud", "Danny Welbeck"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerPicker.dataSource = self
        playerPicker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    override func performSelector(inBackground aSelector: Selector, with arg: Any?) {
        playerPicker.showsSelectionIndicator = true
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return namez.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(namez[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? TableShowViewController
        destination?.imageName = namez[index]
    }
}










