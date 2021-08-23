//
//  ContentView.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    private let items: [String] = ["M", "T", "W", "T", "F"]
    
    var body: some View {
        VStack{
            TabsView(backgroundColor: .black, fontColor: .gray, selectedFontColor: .white, tabs: [Tab(name: "Information", view: AnyView(Color.green)),
                            Tab(name: "Wall", view: AnyView(Color.green)),
                            Tab(name: "Endorsements", view: AnyView(Color.green))])

            SocialAccountsView(backgroundColor: .black, fontColor: .white, socialAccounts: [.instagram("/exelote"),.facebook("/exelote"),.youtube("/exequielconx")])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
