
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName: String!
    var language: String!
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var segmentParametr: UISegmentedControl!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func didTapBack(_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    let engData = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    let rusData = ["Сыграно матчей", "Голы", "Голевые пасы", "Желтые карточки", "Красные карточки"]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return engData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! ShowTableViewCell
        if language == "ENG" {
            cell.parameterLabel.text = engData[indexPath.row]
        } else { cell.parameterLabel.text = rusData[indexPath.row] }
        cell.selectionStyle = .none
        tableView.rowHeight = (tableView.frame.maxY - tableView.frame.minY) / CGFloat(engData.count)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.image = UIImage(named: imageName)
        if language == "ENG" {
            heightLabel.text = "Height:"
            weightLabel.text = "Weight:"
        } else {
            heightLabel.text = "Рост:"
            weightLabel.text = "Вес:"
        }
    }
    
    func loadStatDataAndUpdateUI() {
        let player = "sr:player:1053"
        DataDownloader.sharedInstance.fetchData(player: player, completion: {(statData) in
            self.updateUI(statData) } )
    }
    
    func updateUI(_ statData: StatData) {
        heightLabel.text = String(describing: statData.height)
        weightLabel.text = String(describing: statData.weight)
    }

    
    
    
    
    

}
