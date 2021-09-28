//
//  ContentView.swift
//  04-TaskGroup
//
//  Created by 杨帆 on 2021/9/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    await group()
                }
            }
    }

    func group() async {
        await withTaskGroup(of: Int.self) { group in
            group.addTask(priority: .medium) {
                await generateNum1()
            }

            group.addTask {
                await generateNum2()
            }

            group.addTask {
                await generateNum3()
            }
            
            // 获取执行的结果
            var sum  = 0
            
            for await num in group {
                sum +=  num
            }
            
            print(sum)
        }
    }

    func generateNum1() async -> Int {
        await Task.sleep(1 * 1000000000)

        print(#function, Thread.current)

        return 1
    }

    func generateNum2() async -> Int {
        await Task.sleep(2 * 1000000000)

        print(#function, Thread.current)

        return 2
    }

    func generateNum3() async -> Int {
        await Task.sleep(3 * 1000000000)

        print(#function, Thread.current)

        return 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
