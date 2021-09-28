//
//  ContentView.swift
//  04 TaskGroup-案例
//
//  Created by 杨帆 on 2021/9/27.
//

import SwiftUI

enum ResultType {
    case course, teacher
}

struct Student {
    var id: Int
    var resultTpye: ResultType
}

struct Course {
    var id: Int
}

struct Teacher {
    var id: Int
}

enum TaskResult {
    case course(Course)
    case teacher(Teacher)
}

struct ContentView: View {
    let students = [Student(id: 1, resultTpye: .course), Student(id: 2, resultTpye: .teacher), Student(id: 3, resultTpye: .course), Student(id: 4, resultTpye: .teacher)]

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    let result = await getStudentCourseAndTeacher(stus: students)
                    for item in result {
                        print(item)
                    }
                }
            }
    }

    func getCourse(id: Int) async -> Course {
        return Course(id: id)
    }

    func getTeacher(id: Int) async -> Teacher {
        return Teacher(id: id)
    }

    func getStudentCourseAndTeacher(stus: [Student]) async -> [TaskResult] {
        return await withTaskGroup(of: TaskResult.self) { group in

            for stu in stus {
                group.addTask {
                    switch stu.resultTpye {
                    case .course:
                        let course = await getCourse(id: stu.id)
                        return TaskResult.course(course)
                    case .teacher:
                        let teacher = await getTeacher(id: stu.id)
                        return TaskResult.teacher(teacher)
                    }
                }
            }
            var result = [TaskResult]()

            for await item in group {
                result.append(item)
            }

            return result
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
