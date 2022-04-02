//
//  ContentView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 11.03.2022.
//

import SwiftUI

struct RecorderView: View {
    @StateObject private var viewModel = RecorderViewModel()
    @State private var cellID = UUID()
    
    init() {
        setupNavigationBar()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.records, id: \.self) { record in
                        RecordCellView(viewModel: record , cellID: $cellID)
                            .background(Color.white)  // Для того, чтобы можно было тапнуть по любому месту в ячейке
                            .buttonStyle(PlainButtonStyle())
                            .onTapGesture {
                                withAnimation {
                                    cellID = record.record.id
                                }
                            }
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
