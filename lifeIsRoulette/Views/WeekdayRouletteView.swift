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
    @State private var shouldNavigateToActionView = false
    @ObservedObject var rouletteViewModel: WeekdayRouletteViewModel
    
    var body: some View {
        RouletteSpinCalendarScreen()
        
        VStack {
            if let selectedSegment = selectedSegment {
                Text("\(selectedSegment.label)")
                    .font(.largeTitle)
                    .padding()
            }
            
            RouletteView(segments: viewModel.rouletteSegments, shouldNavigateToActionView: $shouldNavigateToActionView, selectedSegment: $selectedSegment)
                .frame(width: 300, height: 300)
            
                // ここにActionViewへの遷移が含まれる
                .navigationDestination(isPresented: $shouldNavigateToActionView) {
                    ActionView(selectedSegment: selectedSegment, rouletteViewModel: rouletteViewModel)
                }
        }
    }
}
