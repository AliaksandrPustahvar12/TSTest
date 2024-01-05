//
//  SlidesView.swift
//  TSTest
//
//  Created by Aliaksandr Pustahvar on 5.01.24.
//

import SwiftUI

struct SlidesView: View {
    @ObservedObject var viewModel = SlidesViewModel()
    @State private var isInitial = true
    @State private var currentIndex = 0
    @State private var isClose = false
    @Binding var isOpenOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray5).ignoresSafeArea()
            
                ForEach(viewModel.slides.indices.reversed(), id: \.self) { index in
                    
                    slideView(index: index)
                        .cornerRadius(20)
                        .contentShape(Rectangle())
                        .padding(.bottom, 150)
                        .offset(y: viewModel.slides[index].offset + getOffset(index: index))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                onChange(value: value, index: index)
                            })
                                .onEnded({ value in
                                    onEnd(value: value, index: index)
                                }))
                }
            
            HStack {
                if isInitial {
                    Spacer()
                    Button(action: { nextButton() },label: {
                        Text("ACCETTA")
                            .font(.title3)
                            .tint(.orange)
                            .frame(width: 150, height: 80)
                    })
                } else {
                    Button(action: { previosButton() }, label: {
                        Text("RIFIUTA")
                            .font(.title3)
                            .tint(Color(uiColor: .systemGray3))
                            .padding(.leading, 20)
                            .frame(width: 150, height: 80)
                    })
                    
                    Spacer()
                    
                    Button(action: { nextButton() }, label: {
                        Text("ACCETTA")
                            .font(.title3)
                            .tint(.orange)
                            .frame(width: 150, height: 80)
                    })
                }
            }
            .frame(width: UIScreen.main.bounds.width - 2, height: 80)
            .background (
                Color(uiColor: .systemGray6).ignoresSafeArea()
                    .border(Color(uiColor: .systemGray6), width: 1)
                    .shadow(color: Color(uiColor: .systemGray6), radius: 1)
            )
            .offset(y: UIScreen.main.bounds.height / 2 - 55)
            
            if isClose {
                withAnimation(.easeInOut(duration: 0.1)) {
                    Color(uiColor: .systemGray5).ignoresSafeArea()
                }
            }
          }
    }
    
    func onChange(value: DragGesture.Value, index: Int) {
        if value.translation.height < 0 {
            viewModel.slides[index].offset = value.translation.height
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int) {
        if index == viewModel.slides.count - 1 {
            if -value.translation.height > 250 {
                viewModel.slides[index].offset = -UIScreen.main.bounds.height
                isClose = true
                viewModel.slides = []
                isOpenOnboarding = false
            } else {
                viewModel.slides[index].offset = 0
            }
          } else {
            withAnimation {
                if -value.translation.height > 250 {
                    viewModel.slides[index].offset = -UIScreen.main.bounds.height
                    viewModel.swipedSlides += 1
                    if index == 0 {
                        isInitial = false
                    }
                    currentIndex += 1
                } else {
                    viewModel.slides[index].offset = 0
                }
            }
        }
    }
    
    func nextButton() {
        withAnimation {
            viewModel.slides[currentIndex].offset = -UIScreen.main.bounds.height
        }
        viewModel.swipedSlides += 1
        if currentIndex == 0 {
            isInitial = false
        }
        currentIndex += 1
        
        if currentIndex == viewModel.slides.count {
        isClose = true
        viewModel.slides = []
            withAnimation(.linear(duration: 1)) {
                isOpenOnboarding = false
            }
        }
    }
    
    func previosButton() {
        withAnimation {
            viewModel.slides[currentIndex - 1].offset = 0
        }
        viewModel.swipedSlides -= 1
        if currentIndex == 1 {
            isInitial = true
        }
        currentIndex -= 1
    }
    
    func getWidth(index: Int) -> CGFloat {
        return  UIScreen.main.bounds.width - 80 - CGFloat(((index - viewModel.swipedSlides) * 20))
    }
   
    func getOffset(index: Int) -> CGFloat {
            return CGFloat((index - viewModel.swipedSlides) * 10)
    }
    
    func slideView(index: Int) -> some View {
        VStack {
            viewModel.slides[index].image
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
            
            Text(viewModel.slides[index].text)
                .frame(width: 240)
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            Spacer()
        }
        .frame(width: getWidth(index: index), height: 350)
        .padding(.top, 50)
        .background (
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .border(Color(uiColor: .systemGray5), width: 1)
        )
        .contentShape(Rectangle())
    }
}

#Preview {
    SlidesView(isOpenOnboarding: .constant(true))
}
