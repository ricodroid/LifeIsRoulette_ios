//
//  RouletteView.swift
//  lifeIsRoulette
//
//  Created by riko on 2024/10/20.
//

import SwiftUI

struct RouletteSegment: Identifiable {
    var id = UUID()
    var number: Int
    var color: Color
}

struct RouletteView: View {
    let segments: [RouletteSegment] = [
        RouletteSegment(number: 1, color: .yellow),
        RouletteSegment(number: 2, color: .orange),
        RouletteSegment(number: 3, color: .red),
        RouletteSegment(number: 4, color: .pink),
        RouletteSegment(number: 5, color: .purple),
        RouletteSegment(number: 6, color: .blue),
        RouletteSegment(number: 7, color: .cyan),
        RouletteSegment(number: 8, color: .green),
        RouletteSegment(number: 9, color: .mint)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            ZStack {
                ForEach(segments.indices, id: \.self) { index in
                    let startAngle = Angle.degrees(Double(index) / Double(segments.count) * 360)
                    let endAngle = Angle.degrees(Double(index + 1) / Double(segments.count) * 360)
                    let path = Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    }
                    path
                        .fill(segments[index].color)
                        .overlay(
                            path.stroke(Color.black, lineWidth: 2)
                        )
                    
                    // Add the number label
                    let angle = startAngle + (endAngle - startAngle) / 2
                    let labelRadius = radius * 0.7
                    let xOffset = center.x + cos(CGFloat(angle.radians)) * labelRadius
                    let yOffset = center.y + sin(CGFloat(angle.radians)) * labelRadius
                    
                    Text("\(segments[index].number)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .position(x: xOffset, y: yOffset)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
