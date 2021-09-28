//
//  ContentView.swift
//  07 AsyncStream
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

class Normal {
    var cities = ["北京", "南京", "西安", "杭州", "广州"]

    func getCities() async -> [String] {
        var newArray = [String]()

        while !cities.isEmpty {
            sleep(1)
            newArray.append(cities.popLast()!)
        }

        return newArray
    }
}

class Async {
    var cities = ["北京", "南京", "西安", "杭州", "广州"]
    
    func getCities() -> AsyncStream<String> {
        AsyncStream { continuation in
            Task {
                while !cities.isEmpty {
                    sleep(1)
                    continuation.yield(cities.popLast()!)
                }
                
                continuation.finish()
            }
        }
    }
}

struct ContentView: View {
    let normal = Normal()
    let asyncCity = Async()
    var body: some View {
        Text("Hello, world!")
            .padding()
//            .onAppear {
//                Task {
//                    let cities = await normal.getCities()
//                    print(cities)
//                }
//            }
            .onAppear {
                Task {
                    let cities = asyncCity.getCities()
                    
                    for await city in cities {
                        print(city)
                    }
                    
                    print("执行完毕")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
