//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-07-22
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import Foundation

class DataStore: ObservableObject {
    @Published var FamilyMembers: [Member] = []
    @Published var Insights: [Insight] = []
    @Published var insightsFilter = ""
    
    var filteredEmployees: [Insight] {
        insightsFilter.isEmpty ? Insights : Insights.filter {$0.fullName.lowercased().contains(insightsFilter.lowercased())}
    }

    init() {
        loadData()
    }
    
    func loadData() {
        let json = Bundle.main.decode([FamilyMemberJSON].self, from: "MOCK_DATA.json")
        for familymember in json {
            var newFamilyMember = Member(id: familymember.id, name: familymember.name)
            for insight in familymember.insights {
                let newInsight = Insight(id: insight.id,
                                           insightname: insight.insightname,
                                           lastName: insight.lastName,
                                           department: insight.department,
                                           slogan: insight.slogan,
                                           title: insight.title,
                                           company: newFamilyMember)
                Insights.append(newInsight)
                newFamilyMember.employees.append(newInsight)
            }
            newFamilyMember.employees = newFamilyMember.employees.sorted(using: KeyPathComparator(\.lastName))
            FamilyMembers.append(newFamilyMember)
            
        }
        FamilyMembers = FamilyMembers.sorted(using: KeyPathComparator(\.name))
        Insights = Insights.sorted(using: KeyPathComparator(\.lastName))
    }
    
    func employee(id: String) -> Insight? {
        Insights.first(where: {$0.id == id})
    }
    
    func company(id: String) -> Member? {
        FamilyMembers.first(where: {$0.id == id})
    }
}
