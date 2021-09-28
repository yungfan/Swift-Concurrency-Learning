//
//  ContentView.swift
//  05 actor 隔离
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

actor StationA {
    var ticket = 10000
    
    func sellA() {
        print(ticket)
        
        ticket -= 1
    }
    
    func sellB() async {
        print(ticket)
        
        ticket -= 2
    }
}


actor StationB {
    func sellTA(stationA: isolated StationA) {
        stationA.ticket
        stationA.sellA()
    }
    
    func sellTB(stationA: StationA) async {
        print(await stationA.ticket)
        await stationA.sellB()
    }
}



struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
