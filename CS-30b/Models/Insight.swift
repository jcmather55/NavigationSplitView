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
    var insightname: String
    var insightCode: String
    var department: String
    var slogan: String
    var title: String
    var company: Member
    
    var fullName: String {
        insightname + " " + insightCode
    }
}
