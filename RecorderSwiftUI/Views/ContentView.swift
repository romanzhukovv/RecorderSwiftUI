//
//  ContentView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 11.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = 5.0
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(displayP3Red: 229/255, green: 57/255, blue: 53/255, alpha: 1)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.white

    }
    
    var body: some View {
        NavigationView {
            List {
                RecordCellView(sliderValue: $sliderValue)
                RecordCellView(sliderValue: $sliderValue)
            }
            .navigationTitle("Диктофон")
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
