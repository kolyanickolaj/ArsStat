
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    private var indexPlayer = 0
    private var indexCompetition = 0
    private var indexSeason = 0
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var competitionLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var textPlayerPicker: UITextField!
    @IBOutlet weak var textCompetitionPicker: UITextField!
    @IBOutlet weak var textSeasonPicker: UITextField!
        
    private var playerPicker = UIPickerView()
    private var competitionPicker = UIPickerView()
    private var seasonPicker = UIPickerView()
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    var language = "ENG"
    
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            playerLabel.text = "Player"
            textCompetitionPicker.text = engCompetitions[indexCompetition]
            competitionLabel.text = "Competition"
            seasonLabel.text = "Season"
            language = "ENG"
        } else {
            playerLabel.text = "Игрок"
            textCompetitionPicker.text = rusCompetitions[indexCompetition]
            competitionLabel.text = "Соревнование"
            seasonLabel.text = "Сезон"
            language = "RUS"
        }
    }
    
    
    
    
//    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            playerLabel.text = "Player"
//            textCompetitionPicker.text = engCompetitions[indexCompetition]
//            competitionLabel.text = "Competition"
//            seasonLabel.text = "Season"
//            language = "ENG"
//        } else {
//            playerLabel.text = "Игрок"
//            textCompetitionPicker.text = rusCompetitions[indexCompetition]
//            competitionLabel.text = "Соревнование"
//            seasonLabel.text = "Сезон"
//            language = "RUS"
//        }
//
//    }
    let names = ["Alexis Sanchez", "Olivier Giroud", "Danny Welbeck", "Theo Walcott", "Lucas Perez", "Alex Iwobi", "Aaron Ramsey", "Mesut Ozil", "Santi Cazorla", "Alex Oxlade-Chamberlain", "Granit Xhaka", "Francis Coquelin", "Mohamed Elneny", "Jeff Reine-Adelaide", "Laurent Koscielny", "Shkodran Mustafi", "Hector Bellerin", "Nacho Monreal", "Kieran Gibbs", "Mathieu Debuchy", "Gabriel", "Carl Jenkinson", "Per Mertesacker", "Rob Holding", "Petr Cech", "David Ospina", "Emiliano Martinez"]
    
    let engCompetitions = ["All competitions", "Premier League", "Champions League", "FA Cup", "EFL Cup"]
    let rusCompetitions = ["Все соревнования", "Премьер Лига", "Лига Чемпионов", "Кубок Англии", "Кубок Английской Лиги"]
    
    let seasons = ["2016-2017", "2015-2016", "2014-2015"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerPicker.dataSource = self
        playerPicker.delegate = self
        textPlayerPicker.text = names[indexPlayer]
        textPlayerPicker.textColor = UIColor.white
        textPlayerPicker.inputView = playerPicker
        
        competitionPicker.dataSource = self
        competitionPicker.delegate = self
        textCompetitionPicker.textColor = UIColor.white
        textCompetitionPicker.inputView = competitionPicker
        if language == "ENG" {
            textCompetitionPicker.text = engCompetitions[indexCompetition]
        } else { textCompetitionPicker.text = rusCompetitions[indexCompetition] }

        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        textSeasonPicker.text = seasons[indexSeason]
        textSeasonPicker.textColor = UIColor.white
        textSeasonPicker.inputView = seasonPicker
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func performSelector(inBackground aSelector: Selector, with arg: Any?) {
        playerPicker.showsSelectionIndicator = true
        competitionPicker.showsSelectionIndicator = true
        seasonPicker.showsSelectionIndicator = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numOfRows = 0
        if pickerView == playerPicker {
            numOfRows = names.count
        } else if pickerView == competitionPicker {
            numOfRows = engCompetitions.count
        } else if pickerView == seasonPicker {
            numOfRows = seasons.count
        }
        return numOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titForRow = ""
        if pickerView == playerPicker {
            titForRow = names[row]
        } else if pickerView == competitionPicker && language == "ENG" {
            titForRow = engCompetitions[row]
        } else if pickerView == competitionPicker {
            titForRow = rusCompetitions[row]
        } else if pickerView == seasonPicker {
            titForRow = seasons[row]
        }
        return titForRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == playerPicker {
            indexPlayer = row
            textPlayerPicker.text = names[indexPlayer]
        } else if pickerView == competitionPicker && language == "ENG" {
            indexCompetition = row
            textCompetitionPicker.text = engCompetitions[indexCompetition]
        } else if pickerView == competitionPicker  {
            indexCompetition = row
            textCompetitionPicker.text = rusCompetitions[indexCompetition]
        } else if pickerView == seasonPicker {
            indexSeason = row
            textSeasonPicker.text = seasons[indexSeason]
        }
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultDestination = segue.destination as? ResultViewController
        resultDestination?.imageName = names[indexPlayer]
        resultDestination?.language = language
        
        let infoDestination = segue.destination as? InfoShowViewController
        infoDestination?.language = language
        
    }
    


}










