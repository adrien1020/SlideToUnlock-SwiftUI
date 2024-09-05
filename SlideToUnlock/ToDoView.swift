//
//  ToDoView.swift
//  SlideToUnlock
//
//  Created by Adrien Surugue on 04/09/2024.
//

import SwiftUI

struct ToDoItem: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool
}

struct ToDoView: View {
    
    @State private var soonerItems = [
        ToDoItem(title: "Finish the project report", isCompleted: false),
        ToDoItem(title: "Send follow-up email to the client", isCompleted: false),
        ToDoItem(title: "Review the presentation for tomorrow's meeting", isCompleted: false),
        ToDoItem(title: "Organize the office", isCompleted: false),
        ToDoItem(title: "Do the grocery shopping for the week", isCompleted: false)
    ]

    @State private var laterItems = [
        ToDoItem(title: "Plan the summer vacation", isCompleted: false),
        ToDoItem(title: "Read the book recommended by a friend", isCompleted: false),
        ToDoItem(title: "Review personal finances", isCompleted: false),
        ToDoItem(title: "Update the online portfolio", isCompleted: false),
        ToDoItem(title: "Learn a new skill online", isCompleted: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sooner")) {
                    ForEach($soonerItems) { $item in
                        HStack {
                            Button(action: {
                                item.isCompleted.toggle()
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                    .foregroundStyle(Color(red: 1.0, green: 0.76, blue: 0.3))
                            }
                            Text(item.title)
                                .bold()
                                .strikethrough(item.isCompleted, color: .gray)
                                .foregroundColor(item.isCompleted ? .gray : .primary)
                        }
                    }
                }
                
                Section(header: Text("Later")) {
                    ForEach($laterItems) { $item in
                        HStack {
                            Button(action: {
                                item.isCompleted.toggle()
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                    .foregroundStyle(Color(red: 1.0, green: 0.76, blue: 0.3))
                            }
                            Text(item.title)
                                .bold()
                                .strikethrough(item.isCompleted, color: .gray)
                                .foregroundColor(item.isCompleted ? .gray : .primary)
                        }
                    }
                }
            }
            .navigationTitle("To-Do List")
            
        }
    }
}


#Preview {
    ToDoView()
}
