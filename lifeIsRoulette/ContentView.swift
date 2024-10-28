//
//  ContentView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diaryListViewModel = DiaryListViewModel()  // StateObjectとして宣言
    @StateObject var weekdayRouletteViewModel = WeekdayRouletteViewModel()  // WeekdayRouletteViewModelを追加
    @StateObject var weekendRouletteViewModel = WeekendRouletteViewModel()  // WeekendRouletteViewModelを追加

    var body: some View {
        NavigationStack {
            VStack {
                // WeekdayRouletteViewにweekdayRouletteViewModelを渡す
                NavigationLink("平日ルーレット", destination: WeekdayRouletteView(rouletteViewModel: weekdayRouletteViewModel))
                // WeekendRouletteViewにweekendRouletteViewModelを渡す
                NavigationLink("休日ルーレット", destination: WeekendRouletteView(rouletteViewModel: weekendRouletteViewModel))
                // ActionViewにweekdayRouletteViewModelを渡す
                NavigationLink("Action", destination: ActionView(selectedSegment: nil, rouletteViewModel: weekdayRouletteViewModel))
                // 日記一覧画面
                NavigationLink("日記一覧", destination: DiaryListView(diaryListViewModel: diaryListViewModel))  // diaryListViewModelを渡す
            }
            .navigationTitle("ルーレットメニュー")
        }
    }
}
