import SwiftUI
import UIKit

func write() async {
    print("write start", Thread.current)
    print("write end", Thread.current)
}

func read() async {
    print("read start", Thread.current)
    
    await write()
    
    print("read end", Thread.current)
}


//Task.detached {
//    print("task start", Thread.current)
//    
//    await read()
//    
//    print("task end", Thread.current)
//}

Task {
    print("task start", Thread.current)
    
    await read()
    
    print("task end", Thread.current)
}
