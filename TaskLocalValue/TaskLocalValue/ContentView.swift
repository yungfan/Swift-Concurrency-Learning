//
//  ContentView.swift
//  TaskLocalValue
//
//  Created by 杨帆 on 2021/9/27.
//

import SwiftUI

enum Storage {
    @TaskLocal static var name: String?
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    Storage.$name.withValue("zhangsan") {
                        Task {
                            print("task", Storage.name)
                        }

                        Task.detached {
                            print("detached",Storage.name)
                        }
                    }
                    
                    Task.detached {
                        Storage.$name.withValue("lisi") {
                            print("detached",Storage.name)
                        }
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
