
import Foundation

class DataDownloader {
    
    static let sharedInstance = DataDownloader()
    
    func fetchData(player: String, tournamentID: String, completion: @escaping (_ statData:StatData) -> ()) {
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                print(json!)
                print(tournamentID)
                let playerStat = json?["player"] as? Dictionary<String,AnyObject>
                let height = playerStat?["height"] as? Int
                let weight = playerStat?["weight"] as? Int
                
//                var matchesPlayed = json?["matches_played"] as? Int
//                var goals = json?["goals_scored"] as? Int
//                var assists = json?["assists"] as? Int
//                var yellowCards = json?["yellow_cards"] as? Int
//                var redCards = json?["red_cards"] as? Int
                
                let stati = json?["statistics"] as? Dictionary<String,AnyObject>
                let seas = stati?["seasons"] as? Array<Dictionary<String, AnyObject>>
                
                var mynew = (seas?[0])! as Dictionary<String,AnyObject>
                for dict in seas! {
                    if String(describing: dict["id"]) == tournamentID {
                        mynew = (dict["statistics"] as? Dictionary<String,AnyObject>)!
                    }
                }
                
                    let matchesPlayed = mynew["matches_played"] as? Int
                    let goals = mynew["goals_scored"] as? Int
                    let assists = mynew["assists"] as? Int
                    let yellowCards = mynew["yellow_cards"] as? Int
                    let redCards = mynew["red_cards"] as? Int
                
                
                DispatchQueue.main.async {
                    completion(StatData(height: height, weight: weight, matchesPlayed: matchesPlayed, goals: goals, assists: assists, yellowCards: yellowCards, redCards: redCards))
                }
                
            }
        }
        
        dataTask.resume()
        
    }
   

}

