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
    @State private var columnVisibility:
    
    NavigationSplitViewVisibility = .all
    
    var body: some View {
    
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "--"

//  Mark: - Start of Navigation Split View
        
NavigationSplitView(columnVisibility: $columnVisibility) {
    
    HStack {
        Text("\(appName)  \(appVersion)")
            .font(.caption2)
            .fontWeight(.light)
            .italic()
    }

// NSV Part 1 - "Company List"
            
    List(store.companies, selection: $companyId) { company in
        

        HStack (alignment: .top) {
            Image(systemName: "person.crop.circle")
                .font(.largeTitle)
            
                VStack (alignment: .leading) {
                    Text(company.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Reason for visit")
                        .font(.caption)
                        .padding(.bottom)
                    
                    GroupBox {
                    Text("Virtual appointment - 00:00")
                        .font(.caption2)
                    }
            }
            Spacer()
            Image(systemName: "checkmark.seal.fill")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            
        }
    }
    .navigationTitle("Patient Panel")

    
    
}

// NSV - Part 2a - "EmployeeListView (Embedded)"
    
    content: {
            if companyId == nil {
                VStack {
                    Image("company")
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                    Text("What Patient?")
                        .font(.title)
                }
                .padding()
            } else {
                if let company = store.company(id: companyId!) {
     
  
// This is the Patient Title Block for the Insignts List View
                    
                    GroupBox {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                            VStack (alignment: .leading) {
                                Text(company.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Profile")
                                    .font(.caption)
                                Text("More Data")
                                    .font(.largeTitle)
                            }
                            Spacer()
                        }
                   
                    }
                    List(company.employees, selection: $employeeId) { employee in
                        Text(employee.firstName)
                            .font(.title)
                    }
  //                  .navigationTitle("Insights")
                }
            }
        }
    
// NSV - Part 3 "EmployeeDetailView
        
    detail: {
        EmployeeDetailView(employeeId: employeeId)
    }
    .navigationSplitViewStyle(.balanced)
        
    .onChange(of: companyId) { _ in employeeId = nil; columnVisibility = .doubleColumn}
 
    .onChange(of: employeeId) { _ in
        if employeeId == nil {
            columnVisibility = .all
        } else {
            columnVisibility = .detailOnly
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
