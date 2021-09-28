//
//  ContentView.swift
//  05 MainActor
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

class Model {
    @MainActor
    func method1() async {
        print("处理任务1", Thread.current)
    }
    
    func method2() {
        print("处理任务2", Thread.current)
    }
    
    func method3() async {
        print("处理任务3", Thread.current)
    }
}

struct ContentView: View {
    let model = Model()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task.detached {
                   await model.method1()
                }
                
                Task.detached {
                    await MainActor.run {
                        self.model.method2()
                    }
                }
                
                Task.detached { @MainActor in
                    await self.model.method3()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
