//
//  TabsView.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
//

import SwiftUI

struct Tab: Hashable{
    var name: String
    var view: AnyView
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func == (lhs: Tab, rhs: Tab) -> Bool {
        return lhs.name == rhs.name
    }
}

struct TabsView: View {
    let backgroundColor: Color
    let fontColor: Color
    let selectedFontColor: Color

    @State var tabs: [Tab]
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing:0){
            SegmentedControlBottomLined(items: self.tabs.map({$0.name}), selection: self.$selection, backgroundColor:self.backgroundColor,textColor:self.fontColor, selectedTextColor:self.selectedFontColor, activeSegmentColor:self.selectedFontColor, textFont: .system(size: 12))
            self.tabs[self.selection].view
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(backgroundColor: .black, fontColor: .gray, selectedFontColor: .white, tabs: [Tab(name: "Information", view: AnyView(Text("One"))),
                        Tab(name: "Wall", view: AnyView(Text("Two"))),
                        Tab(name: "Endorsements", view: AnyView(Text("Three")))], selection:.constant(2))
    }
}
