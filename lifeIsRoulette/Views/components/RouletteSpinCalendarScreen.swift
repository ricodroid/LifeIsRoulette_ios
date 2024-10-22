//
//  RouletteSpinCalendarScreen.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//
import SwiftUI

struct RouletteSpinCalendarScreen: View {
    @State private var spinDates: Set<Date> = []
    let calendar = Calendar.current
    let monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var body: some View {
        VStack {
            // ヘッダーに各月の名前を表示
            HStack {
                ForEach(monthNames, id: \.self) { month in
                    Text(month)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
            
            // カレンダーグリッド（12列×2行で表示）
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 12), spacing: 10) {
                // 各月の前半（1日〜15日）を表示
                ForEach(1...12, id: \.self) { month in
                    let daysInFirstHalf = getDaysInFirstHalf(for: month)
                    let color = calculateColor(for: daysInFirstHalf, totalDays: 15) // 1日〜15日を対象
                    BoxView(color: color)
                        .id("firstHalf-\(month)") // ユニークなidを指定
                }

                // 各月の後半（16日〜月末）を表示
                ForEach(1...12, id: \.self) { month in
                    let daysInSecondHalf = getDaysInSecondHalf(for: month)
                    let totalDaysInSecondHalf = daysInSecondHalf.count
                    let color = calculateColor(for: daysInSecondHalf, totalDays: totalDaysInSecondHalf) // 16日〜月末を対象
                    BoxView(color: color)
                        .id("secondHalf-\(month)") // ユニークなidを指定
                }
            }

            .padding()
        }
        .onAppear {
            // ルーレットを回した日付を読み込む
            loadSpinDates()
        }
    }
    
    // 各月の1日〜15日を取得
    func getDaysInFirstHalf(for month: Int) -> [Date] {
        let year = calendar.component(.year, from: Date())
        return (1...15).compactMap { day in
            return calendar.date(from: DateComponents(year: year, month: month, day: day))
        }
    }
    
    // 各月の16日〜月末を取得
    func getDaysInSecondHalf(for month: Int) -> [Date] {
        let year = calendar.component(.year, from: Date())
        let lastDay = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month))!)?.last ?? 30
        return (16...lastDay).compactMap { day in
            return calendar.date(from: DateComponents(year: year, month: month, day: day))
        }
    }
    
    // 指定した日付に基づいて色を計算
    func calculateColor(for dates: [Date], totalDays: Int) -> Color {
        let spinCount = dates.filter { spinDates.contains($0) }.count
        if spinCount == 0 {
           return Color.gray.opacity(0.1) // 0回の場合は薄いグレー
       }
        let colorIntensity = Double(spinCount) / Double(totalDays) // ルーレットを回した割合で色の濃さを決定
        return Color.orange.opacity(colorIntensity) // 回した割合に応じてオレンジ色を濃くする
    }
    
    // ユーザーがルーレットを回した日付を読み込む
    func loadSpinDates() {
        // SpinDateStorageを使って保存された日付を読み込む
        spinDates = SpinDateStorage.shared.loadSpinDates()
    }
}

struct BoxView: View {
    let color: Color

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 30, height: 30)
            .cornerRadius(4)
    }
}


//struct RouletteSpinCalendarScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        RouletteSpinCalendarScreen()
//    }
//}
