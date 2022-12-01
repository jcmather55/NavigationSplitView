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
        for company in json {
            var newCompany = Member(id: company.id, name: company.name)
            for employee in company.employees {
                let newEmployee = Insight(id: employee.id,
                                           insightname: employee.insightname,
                                           lastName: employee.lastName,
                                           department: employee.department,
                                           slogan: employee.slogan,
                                           title: employee.title,
                                           company: newCompany)
                Insights.append(newEmployee)
                newCompany.employees.append(newEmployee)
            }
            newCompany.employees = newCompany.employees.sorted(using: KeyPathComparator(\.lastName))
            FamilyMembers.append(newCompany)
            
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
