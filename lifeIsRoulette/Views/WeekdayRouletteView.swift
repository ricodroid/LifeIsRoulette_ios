//
//  WeekdayRouletteView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct WeekdayRouletteView: View {
    @StateObject var viewModel = WeekdayRouletteViewModel()
    
    var body: some View {
        VStack {
            Text("平日ルーレット")
                .font(.largeTitle)
            
            List(viewModel.options) { option in
                Text(option.name)
            }
            
            RouletteView().frame(width: 300, height: 300) 
            
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
