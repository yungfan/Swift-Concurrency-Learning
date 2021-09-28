//
//  ContentView.swift
//  06 Continuations
//
//  Created by 杨帆 on 2021/9/28.
//

import SwiftUI

enum CustomError: Error {
    case nilError
}

struct ContentView: View {
    @State private var imageView: Image = Image(systemName: "heart")

    var body: some View {
        Text("Hello, world!")
            .padding()
//            .onAppear {
//                getImage { image, _ in
//                    if let img = image {
//                        imageView = Image(uiImage: img)
//                    }
//                }
//            }
        
            .onAppear {
                Task {
                    let image = try await getImage()
                    
                    imageView = Image(uiImage: image)
                }
            }

        imageView
            .resizable()
            .frame(width: 100, height: 100)
    }

    func getImage(completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let url = URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2718219500,1861579782&fm=26&gp=0.jpg")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data, let image = UIImage(data: data) else {
                completionHandler(nil, CustomError.nilError)
                return
            }

            completionHandler(image, nil)
        }

        task.resume()
    }
    
    func getImage() async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            getImage() { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let result = result else {
                    fatalError("Expected non-nil result 'result' for nil error")
                }
                continuation.resume(returning: result)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
