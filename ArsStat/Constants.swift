
struct Constants {
    static let apiKey = "uzehmksx5g8rzsybtzqautvd"
    
    static func statsByPlayerID(playerID: String) -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/players/\(playerID)/profile.json?api_key=\(Constants.apiKey)"
    }
    
    static func getPlayers() -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/teams/sr:competitor:42/profile.json?api_key=\(Constants.apiKey)"
    }

}
