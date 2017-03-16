
import Foundation

class DataDownloader {
    
    static let sharedInstance = DataDownloader()
    
    func fetchData(player: String, tournamentName: String, chosenSeason: String, completion: @escaping (_ statData:StatData) -> ()) {
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
                    guard let tourStat = dict["tournament"] as? Dictionary<String,AnyObject> else { continue }
                    guard let tourID = tourStat["name"] as? String else { continue }
                    guard let teamStat = dict["team"] as? Dictionary<String,AnyObject> else { continue }
                    guard let team = teamStat["name"] as? String else { continue }
                    guard var season = dict["name"] as? String else { continue }
                        season = self.getNormalSeason(apiSeason: season)
                    
                    if tourID == tournamentName  && team.contains("Arsenal") && season == chosenSeason
                    {
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
                    if name.contains("Sheaf") == false {
                        playersNames[name] = id
                    }
                    }
                
                DispatchQueue.main.async {
                    completion(PlayersData(players: playersNames))
                }
                
            }
        }
        dataTask.resume()
    }
    
    
    func fetchTournamentData(player: String, completion: @escaping (_ tournamentData:TournamentData) -> ()) {
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
            
                var apiSeasons = [] as [String]
                
                guard let allStatistics = json?["statistics"] as? Dictionary<String,AnyObject> else {return}
                let statisticsBySeason = allStatistics["seasons"] as? Array<Dictionary<String, AnyObject>>
                for dict in statisticsBySeason! {
                    guard let teamStat = dict["team"] as? Dictionary<String,AnyObject> else { continue }
                    guard let team = teamStat["name"] as? String else { continue }
                    guard let tourStat = dict["tournament"] as? Dictionary<String,AnyObject> else { continue }
                    guard let tourID = tourStat["name"] as? String else { continue }
                    
                    if team.contains("Arsenal")  {
                        apiSeasons.append(tourID)
                    }
                }
                let tournamentsmy = self.getNormalTournament(apiSeasons: apiSeasons)
                
                DispatchQueue.main.async {
                    completion(TournamentData(tournaments: tournamentsmy))
                }
                
            }
        }
        dataTask.resume()
    }
    
    
    func fetchSeasonData(player: String, tournament:String, completion: @escaping (_ seasonData:SeasonData) -> ()) {
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                var apiSeasons = [] as [String]
                
                guard let allStatistics = json?["statistics"] as? Dictionary<String,AnyObject> else {return}
                let statisticsBySeason = allStatistics["seasons"] as? Array<Dictionary<String, AnyObject>>
                for dict in statisticsBySeason! {
                    guard let teamStat = dict["team"] as? Dictionary<String,AnyObject> else { continue }
                    guard let team = teamStat["name"] as? String else { continue }
                    guard let tourStat = dict["tournament"] as? Dictionary<String,AnyObject> else { continue }
                    guard let tourName = tourStat["name"] as? String else { continue }
                    guard let season = dict["name"] as? String else { continue }
                    
                    if team.contains("Arsenal") && tourName == tournament {
                        apiSeasons.append(season)
                    }
                }
                
                let seasons = self.getNormalSeasons(apiSeasons: apiSeasons)
                
                DispatchQueue.main.async {
                    completion(SeasonData(seasons: seasons))
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
    
    
    func getNormalTournament(apiSeasons: [String]) -> ([String]) {
        var tournaments = [String]()
        
        for apiSeason in apiSeasons {
            if tournaments.contains(apiSeason) == false {
                tournaments.append(apiSeason)
            }
        }
        tournaments = tournaments.sorted(by: >)
        
    return tournaments
    }
    
    
    func getNormalSeasons(apiSeasons: [String]) -> ([String]) {
        var seasons = [String]()
        var tempArr = [String]()
        
        for apiSeason in apiSeasons {
            let arr = apiSeason.components(separatedBy: " ")
            for item in arr {
                if Double(item.replacingOccurrences(of: "/", with: "")) != nil {
                    if seasons.contains(item) == false {
                        seasons.append(item)
                    }
                }
            }
        }
        
        for item in seasons {
            if item.contains("/") == true {
            let arr = item.components(separatedBy: "/")
            
            var newArr = [String]()
            for numb in arr {
                if numb.contains("20") == false {
                    let newNumb = numb.replacingOccurrences(of: numb, with: "20" + numb)
                    newArr.append(newNumb)} else {newArr.append(numb)}
                }
            let newSeason = newArr.joined(separator: "-")
                tempArr.append(newSeason) } else {tempArr.append(item)}
        }
        seasons = tempArr.sorted(by: >)
        return seasons
    }

    
    func getNormalSeason(apiSeason: String) -> (String) {
        var season = ""
        
        let arr = apiSeason.components(separatedBy: " ")
        for item in arr {
            if Double(item.replacingOccurrences(of: "/", with: "")) != nil {
                if item.contains("/") == true {
                    let arr = item.components(separatedBy: "/")
                    var newArr = [String]()
                    for numb in arr {
                        if numb.contains("20") == false {
                        let newNumb = numb.replacingOccurrences(of: numb, with: "20" + numb)
                            newArr.append(newNumb)} else {newArr.append(numb)}
                    }
                    let newSeason = newArr.joined(separator: "-")
                    season = newSeason
                } else { season = item }
            }
        }
        return season
    }

}
