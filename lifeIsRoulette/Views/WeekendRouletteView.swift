//
//  WeekendRouletteView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct WeekendRouletteView: View {
    @StateObject var viewModel = WeekendRouletteViewModel()
    @State private var selectedSegment: RouletteSegment? = nil
    @State private var shouldNavigateToActionView = false
    
    var body: some View {
    
            VStack {
                RouletteSpinCalendarScreen()
                
                if let selectedSegment = selectedSegment {
                    Text("\(selectedSegment.label)")
                        .font(.largeTitle)
                        .padding()
                }
                
                RouletteView(segments: viewModel.rouletteSegments, shouldNavigateToActionView: $shouldNavigateToActionView, selectedSegment: $selectedSegment)
                    .frame(width: 300, height: 300)
                
                // ActionViewへの遷移リンク
                    .navigationDestination(isPresented: $shouldNavigateToActionView) {
                        ActionView(selectedSegment: selectedSegment)
                    }
            }

    }
}
