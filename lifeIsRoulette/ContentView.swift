//
//  ContentView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diaryListViewModel = DiaryListViewModel()  // StateObjectとして宣言

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("平日ルーレット", destination: WeekdayRouletteView())
                NavigationLink("休日ルーレット", destination: WeekendRouletteView())
                NavigationLink("Action", destination: ActionView())
                NavigationLink("日記一覧", destination: DiaryListView(diaryListViewModel: diaryListViewModel))  // diaryListViewModelを渡す
            }
            .navigationTitle("ルーレットメニュー")
        }
    }
}
