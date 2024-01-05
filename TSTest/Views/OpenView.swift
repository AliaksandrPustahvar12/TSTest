//
//  OpenView.swift
//  TSTest
//
//  Created by Aliaksandr Pustahvar on 5.01.24.
//

import SwiftUI

struct OpenView: View {
    
    @State private var isAnimating = false
    @State private var isOpenOnboarding = false
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray5).ignoresSafeArea()
            
            Button( action: {
                isOpenOnboarding = true
            }) {
                Text("Open onboarding")
                    .font(.title)
                    .foregroundStyle(Color.white)
            }
            .padding()
            .background(.orange)
            .cornerRadius(12)
            .shadow(color: .gray, radius: 10)
            .scaleEffect(isAnimating ? 1.3 : 1.0)
            .animation(Animation.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
            .fullScreenCover(isPresented: $isOpenOnboarding, content: {
                withAnimation(.easeInOut(duration: 1)) {
                    SlidesView(isOpenOnboarding: $isOpenOnboarding)
                }
            })
        }
    }
}

#Preview {
   ContentView()
}
