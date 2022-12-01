//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-06-15
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

    struct FamilyMemberJSON: Codable, Identifiable {
        var name: String
        let id: String
        var insights: [Insight]
        
        struct Insight: Codable, Identifiable, Hashable {
            let id: String
            var insightName: String
            var insightCode: String
            var insightValue1: String
            var insightLowRange: String
            var insightHighRange: String
            
            var fullName: String {
                insightName + " " + insightCode
            }
        }
    }
    
