//
//  ContentView.swift
//  05 Data Race
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

actor Ticket {
    var tickets = 100
    
    func sellTicket() async {
        while true {
            guard tickets > 0 else {
                print("票已售罄")
                return
            }
            
            self.tickets -= 1
            
            print("卖出去一张票，还剩\(self.tickets)")
        }
    }
}

struct ContentView: View {
    let ticket = Ticket()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task.detached {
                    await ticket.sellTicket()
                }
                
                Task.detached {
                    await ticket.sellTicket()
                }
                
                Task.detached {
                    await ticket.sellTicket()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
