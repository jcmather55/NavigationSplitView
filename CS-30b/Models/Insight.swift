//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-07-22
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import Foundation

struct Insight: Identifiable {
    var id: String
    var insightName: String
    var insightCode: String
    var insightLowRange: String
    var insightHighRange: String
    var insightValue1: String
    var company: Member
    
    var fullName: String {
        insightName + " " + insightCode
    }
}
