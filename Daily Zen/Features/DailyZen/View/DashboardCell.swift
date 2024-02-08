//
//  DashboardCell.swift
//  ToDo
//
//  Created by deq on 27/12/23.
//

import SwiftUI

struct DashboardCell: View {
    let task: TaskDetail
    
    var body: some View {
        Text(task.title)
            .background {
                NavigationLink(
                    "",
                    destination: NavigationLazyView(
                        TaskDetailView(
                            viewModel: TaskDetailViewModel(
                                taskDetail: task,
                                isNewTask: false)
                        )
                    )
                )
                .opacity(0)
            }
    }
}

//struct DashboardCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardCell(task: sampleTask)
//    }
//}
