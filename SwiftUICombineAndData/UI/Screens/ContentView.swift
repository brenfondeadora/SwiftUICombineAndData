//
//  ContentView.swift
//  SwiftUICombineAndData
//
//  Created by Brenda Saavedra  on 15/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var contentOffset = CGFloat(0)
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                TrackableScrollView(offsetChanged: { offset in
                    contentOffset = offset.y
                }) {
                    content
                    
                    Text("Version 1.00")
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .font(.footnote)
                }
                
                VisualEffectBlur(blurStyle: .systemMaterial)
                    .opacity(contentOffset < -16 ? 1 : 0)
                    .animation(.easeIn, value: true)
                    .ignoresSafeArea()
                    .frame(height: 0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(AccountBackground())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var divider: some View {
        Divider().background(Color.white).blendMode(.overlay)
    }
    
    var content: some View {
        VStack {
            NavigationLink(destination: FAQView()) {
                MenuRow()
            }
            .accentColor(.white)
            
            divider
            
            NavigationLink(destination: PackagesView()) {
                MenuRow(title: "SwiftUI Packages", leftIcon: "square.stack.3d.up.fill")
            }
            .accentColor(.white)
            
            divider
            
            Link(destination: URL(string: "https://www.youtube.com/channel/UCTIhfOopxukTIRkbXJ3kN-g")!, label: {
                MenuRow(title: "YouTube Channel", leftIcon: "play.rectangle.fill", rightIcon: "link")
            })
            .accentColor(.white)
        }
        .padding(16)
        .background(Color("Background 1"))
        .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), lineWidth: 1).blendMode(.overlay))
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding([.top, .horizontal], 20)
        
    }
    
    
}

// MARK: - Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
