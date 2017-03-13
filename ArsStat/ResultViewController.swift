
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName: String!
    var playerID:String!
    var tournamentID:String!
    
    let parameters = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    var results = ["a", "b", "c", "d", "e"]
    
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
//        cell.resultLabel.text = results[indexPath.row]
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
        //results = [String(statData.matchesPlayed!), String(statData.goals!), String(statData.assists!), String(statData.yellowCards!), String(statData.redCards!)]
        heightValueLabel.text = String(statData.height!)
        weightValueLabel.text = String(statData.weight!)
        let cell = statTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? ShowTableViewCell
        cell?.resultLabel.text = String(statData.matchesPlayed!)
        
    }

    
    
    
    
    

}
