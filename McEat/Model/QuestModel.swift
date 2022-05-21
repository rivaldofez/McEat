//
//  QuestModel.swift
//  McEat
//
//  Created by Rivaldo Fernandes on 21/05/22.
//

import SwiftUI

struct QuestItem: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let color: [Color]
    var clue: [String]
    var isUnlock: Bool
}


struct Quest: Identifiable {
    let id = UUID()
    let category: String
    var questItem: [QuestItem]
}

