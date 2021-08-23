//
//  ContentView.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SocialAccountsView(backgroundColor: .black, fontColor: .white, socialAccounts: [.instagram("/exelote"),.facebook("/exelote"),.youtube("/exequielconx")])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
