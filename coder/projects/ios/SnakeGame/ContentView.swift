//
//  ContentView.swift
//  SnakeGame
//
//  主界面 - 支持触摸滑动控制
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameEngine = GameEngine()
    @State private var showStartScreen = true
    
    var body: some View {
        ZStack {
            // 背景
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 分数显示
                ScoreView(score: gameEngine.score, highScore: gameEngine.highScore)
                
                // 游戏区域 - 添加滑动手势
                GameBoardView(gameEngine: gameEngine)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 30)
                            .onEnded { value in
                                handleSwipe(value: value)
                            }
                    )
                
                // 控制按钮
                ControlView(gameEngine: gameEngine)
            }
            .padding()
            
            // 开始屏幕
            if showStartScreen || gameEngine.gameState == .gameOver {
                StartScreenView(
                    gameState: gameEngine.gameState,
                    score: gameEngine.score,
                    highScore: gameEngine.highScore,
                    onStart: {
                        withAnimation {
                            showStartScreen = false
                            gameEngine.startGame()
                        }
                    }
                )
            }
            
            // 暂停屏幕
            if gameEngine.gameState == .paused {
                PauseOverlayView(onResume: {
                    gameEngine.togglePause()
                })
            }
        }
    }
    
    // 处理滑动手势
    private func handleSwipe(value: DragGesture.Value) {
        let deltaX = value.translation.width
        let deltaY = value.translation.height
        
        // 判断是水平滑动还是垂直滑动
        if abs(deltaX) > abs(deltaY) {
            // 水平滑动
            if deltaX > 0 {
                gameEngine.changeDirection(to: .right)
            } else {
                gameEngine.changeDirection(to: .left)
            }
        } else {
            // 垂直滑动
            if deltaY > 0 {
                gameEngine.changeDirection(to: .down)
            } else {
                gameEngine.changeDirection(to: .up)
            }
        }
    }
}

// MARK: - 分数视图

struct ScoreView: View {
    let score: Int
    let highScore: Int
    
    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("得分")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(score)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            
            VStack {
                Text("最高分")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(highScore)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - 游戏面板视图

struct GameBoardView: View {
    @ObservedObject var gameEngine: GameEngine
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let cellSize = size / CGFloat(gameEngine.gridSize)
            
            ZStack {
                // 网格背景
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .border(Color.gray.opacity(0.3), width: 2)
                
                // 绘制蛇 - 直接遍历蛇身数组
                ForEach(Array(gameEngine.snake.body.enumerated()), id: \.offset) { index, segment in
                    let isHead = (index == 0)
                    Rectangle()
                        .fill(isHead ? Color.green : Color.green.opacity(0.7))
                        .frame(width: cellSize - 2, height: cellSize - 2)
                        .cornerRadius(isHead ? 4 : 3)
                        .position(
                            x: (segment.x + 0.5) * cellSize,
                            y: (segment.y + 0.5) * cellSize
                        )
                }
                
                // 绘制食物
                Circle()
                    .fill(Color.red)
                    .frame(width: cellSize - 4, height: cellSize - 4)
                    .shadow(color: .red, radius: 3)
                    .position(
                        x: (gameEngine.food.position.x + 0.5) * cellSize,
                        y: (gameEngine.food.position.y + 0.5) * cellSize
                    )
            }
            .aspectRatio(1, contentMode: .fit)
        }
        .frame(maxWidth: 400, maxHeight: 400)
    }
}

// MARK: - 控制视图

struct ControlView: View {
    @ObservedObject var gameEngine: GameEngine
    
    var body: some View {
        VStack(spacing: 10) {
            // 上
            DirectionButton(direction: .up) {
                gameEngine.changeDirection(to: .up)
            }
            
            HStack(spacing: 40) {
                // 左
                DirectionButton(direction: .left) {
                    gameEngine.changeDirection(to: .left)
                }
                
                // 暂停按钮
                Button(action: {
                    gameEngine.togglePause()
                }) {
                    Image(systemName: gameEngine.gameState == .paused ? "play.fill" : "pause.fill")
                        .font(.title2)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 右
                DirectionButton(direction: .right) {
                    gameEngine.changeDirection(to: .right)
                }
            }
            
            // 下
            DirectionButton(direction: .down) {
                gameEngine.changeDirection(to: .down)
            }
        }
    }
}

struct DirectionButton: View {
    let direction: Direction
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.title2)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    var iconName: String {
        switch direction {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .left: return "arrow.left"
        case .right: return "arrow.right"
        }
    }
}

// MARK: - 开始屏幕

struct StartScreenView: View {
    let gameState: GameState
    let score: Int
    let highScore: Int
    let onStart: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // 游戏标题
                Text("🐍 贪吃蛇")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                if gameState == .gameOver {
                    Text("游戏结束")
                        .font(.title)
                        .foregroundColor(.red)
                    
                    Text("得分：\(score)")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    if score >= highScore && score > 0 {
                        Text("🎉 新纪录！")
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                } else {
                    Text("经典休闲游戏")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // 开始按钮
                Button(action: onStart) {
                    Text(gameState == .gameOver ? "再玩一次" : "开始游戏")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                        .background(Color.green)
                        .cornerRadius(30)
                }
                
                // 说明
                Text("滑动屏幕或点击方向键控制")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - 暂停覆盖层

struct PauseOverlayView: View {
    let onResume: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("游戏暂停")
                    .font(.title)
                    .foregroundColor(.white)
                
                Button(action: onResume) {
                    Text("继续")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
