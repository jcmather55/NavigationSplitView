//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-07-22
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct CompaniesListView: View {
    @EnvironmentObject var store: DataStore
    @State private var companyId: Company.ID?
    @State private var employeeId: Employee.ID?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(store.companies, selection: $companyId) { company in
                GroupBox {
                    Text(company.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Second Line")
                }
            }
            .navigationTitle("My Family")
        } content: {
            if companyId == nil {
                VStack {
                    Image("company")
                        .resizable()
                        .scaledToFit()
                    Text("Select Family Member")
                        .font(.title)
                }
                .padding()
            } else {
                if let company = store.company(id: companyId!) {
                    List(company.employees, selection: $employeeId) { employee in
                        Text(employee.fullName)
                            .font(.title)
                    }
                    .navigationTitle("Health Insights")
                }
            }
        } detail: {
            EmployeeView(employeeId: employeeId)
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: companyId) { _ in
            employeeId = nil
        }
        .onChange(of: employeeId) { _ in
            if employeeId == nil {
                columnVisibility = .all
            } else {
                columnVisibility = .doubleColumn
            }
        }
    }
}

struct CompaniesListView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesListView()
            .environmentObject(DataStore())
    }
}
