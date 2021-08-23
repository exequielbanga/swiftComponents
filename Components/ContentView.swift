//
//  ContentView.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    
    var body: some View {
        VStack(spacing:0){
            TabsView(backgroundColor: .black, fontColor: .gray, selectedFontColor: .white, tabs: [
                        Tab(name: "Information", view: AnyView(SocialAccountsView(backgroundColor: .black, fontColor: .white, socialAccounts: [.instagram("/exelote"),.facebook("/exelote"),.youtube("/exequielconx")]))),
                        Tab(name: "Wall", view: AnyView(Color.blue)),
                        Tab(name: "Endorsements", view: AnyView(Color.yellow))], selection:$selection)
            Color.black
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
