//
//  ContentView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 11.03.2022.
//

import SwiftUI

struct RecorderView: View {
    @StateObject private var viewModel = RecorderViewModel()
    @State private var sliderValue = 5.0

    init() {
        setupNavigationBar()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.records, id: \.self) { record in
                    RecordCellView(sliderValue: $sliderValue)
                        .buttonStyle(PlainButtonStyle())
                }
                .navigationTitle("Диктофон")
                .listStyle(.plain)
                Button {
                    withAnimation(.default) {
                        viewModel.recordButtonAction()
                    }
                } label: {
                    Text("Запись")
                }
            }
        }
    }
}

extension RecorderView {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(displayP3Red: 229/255, green: 57/255, blue: 53/255, alpha: 1)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}
