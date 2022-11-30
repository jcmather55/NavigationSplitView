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
                        
//                        GroupBox {
//                            Text("Virtual appointment - 00:00")
//                                .font(.caption2)
//                        }
                    }
                    Spacer()
                    Image(systemName: "checkmark.seal.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    
                }
            }
 
// The toobar on the first "Patient Panel" list
            
            .toolbar {
                
                ToolbarItemGroup (placement: .bottomBar) {
                    Button { } label: { Image (systemName: "books.vertical.fill")
                        Text("Search")}
                    Spacer()
                    Button { } label: { Image (systemName:
                        "cross.case.fill")
                        Text("Shop")}
                    Spacer()
                    Button { } label: { Image (systemName: "square.and.arrow.up.fill") .foregroundColor(.blue)
                        Text("Share")}

                  
                }

                
                ToolbarItemGroup (placement: .secondaryAction) {
                    
                    Button { } label: { Image(systemName: "list.clipboard.fill")
                        Text("yy")}
                    
                    Button { } label: { Image(systemName: "cross.case.fill")
                        Text("zz")}
                    
                    Button { } label: { Image(systemName: "calendar.circle.fill")
                        Text("cal")}
                    
                }
            }
            .font(.caption)
            
    .navigationTitle("My Family")




    
    
}

// NSV - Part 2a - "EmployeeListView (Embedded)"
    
    content: {
            if companyId == nil {
                VStack {
                    Image("company")
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                    Text("List of Insights")
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
                                Text("More Data Title")
                                    .font(.largeTitle)
                            }
                            Spacer()
                        }
                   
                    }
                    List(company.employees, selection: $employeeId) { employee in
   
                        GroupBox  {
                            VStack (alignment: .leading) {
                                Text(employee.firstName)
                                    .font(.largeTitle)
                                Text("Insight Summary")
                                    .font(.title)
                            }
                        }
                        
                    }

                    .toolbar {
                        
                        ToolbarItemGroup (placement: .secondaryAction) {
                            Button { } label: { Image (systemName: "books.vertical.fill")
                                Text("Search")}
                            Spacer()
                            Button { } label: { Image (systemName:
                                "cross.case.fill")
                                Text("Shop")}
                            Spacer()
                            Button { } label: { Image (systemName: "square.and.arrow.up.fill") .foregroundColor(.blue)
                                Text("Share")}

                          
                        }

                        
                        ToolbarItemGroup (placement: .secondaryAction) {
                            
                            Button { } label: { Image(systemName: "list.clipboard.fill")
                                Text("yy")}
                            
                            Button { } label: { Image(systemName: "cross.case.fill")
                                Text("zz")}
                            
                            Button { } label: { Image(systemName: "calendar.circle.fill")
                                Text("cal")}
                            
                        }
                    }
                    .font(.caption)
                    
                    
                    .navigationTitle("Insights")

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
