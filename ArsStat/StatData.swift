//
//  StatData.swift
//  ArsStat
//
//  Created by Администратор on 11.03.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import Foundation

struct StatData {
    var height:Int?
    var weight:Int?
    var matchesPlayed:Int?
    var goals:Int?
    var assists:Int?
    var yellowCards:Int?
    var redCards:Int?
}

struct PlayersData {
    var players = [String:String]()
}

struct TournamentData {
    var tournaments = [String]()
}

struct SeasonData {
    var seasons = [String]()
}
