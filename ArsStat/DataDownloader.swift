
import Foundation

class DataDownloader {
    
    static let sharedInstance = DataDownloader()
    
    func fetchData(player: String, completion: @escaping (_ statData:StatData) -> ()) {
//        let player = "sr:player:1053"
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, responce, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                let height = json?["height"] as? Int
                let weight = json?["weight"] as? Int
                let matchesPlayed = json?["matches_played"] as? Int
                let goals = json?["goals_scored"] as? Int
                let assists = json?["assists"] as? Int
                let yellowCards = json?["yellow_cards"] as? Int
                let redCards = json?["red_cards"] as? Int
                
                DispatchQueue.main.async {
                    completion(StatData(height: height, weight: weight, matchesPlayed: matchesPlayed, goals: goals, assists: assists, yellowCards: yellowCards, redCards: redCards))
                }
                
            }
        }
        
        dataTask.resume()
    
}



}

