
import Foundation

class DataDownloader {
    
    static let sharedInstance = DataDownloader()
    
    func fetchData(player: String, tournamentID: String, completion: @escaping (_ statData:StatData) -> ()) {
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                let playerStat = json?["player"] as? Dictionary<String,AnyObject>
                let height = playerStat?["height"] as? Int
                let weight = playerStat?["weight"] as? Int
                var arrOfStat = ["matches_played":0, "goals_scored":0, "assists":0, "yellow_cards":0, "red_cards":0] as [String : Any]
                
                guard let allStatistics = json?["statistics"] as? Dictionary<String,AnyObject> else {return}
                
                
                let statisticsBySeason = allStatistics["seasons"] as? Array<Dictionary<String, AnyObject>>
                for dict in statisticsBySeason! {
                    guard let curTournamentID = dict["id"] as? String else { continue }
                    guard let teamStat = dict["team"] as? Dictionary<String,AnyObject> else { continue }
                    guard let teamID = teamStat["id"] as? String else { continue }
                    if curTournamentID == tournamentID  && teamID == "sr:competitor:42" {
                        arrOfStat = (dict["statistics"] as? Dictionary<String,AnyObject>)!
                    }
                }
                
                    let matchesPlayed = arrOfStat["matches_played"] as? Int
                    let goals = arrOfStat["goals_scored"] as? Int
                    let assists = arrOfStat["assists"] as? Int
                    let yellowCards = arrOfStat["yellow_cards"] as? Int
                    let redCards = arrOfStat["red_cards"] as? Int
                
                
                DispatchQueue.main.async {
                    completion(StatData(height: height, weight: weight, matchesPlayed: matchesPlayed, goals: goals, assists: assists, yellowCards: yellowCards, redCards: redCards))
                }
                
            }
        }
        dataTask.resume()
    }
    
    func getNormalName(name: String) -> String {
        let arr = name.components(separatedBy: ",")
        var normalName = arr[1] + " " + arr[0]
        normalName = normalName.replacingOccurrences(of: ",", with: "")
        return normalName
    }

   
    func fetchPlayers(completion: @escaping (_ playersData:PlayersData) -> ()) {
        guard let url = URL(string: Constants.getPlayers()) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
            
                let players = json?["players"] as? Array<Dictionary<String, AnyObject>>
            
                var playersNames = [:] as [String:String]

                for dict in players! {
                    guard var name = dict["name"] as? String else { continue }
                    if name != "Gabriel Paulista" {
                        name = self.getNormalName(name: name)
                    }
                    guard let id = dict["id"] as? String else { continue }
                    playersNames[name] = id
                    }
                DispatchQueue.main.async {
                    completion(PlayersData(players: playersNames))
                }
                
            }
        }
        dataTask.resume()
    }


}

