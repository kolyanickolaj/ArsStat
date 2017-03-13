
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName: String!
    var playerID:String!
    var tournamentID:String!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    
    @IBAction func didTapBack(_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    let parameters = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    var results = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parameters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! ShowTableViewCell
        cell.parameterLabel.text = parameters[indexPath.row]
        cell.parameterLabel.text = results[indexPath.row]
        cell.selectionStyle = .none
        tableView.rowHeight = (tableView.frame.maxY - tableView.frame.minY) / CGFloat(parameters.count)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.image = UIImage(named: imageName)
        heightLabel.text = "Height:"
        weightLabel.text = "Weight:"
        DataDownloader.sharedInstance.fetchData(player: playerID, tournamentID: tournamentID, completion: {(statData) in
            self.updateUI(statData) } )

    }
    
    
    func updateUI(_ statData: StatData) {
        results = [String(statData.matchesPlayed!), String(statData.goals!), String(statData.assists!), String(statData.yellowCards!), String(statData.redCards!)]
        heightValueLabel.text = String(statData.height!)
        weightValueLabel.text = String(statData.weight!)
    }

    
    
    
    
    

}
