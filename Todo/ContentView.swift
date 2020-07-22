//
//  ContentView.swift
//  Todo
//
//  Created by Kadir on 22.07.2020.
//  Copyright © 2020 Kadir. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var todoItem = ""
    @State private var setPriority = ""

    @FetchRequest(entity: ToDoList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.createdAt, ascending: false)])
    var fetchedItems: FetchedResults<ToDoList>
    var body: some View {
        VStack {
            NavigationView {
                List {
                    HStack {
                        TextField("Enter an item", text: $todoItem)
                            .padding(.all, 2)
                            .font(.system(size: 25, design: .default))
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            guard self.todoItem != "" else { return }
                            let ToDoItem = ToDoList(context: self.managedObjectContext)
                            ToDoItem.item = self.todoItem
                            ToDoItem.createdAt = Date()
                            ToDoItem.priority = self.setPriority
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            self.todoItem = ""
                        }) {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                    Picker(selection: $setPriority, label: Text("")) {
                        Text("No Hurry ").tag("🥱")
                        Text("Normal").tag("📜")
                        Text("Hurry Up").tag("🚀")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    ForEach(fetchedItems, id: \.self) { toDoItems in
                        ItemRowView(item: toDoItems.item ?? "Empty", createAt: stringFromDate(toDoItems.createdAt!), priority: toDoItems.priority ?? "Empty")

                    }.onDelete(perform: removeItem)
                }
                .navigationBarTitle("Todo")
                .navigationBarItems(trailing: EditButton())
            }
        }.environment(\.colorScheme, .dark)
    }

    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let item = fetchedItems[index]
            managedObjectContext.delete(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



func stringFromDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
    return formatter.string(from: date)
}
