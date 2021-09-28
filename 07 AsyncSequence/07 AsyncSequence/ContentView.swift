//
//  ContentView.swift
//  07 AsyncSequence
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                   try await getURLLine()
                }
            }
    }
    
    func getURLLine() async throws {
        let url = URL(string: "https://www.baidu.com")!
        
        for try await line in url.lines {
            await Task.sleep(1 * 1000000000)
            print(line)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
