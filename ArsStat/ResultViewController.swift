
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName:String!
    var playerID:String!
    var tournamentID:String!
    
    let parameters = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var statTableView: UITableView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    
    @IBAction func didTapBack(_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parameters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! ShowTableViewCell
        cell.parameterLabel.text = parameters[indexPath.row]
        cell.resultLabel.text = "0"
        cell.selectionStyle = .none
        tableView.rowHeight = (tableView.frame.maxY - tableView.frame.minY) / CGFloat(parameters.count)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImage(named: imageName) != nil {
        playerImage.image = UIImage(named: imageName)
        } else { playerImage.image = UIImage(named: "defaultPlayerImage") }
    
        heightLabel.text = "Height:"
        heightValueLabel.text = "0"
        weightLabel.text = "Weight:"
        weightValueLabel.text = "0"
        
        DataDownloader.sharedInstance.fetchData(player: playerID, tournamentID: tournamentID, completion: {(statData) in
            self.updateUI(statData) } )
    }
    
    func updateUI(_ statData: StatData) {
        let results = [String(statData.matchesPlayed!), String(statData.goals!), String(statData.assists!), String(statData.yellowCards!), String(statData.redCards!)]
        if statData.height != nil {
            heightValueLabel.text! = String(statData.height!)
        } else { heightValueLabel.text! = "0" }
        if statData.weight != nil {
            weightValueLabel.text! = String(statData.weight!)
        } else { weightValueLabel.text = "0" }
        
        for item in 0..<results.count {
        let cell = statTableView.cellForRow(at: IndexPath(item: item, section: 0)) as? ShowTableViewCell
        cell?.resultLabel.text = results[item]
        
        }
        
    }

    
    
    
    
    

}
