//
//  WeekendRouletteView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct WeekendRouletteView: View {
    @StateObject var viewModel = WeekendRouletteViewModel()
    
    var body: some View {
        VStack {
            Text("休日ルーレット")
                .font(.largeTitle)
            
            List(viewModel.options) { option in
                Text(option.name)
            }
            
            Button(action: {
                viewModel.spinRoulette()
            }) {
                Text("ルーレットを回す")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
