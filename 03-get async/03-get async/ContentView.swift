//
//  ContentView.swift
//  03-get async
//
//  Created by 杨帆 on 2021/9/25.
//

import SwiftUI

class Person {
    let name = "zhangsan"
    var bmi: Double {
        get async {
            await calBMI(height: 1.9, weight: 70)
        }
    }
    
    func calBMI(height: Double, weight: Double) async -> Double {
        weight / (height * height)
    }
}

struct ContentView: View {
    let p = Person()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    await print(p.bmi)
                }
            }
//            .task {
//                await print(p.bmi)
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
