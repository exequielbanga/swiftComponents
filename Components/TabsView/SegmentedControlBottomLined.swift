//
//  SegmentedControlBottomLined.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
// https://betterprogramming.pub/custom-ios-segmented-control-with-swiftui-473b386d0b51

import SwiftUI

struct SegmentedControlBottomLined: View {
    @State var backgroundColor: Color
    @State var textColor: Color
    @State var selectedTextColor: Color
    @State var activeSegmentColor: Color
    @State var textFont: Font

    private static let ShadowColor: Color = Color.black.opacity(0.2)
    private static let SegmentCornerRadius: CGFloat = 12
    private static let ShadowRadius: CGFloat = 4
    private static let SegmentXPadding: CGFloat = 16
    private static let SegmentYPadding: CGFloat = 8
    private static let PickerPadding: CGFloat = 4
    
    private static let AnimationDuration: Double = 0.1
    
    // Stores the size of a segment, used to create the active segment rect
    @State private var segmentSize: CGSize = .zero
    // Rounded rectangle to denote active segment
    private var activeSegmentView: AnyView {
        // Don't show the active segment until we have initialized the view
        // This is required for `.animation()` to display properly, otherwise the animation will fire on init
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        return Path { path in
                path.move(to: CGPoint(x: 0, y: segmentSize.height))
                path.addLine(to: CGPoint(x: segmentSize.width, y: segmentSize.height))
            }
        .stroke(self.activeSegmentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        .shadow(color: SegmentedControlBottomLined.ShadowColor, radius: SegmentedControlBottomLined.ShadowRadius)
        .frame(width: self.segmentSize.width, height: self.segmentSize.height)
        .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
        .animation(Animation.linear(duration: SegmentedControlBottomLined.AnimationDuration))
        .eraseToAnyView()

    }
    
    @Binding private var selection: Int
    private let items: [String]
    
    init(items: [String], selection: Binding<Int>,backgroundColor: Color = Color(.secondarySystemBackground),textColor: Color = Color(.secondaryLabel),selectedTextColor: Color = Color(.label),activeSegmentColor: Color = Color(.tertiarySystemBackground),textFont: Font = .system(size: 12)) {
        self._selection = selection
        self.items = items
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.activeSegmentColor = activeSegmentColor
        self.textFont = textFont
    }
    
    var body: some View {
        // Align the ZStack to the leading edge to make calculating offset on activeSegmentView easier
        ZStack(alignment: .leading) {
            // activeSegmentView indicates the current selection
            self.activeSegmentView
            HStack {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                }
            }
        }
        .padding(SegmentedControlBottomLined.PickerPadding)
        .background(self.backgroundColor)
//        .clipShape(RoundedRectangle(cornerRadius: SegmentedControlBottomLined.SegmentCornerRadius))
    }

    // Helper method to compute the offset based on the selected index
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.segmentSize.width + SegmentedControlBottomLined.SegmentXPadding / 2)
    }

    // Gets text view for the segment
    private func getSegmentView(for index: Int) -> some View {
        guard index < self.items.count else {
            return EmptyView().eraseToAnyView()
        }
        let isSelected = self.selection == index
        return
            Text(self.items[index])
                // Dark test for selected segment
            .font(self.textFont)
            .foregroundColor(isSelected ? self.selectedTextColor: self.textColor)
                .lineLimit(1)
                .padding(.vertical, SegmentedControlBottomLined.SegmentYPadding)
                .padding(.horizontal, SegmentedControlBottomLined.SegmentXPadding)
                .frame(minWidth: 0, maxWidth: .infinity)
                // Watch for the size of the
                .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
                .onTapGesture { self.onItemTap(index: index) }
                .eraseToAnyView()
    }

    // On tap to change the selection
    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
    }
    
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
struct BackgroundGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color
                    .clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}
struct SizeAwareViewModifier: ViewModifier {

    @Binding private var viewSize: CGSize

    init(viewSize: Binding<CGSize>) {
        self._viewSize = viewSize
    }

    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: { if self.viewSize != $0 { self.viewSize = $0 }})
    }
}

struct PreviewView: View {
    @State var selection: Int = 0
    private let items: [String] = ["M", "T", "W", "T", "F"]
    
    var body: some View {
        SegmentedControlBottomLined(items: self.items, selection: self.$selection)
            .padding()
    }
}





