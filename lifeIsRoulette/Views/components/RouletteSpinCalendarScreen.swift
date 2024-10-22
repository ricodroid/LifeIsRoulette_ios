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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 12), spacing: 10) { // ← 12列設定
                // 各月の前半（1日〜15日）を表示
                ForEach(1...12, id: \.self) { month in
                    let daysInFirstHalf = getDaysInFirstHalf(for: month)
                    let color = calculateColor(for: daysInFirstHalf)
                    BoxView(color: color)
                }
                
                // 各月の後半（16日〜月末）を表示
                ForEach(1...12, id: \.self) { month in
                    let daysInSecondHalf = getDaysInSecondHalf(for: month)
                    let color = calculateColor(for: daysInSecondHalf)
                    BoxView(color: color)
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
    func calculateColor(for dates: [Date]) -> Color {
        let spinCount = dates.filter { spinDates.contains($0) }.count
        return spinCount > 0 ? Color.orange : Color.gray.opacity(0.3)  // デフォルトは薄いグレー、回した日付はオレンジ
    }
    
    // ユーザーがルーレットを回した日付を読み込む
    func loadSpinDates() {
        // 保存した日付のデータを取得（ここでは仮のデータ）
        // todo ルーレットを回すたびに日付を端末内に保存するようにする
        spinDates = [
            calendar.date(from: DateComponents(year: 2024, month: 1, day: 5))!,
            calendar.date(from: DateComponents(year: 2024, month: 1, day: 18))!,
        ]
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
