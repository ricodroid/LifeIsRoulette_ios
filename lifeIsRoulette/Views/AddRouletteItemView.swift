//
//  AddRouletteItem.swift
//  lifeIsRoulette
//
//  Created by riko on 2024/11/03.
//

import SwiftUICore
import SwiftUI

struct AddRouletteItemView: View {
    @StateObject private var viewModel = AddRouletteItemViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter item name", text: $viewModel.newItemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: viewModel.addItem) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
                .disabled(viewModel.newItemName.isEmpty)
            }
            .padding()

            Picker("Select List", selection: $viewModel.isWeekDay) {
                Text("WeekDay").tag(true)
                Text("WeekEnd").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List {
                if viewModel.isWeekDay {
                    ForEach(viewModel.weekDayItems) { item in
                        Text(item.name)
                    }
                    .onDelete { offsets in
                        viewModel.deleteItem(at: offsets, isWeekDayList: true)
                    }
                } else {
                    ForEach(viewModel.weekEndItems) { item in
                        Text(item.name)
                    }
                    .onDelete { offsets in
                        viewModel.deleteItem(at: offsets, isWeekDayList: false)
                    }
                }
            }
        }
    }
}
