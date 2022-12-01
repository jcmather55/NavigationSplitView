//
// Created for NavigationSplitView
// by Stewart Lynch on 2022-07-22
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct FamilyMembersListView: View {
    @EnvironmentObject var store: DataStore
    @State private var familyMemberId: Member.ID?
    @State private var insightId: Insight.ID?
    @State private var columnVisibility:
    
    NavigationSplitViewVisibility = .all
    
    var body: some View {
    
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "--"

// MARK: - NAVIGATION SPLIT VIEW... START
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            
            // To display the App Name & Version

            HStack {
                Text("\(appName)  \(appVersion)")
                    .font(.caption2)
                    .fontWeight(.light)
                    .italic()
            }
            
            // NSV Part 1 - list family members
            
            List(store.FamilyMembers, selection: $familyMemberId) { familymember in
            
                HStack (alignment: .top) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                    
                    VStack (alignment: .leading) {
                        Text(familymember.name)
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
 

            .padding(0.01)
            .toolbar {
                
                // The bottom toobar on the first "Patient Panel" sidebar
                
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

                // The top toolbar on the sidebar
                
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
    .toolbarBackground(.blue.gradient, for: .navigationBar)
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)


}

// MARK: - CONTENT SECTION OF NAVIGATION SPLIT VIEW
    
    content: {
            if familyMemberId == nil {
                VStack {
                    Image("familymember")
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                    Text("List of Insights")
                        .font(.headline)
                        
                }
                .padding()
            } else {
                if let familymember = store.familymember(id: familyMemberId!) {
     
  
            // This is the Patient Title Block for top of Insignts List View
                    
//                    GroupBox {
//                        HStack {
//                            Image(systemName: "person.crop.circle")
//                                .font(.largeTitle)
//                            VStack (alignment: .leading) {
//                               Text(familymember.name)
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//
//                                Text("Profile")
//                                    .font(.caption)
//                                Text("Summary of all Insights")
//                                    .font(.insightValue1)
//                                    .padding()
//
//                            }
//                            Spacer()
//                        }
//
//                    }
                    List(familymember.insights, selection: $insightId) { insight in
   
                        GroupBox  {
                            VStack (alignment: .leading) {
                                Text(insight.insightName)
                                    .font(.headline)
                                Text("Insight                                                                                               ")
                                    .font(.caption)
                            }
                        }
                        
                    }
                    .padding()
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
                    
                    
                    .navigationTitle(familymember.name)
                    .toolbarBackground(.teal.gradient, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    
                }
            }
        }
    
// MARK: - DETAIL SECTION OF NAVIGATION SPLIT VIEW
    detail: {
        InsightDetailView(insightId: insightId)
    }
        


        .navigationSplitViewStyle(.balanced)
 
    .onChange(of: familyMemberId) { _ in insightId = nil; columnVisibility = .doubleColumn}
 
    .onChange(of: insightId) { _ in
        if insightId == nil {
            columnVisibility = .all
        } else {
            columnVisibility = .detailOnly
        }


    }
        
    }
    

}



struct FamilyMembesListView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMembersListView()
            .environmentObject(DataStore())
    }
}
