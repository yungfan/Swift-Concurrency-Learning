//
//  ContentView.swift
//  04-Task
//
//  Created by 杨帆 on 2021/9/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                drink()
                
                eat()
            }
    }
    
    func drink() {
        DispatchQueue.main.async {
            Task {
                print("drink", Thread.current)
            }
        }
    }
    
    func eat() {
        DispatchQueue.main.async {
            Task.detached {
                print("eat", Thread.current)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
