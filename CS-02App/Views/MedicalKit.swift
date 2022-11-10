//
//  HomeMedKit.swift
//  NavigationSplitView
//
//  Created by John C Mather on 11/5/22.
//

import SwiftUI

struct MedicalKit: View {
    var body: some View {
        Text("Home Medical Kit")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)
    }
}

struct HomeMedKit_Previews: PreviewProvider {
    static var previews: some View {
        MedicalKit()
    }
}
