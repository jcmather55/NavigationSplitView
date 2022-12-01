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
    var insightId: Insight.ID?
    var body: some View {
        if let insightId {
            if let insight = store.insight(id: insightId) {
                VStack {
                 Text ("")
//                    GroupBox {
//                        HStack {
//                            Image(systemName: "waveform.path.ecg.rectangle")
//                                .font(.largeTitle)
//                            VStack (alignment: .leading) {
//                                Text(insight.familymember.name)
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("As of:  December 1, 2022")
//                                    .font(.caption .italic())
//
//                            }
//                            Spacer()
//                        }
//                    }
                    
                    
                        .navigationTitle(insight.insightName)

                    .toolbarBackground(.orange.gradient, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    
                    Spacer()
                    Text("Insight Details:   " + insight.insightName)
                        .font(.headline)
                    Text("\"" + insight.insightHighRange + "\"")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .italic()
                        .padding()
                    Grid {
                        GridRow(alignment: .top) {
                            Text("Department:").bold()
                                .gridColumnAlignment(.trailing)
                            Text(insight.insightLowRange)
                                .gridColumnAlignment(.leading)
                        }
                        GridRow(alignment: .top) {
                            Text("Title:").bold()
                            Text(insight.insightValue1)
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
                Image("insight")
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
        InsightDetailView(insightId: "92c08f4a-d5bf-49e4-809f-7aefaa155c16")
            .environmentObject(DataStore())
    }
}
