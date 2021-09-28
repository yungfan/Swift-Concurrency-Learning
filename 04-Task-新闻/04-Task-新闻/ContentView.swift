//
//  ContentView.swift
//  04-Task-新闻
//
//  Created by 杨帆 on 2021/9/27.
//

import SwiftUI

struct NewsModel: Codable {
    var reason: String
    var error_code: Int
    var result: Result
}

struct Result: Codable {
    var stat: String
    var data: [DataItem]
}

struct DataItem: Codable {
    var title: String
    var date: String
    var category: String
    var author_name: String
    var url: String
}

// http://v.juhe.cn/toutiao/index?type=top&key=d1287290b45a69656de361382bc56dcd

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    await getNews()
                }
            }
    }
    
    
    func getNews() async {
        let task = Task(priority: .high) { () -> NewsModel in
            let url = URL(string: "http://v.juhe.cn/toutiao/index?type=top&key=d1287290b45a69656de361382bc56dcd")!
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            let newsModel = try? JSONDecoder().decode(NewsModel.self, from: data)
            
            return newsModel!
        }
        
//        let res =  try? await task.value
//        print(res?.result.data.first?.title)
        
        let res = await task.result
        
        let value = try? res.get()
        
        print(value?.result.data.first?.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
