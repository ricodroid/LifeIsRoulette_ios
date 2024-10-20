//
//  WeekdayRouletteView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct WeekdayRouletteView: View {
    @StateObject var viewModel = WeekdayRouletteViewModel()
    @State private var selectedSegment: RouletteSegment? = nil
    
    var body: some View {
        VStack {
            if let selectedSegment = selectedSegment {
                Text("選ばれた項目: \(selectedSegment.label)")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("ルーレットを回して項目を選択")
                    .font(.largeTitle)
                    .padding()
            }
            
            RouletteView(segments: viewModel.rouletteSegments, selectedSegment: $selectedSegment)
                .frame(width: 300, height: 300)
        
        }
    }
}
