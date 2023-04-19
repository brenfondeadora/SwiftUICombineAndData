//
//  TrackableScrollView.swift
//  SwiftUICombineAndData
//
//  Created by Brenda Saavedra  on 15/04/23.
//

import SwiftUI

struct TrackableScrollView<Content: View>: View {
    let axes: Axis.Set
    let offesetChanged: (CGPoint) -> Void
    let content: Content
    
    init(axes: Axis.Set = .vertical, offsetChanged: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content:() -> Content) {
        self.axes = axes
        self.offesetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axes) {
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offesetChanged)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
