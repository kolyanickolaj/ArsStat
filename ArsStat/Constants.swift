
struct Constants {
    static let apiKey = "qg47rf3kuk88b7ubqgv656uz"
    
    static func statsByPlayerID(playerID: String) -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/players/\(playerID)/profile.json?api_key=\(Constants.apiKey)"
    }

}
