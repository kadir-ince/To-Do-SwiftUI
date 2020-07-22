//
//  ContentView.swift
//  Todo
//
//  Created by Kadir on 22.07.2020.
//  Copyright © 2020 Kadir. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var todoItem = ""
    @State private var setPriority = ""
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
                            //
                        }) {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                    Picker(selection: $setPriority, label: Text("")) {
                        Text("Hello").tag(0)
                        Text("Hello").tag(1)
                        Text("Hello").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    
                }.navigationBarTitle("Todo")
            }
        }.environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
