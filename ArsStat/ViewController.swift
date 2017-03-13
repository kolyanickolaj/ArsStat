
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    private var indexPlayer = 0
    private var indexCompetition = 0
    private var indexSeason = 0
    
    @IBOutlet weak var textPlayerPicker: UITextField!
    @IBOutlet weak var textCompetitionPicker: UITextField!
    @IBOutlet weak var textSeasonPicker: UITextField!
        
    private var playerPicker = UIPickerView()
    private var competitionPicker = UIPickerView()
    private var seasonPicker = UIPickerView()
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    private let teamPlayers = ["Alexis Sanchez":"sr:player:34120", "Olivier Giroud":"sr:player:39070", "Danny Welbeck":"sr:player:33902", "Theo Walcott":"sr:player:10501", "Lucas Perez":"sr:player:107128", "Alex Iwobi":"sr:player:352770", "Aaron Ramsey":"sr:player:23571", "Mesut Ozil":"sr:player:16176", "Santi Cazorla":"sr:player:17651", "Alex Oxlade-Chamberlain":"sr:player:10577", "Granit Xhaka":"sr:player:117777", "Francis Coquelin":"sr:player:40672", "Mohamed Elneny":"sr:player:159675", "Jeff Reine-Adelaide":"sr:player:819262", "Laurent Koscielny":"sr:player:51340", "Shkodran Mustafi":"sr:player:89894", "Hector Bellerin":"sr:player:188365", "Nacho Monreal":"sr:player:17088", "Kieran Gibbs":"sr:player:24814", "Mathieu Debuchy":"sr:player:3579", "Gabriel":"sr:player:124737", "Carl Jenkinson":"sr:player:137844", "Per Mertesacker":"sr:player:369", "Rob Holding":"sr:player:821198", "Petr Cech":"sr:player:1185", "David Ospina":"sr:player:33596", "Emiliano Martinez":"sr:player:158263"]
    
    private let teamTournaments = ["Premier League", "Champions League", "FA Cup", "EFL Cup"]
    private let seasons = ["2016-2017", "2015-2016"]
    
    let tournaments = ["Premier League2016-2017":"sr:season:32887", "Champions League2016-2017":"sr:season:33051", "FA Cup2016-2017":"sr:season:35800", "EFL Cup2016-2017":"sr:season:33095", "Premier League2015-2016":"sr:season:10412", "Champions League2015-2016":"sr:season:10484", "FA Cup2015-2016":"sr:season:11904", "EFL Cup2015-2016":"sr:season:10404"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerPicker.dataSource = self
        playerPicker.delegate = self
        textPlayerPicker.inputView = playerPicker
        textPlayerPicker.text = "Player"
        
        competitionPicker.dataSource = self
        competitionPicker.delegate = self
        textCompetitionPicker.inputView = competitionPicker
        textCompetitionPicker.text = "Tournament"

        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        textSeasonPicker.inputView = seasonPicker
        textSeasonPicker.text = "Season"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        goButton.layer.borderWidth = 1
        goButton.layer.borderColor = UIColor.white.cgColor
        goButton.layer.cornerRadius = 10
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numOfRows = 0
        let names = [String](teamPlayers.keys)
        if pickerView == playerPicker {
            numOfRows = names.count
        } else if pickerView == competitionPicker {
            numOfRows = teamTournaments.count
        } else if pickerView == seasonPicker {
            numOfRows = seasons.count
        }
        return numOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titForRow = ""
        let names = [String](teamPlayers.keys)
        if pickerView == playerPicker {
            titForRow = names[row]
        } else if pickerView == competitionPicker {
            titForRow = teamTournaments[row]
        } else if pickerView == seasonPicker {
            titForRow = seasons[row]
        }
        return titForRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let names = [String](teamPlayers.keys)
        if pickerView == playerPicker {
            indexPlayer = row
            textPlayerPicker.text = names[indexPlayer]
        } else if pickerView == competitionPicker {
            indexCompetition = row
            textCompetitionPicker.text = teamTournaments[indexCompetition]
        } else if pickerView == seasonPicker {
            indexSeason = row
            textSeasonPicker.text = seasons[indexSeason]
        }
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let names = [String](teamPlayers.keys)
        let resultDestination = segue.destination as? ResultViewController
        resultDestination?.imageName = names[indexPlayer]
        if let playerID = teamPlayers[names[indexPlayer]] {
            resultDestination?.playerID = playerID
        }
        if let tournamentID = tournaments[teamTournaments[indexCompetition]+seasons[indexSeason]] {
            resultDestination?.tournamentID = tournamentID
        }
        
        }
    


}










