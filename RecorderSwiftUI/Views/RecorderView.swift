//
//  ContentView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 11.03.2022.
//

import SwiftUI

struct RecorderView: View {
    @StateObject private var viewModel = RecorderViewModel()

    init() {
        setupNavigationBar()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.records, id: \.self) { record in
                        RecordCellView(viewModel: record)
                            .buttonStyle(PlainButtonStyle())
                        Divider().background(Color.sh_basicGrey)
                            .padding(EdgeInsets(top: 22, leading: 18, bottom: 0, trailing: 0))
                    }
                    .navigationTitle("Диктофон")
//                .listStyle(.plain)
                }
                Spacer()
                Button {
                    withAnimation(.default) {
                        viewModel.recordButtonAction()
                    }
                } label: {
                    Text(viewModel.isRecord ? "Стоп" : "Запись")
                }
            }
            .padding(.top, 13)
        }
        .navigationViewStyle(.stack)
    }
}

extension RecorderView {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(Color.sh_basicRed)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}

    
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecorderView()
//    }
//}
