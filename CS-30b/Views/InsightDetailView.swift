//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-09-04
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct InsightDetailView: View {
    @EnvironmentObject var store: DataStore
    var employeeId: Insight.ID?
    var body: some View {
        if let employeeId {
            if let employee = store.employee(id: employeeId) {
                VStack {
                 Text ("")
//                    GroupBox {
//                        HStack {
//                            Image(systemName: "waveform.path.ecg.rectangle")
//                                .font(.largeTitle)
//                            VStack (alignment: .leading) {
//                                Text(employee.company.name)
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("As of:  December 1, 2022")
//                                    .font(.caption .italic())
//
//                            }
//                            Spacer()
//                        }
//                    }
                    
                    
                        .navigationTitle(employee.insightName)

                    .toolbarBackground(.orange.gradient, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    
                    Spacer()
                    Text("Insight Details:   " + employee.insightName)
                        .font(.headline)
                    Text("\"" + employee.insightHighRange + "\"")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .italic()
                        .padding()
                    Grid {
                        GridRow(alignment: .top) {
                            Text("Department:").bold()
                                .gridColumnAlignment(.trailing)
                            Text(employee.insightLowRange)
                                .gridColumnAlignment(.leading)
                        }
                        GridRow(alignment: .top) {
                            Text("Title:").bold()
                            Text(employee.insightValue1)
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
                Text("Insight details display here...")
                    .font(.headline)
                
            }
        }
        
    }
}
    

struct InsightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InsightDetailView(employeeId: "92c08f4a-d5bf-49e4-809f-7aefaa155c16")
            .environmentObject(DataStore())
    }
}
