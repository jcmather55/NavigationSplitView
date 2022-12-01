//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-09-04
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct EmployeeDetailView: View {
    @EnvironmentObject var store: DataStore
    var employeeId: Employee.ID?
    var body: some View {
        if let employeeId {
            if let employee = store.employee(id: employeeId) {
                VStack {
                    
                    GroupBox {
                        HStack {
                            Image(systemName: "hc.lab.results")
                                .font(.largeTitle)
                            VStack (alignment: .leading) {
                                Text(employee.firstName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("As of:  December 1, 2022")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                    }
                    
                    
                    .navigationTitle(employee.firstName + " - " + employee.company.name)
                    .toolbarBackground(.green.gradient, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    
                    Spacer()
                    Text("Insight Details:   " + employee.firstName)
                        .font(.title)
                    Text("\"" + employee.slogan + "\"")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .italic()
                        .padding()
                    Grid {
                        GridRow(alignment: .top) {
                            Text("Department:").bold()
                                .gridColumnAlignment(.trailing)
                            Text(employee.department)
                                .gridColumnAlignment(.leading)
                        }
                        GridRow(alignment: .top) {
                            Text("Title:").bold()
                            Text(employee.title)
                        }
                    }
                    .padding()
                    .border(.primary)
                    .font(.title3)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        } else {
            VStack {
                Image("employee")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                Text("Insight Details")
                    .font(.title)
                
            }
        }
        
    }
}
    

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetailView(employeeId: "92c08f4a-d5bf-49e4-809f-7aefaa155c16")
            .environmentObject(DataStore())
    }
}
