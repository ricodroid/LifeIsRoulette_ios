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
    let segments: [RouletteSegment]
    @Binding var selectedSegment: RouletteSegment?
    @State private var rotation: Double = 0
    @State private var isSpinning = false
    
    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                // ルーレットの描画
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
            .rotationEffect(.degrees(rotation))
            .animation(isSpinning ? .easeOut(duration: 3) : .none, value: rotation)
            .onTapGesture {
                spinRoulette()
            }
            
            // ポインターの描画 (固定で表示される)
            TrianglePointer()
                .fill(Color.black)
                .frame(width: 20, height: 20)
                .position(x: geometry.size.width - 10, y: geometry.size.height / 2)
        }
    }
    
    func spinRoulette() {
        isSpinning = true
        let randomRotation = Double.random(in: 720...1080) // 2〜3回転
        withAnimation {
            rotation += randomRotation
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isSpinning = false
            // ポインターの位置でセグメントを選ぶロジック
            let pointerAngle = 0.0 // 3時の方向
            let totalRotation = rotation.truncatingRemainder(dividingBy: 360)
            let segmentAngle = 360.0 / Double(segments.count)
            
            let correctedRotation = totalRotation - pointerAngle
            let selectedIndex = Int((360 - correctedRotation).truncatingRemainder(dividingBy: 360) / segmentAngle)
            
            selectedSegment = segments[selectedIndex >= 0 ? selectedIndex : (selectedIndex + segments.count) % segments.count]
        }
    }
}

struct TrianglePointer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY)) // 左側の頂点
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // 上の頂点（底辺より長め）
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 下の頂点（底辺より長め）
        path.closeSubpath()
        return path
    }
}
