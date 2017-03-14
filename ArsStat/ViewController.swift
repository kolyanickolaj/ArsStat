
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
    
    private var teamPlayers = [String:String]()
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
        
        DataDownloader.sharedInstance.fetchPlayers(completion: {(PlayersData) in self.updateUI(PlayersData) } )
    }
    
    func updateUI(_ playersData: PlayersData) {
        teamPlayers = playersData.players
        textPlayerPicker.text = playersData.players.keys.first!
        textCompetitionPicker.text = teamTournaments.first!
        textSeasonPicker.text = seasons.first!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkReachability()
        navigationController?.navigationBar.isHidden = true
        goButton.layer.borderWidth = 1
        goButton.layer.borderColor = UIColor.white.cgColor
        goButton.layer.cornerRadius = 10
    }
    
    func checkReachability(){
        if currentReachabilityStatus == .notReachable {
            let alert = UIAlertController(title: "", message: "Check Internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numOfRows = 0
        if pickerView == playerPicker {
            numOfRows = teamPlayers.count
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
        resultDestination?.imageName = teamPlayers[names[indexPlayer]]
        
        if let playerID = teamPlayers[names[indexPlayer]] {
            resultDestination?.playerID = playerID
        }
        
        if let tournamentID = tournaments[teamTournaments[indexCompetition]+seasons[indexSeason]] {
            resultDestination?.tournamentID = tournamentID
        }
        
    }


}










