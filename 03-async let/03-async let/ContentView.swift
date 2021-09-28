//
//  ContentView.swift
//  03-async let
//
//  Created by 杨帆 on 2021/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    async let x =  generateNum1()
                    async let y =  generateNum2()
                    async let z =  generateNum3()
                    
                    await print(x + y + z)
                }
            }
    }

    func generateNum1() async -> Int {
        await Task.sleep(1 * 1000000000)
        print("1", Thread.current)
        return 1
    }

    func generateNum2() async -> Int {
        await Task.sleep(2 * 1000000000)
        print("2", Thread.current)
        return 2
    }

    func generateNum3() async -> Int {
        await Task.sleep(3 * 1000000000)
        print("3", Thread.current)
        return 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
