
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
    @IBAction func checkInternetConnection(_ sender: UIButton) {
        checkReachability()
    }
    
    private var teamPlayers = ["Alexis Sanches":"sr:player:34120"]
    private var playerTournaments = ["Premier League"]
    private var playerSeasons = ["2016-2017"]
    
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
        textPlayerPicker.tintColor = .clear
        
        competitionPicker.dataSource = self
        competitionPicker.delegate = self
        textCompetitionPicker.inputView = competitionPicker
        textCompetitionPicker.text = "Tournament"
        textCompetitionPicker.tintColor = .clear

        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        textSeasonPicker.inputView = seasonPicker
        textSeasonPicker.text = "Season"
        textSeasonPicker.tintColor = .clear
        
        DataDownloader.sharedInstance.fetchPlayers(completion: {(PlayersData) in self.updateUI(PlayersData) } )
    }
    
    @IBAction func didChangePlayer(_ sender: UITextField) {
        let names = [String](teamPlayers.keys)
        DataDownloader.sharedInstance.fetchTournamentData(player: teamPlayers[names[indexPlayer]]!, completion: {(TournamentData) in self.updateTournamentUI(TournamentData) } )

    }
    
    @IBAction func didChangeTournament(_ sender: UITextField) {
        let names = [String](teamPlayers.keys)
        DataDownloader.sharedInstance.fetchSeasonData(player: teamPlayers[names[indexPlayer]]!, tournament: playerTournaments[indexCompetition], completion: {(SeasonData) in self.updateSeasonUI(SeasonData) } )
    }
    
    func updateUI(_ playersData: PlayersData) {
        teamPlayers = playersData.players
//        textPlayerPicker.text = playersData.players.keys.first!
    }
    
    func updateTournamentUI(_ tournamentData: TournamentData) {
        playerTournaments = tournamentData.tournaments
//        textCompetitionPicker.text = tournamentData.tournaments.first!
    }
    
    func updateSeasonUI(_ seasonData: SeasonData) {
        playerSeasons = seasonData.seasons
//        textSeasonPicker.text = seasonData.seasons.first!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkReachability()
        navigationController?.navigationBar.isHidden = true
        goButton.layer.borderWidth = 1
        goButton.layer.borderColor = UIColor.white.cgColor
        goButton.layer.cornerRadius = 10
    }
    
    func checkReachability() {
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
            numOfRows = playerTournaments.count
        } else if pickerView == seasonPicker {
            numOfRows = playerSeasons.count
        }
        return numOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let names = [String](teamPlayers.keys)
        var titForRow = ""
        if pickerView == playerPicker {
            titForRow = names[row]
        } else if pickerView == competitionPicker {
            titForRow = playerTournaments[row]
        } else if pickerView == seasonPicker {
            titForRow = playerSeasons[row]
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
            textCompetitionPicker.text = playerTournaments[indexCompetition]
        } else if pickerView == seasonPicker {
            indexSeason = row
            textSeasonPicker.text = playerSeasons[indexSeason]
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard currentReachabilityStatus != .notReachable else { return }
        let names = [String](teamPlayers.keys)
        let resultDestination = segue.destination as? ResultViewController
        resultDestination?.imageName = teamPlayers[names[indexPlayer]]
        
        if let playerID = teamPlayers[names[indexPlayer]] {
            resultDestination?.playerID = playerID
        }
        
        let tournamentName = playerTournaments[indexCompetition]
            resultDestination?.tournamentName = tournamentName
        
        
        let chosenSeason = playerSeasons[indexSeason] 
            resultDestination?.chosenSeason = chosenSeason
        
        
    }


}
