//
//  ContentView.swift
//  SlideToUnlock
//
//  Created by Adrien Surugue on 02/09/2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var offset : CGFloat = 0.0
    @State private var progress: CGFloat = 0
    @State private var angle = 5.0
    @State private var isShowToDoList = false
    private let maxLimit :CGFloat = 50.0
    var body: some View {
        NavigationStack{
            VStack(spacing: 40){
                ZStack{
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundStyle(Color(red: 1.0, green: 1.0, blue: 0.9))
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-(angle)), anchor: .bottomTrailing)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: -3, y: 3)
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundStyle(Color(red: 1.0, green: 1.0, blue: 0.85))
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(angle), anchor: .bottomTrailing)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: -2, y: 2)
                    Rectangle()
                        .fill(Color(red: 1.0, green: 1.0, blue: 0.85))
                        .frame(width: 90, height: 90)
                        .overlay(
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(red: 1.0, green: 0.9, blue: 0.6), lineWidth: 8)
                                RoundedRectangle(cornerRadius: 25)
                                    .trim(from: 0, to: progress/maxLimit)
                                    .stroke(Color(red: 1.0, green: 0.76, blue: 0.3), style: StrokeStyle(lineWidth: 8, lineCap: .butt))
                            }
                        )
                        .rotationEffect(.degrees(angle), anchor: .bottomTrailing)
                    Image(systemName: "checkmark")
                        .bold()
                        .rotationEffect(.degrees(angle), anchor: .bottomTrailing)
                        .font(.system(size: 50))
                }
                VStack(spacing:20){
                    Text("Welcome to To-Do List")
                        .fontWeight(.heavy)
                        .font(.title)
                    HStack{
                        Text("Slide to Unlock")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                            .font(.title3)
                        Image(systemName: "arrow.right")
                            .bold()
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                    }
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation(.linear){
                                    offset = min(max(gesture.translation.width, 0), maxLimit)
                                    progress = offset
                                }
                            }
                            .onEnded { ended in
                                withAnimation(){
                                    if offset == maxLimit {
                                        offset = 0
                                        angle = 0
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                                            isShowToDoList = true
                                            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                                progress = 0
                                                angle = 5
                                            })
                                        })
                                    } else {
                                        offset = 0
                                        progress = offset
                                    }
                                }
                            })
                }
            }
            .padding()
            .navigationDestination(isPresented: $isShowToDoList){
                ToDoView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    ContentView()
}
