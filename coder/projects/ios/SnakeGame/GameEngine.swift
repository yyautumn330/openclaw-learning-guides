//
//  GameEngine.swift
//  SnakeGame
//
//  游戏引擎 - 核心逻辑
//

import Foundation
import CoreGraphics
import Combine

/// 游戏引擎
class GameEngine: ObservableObject {
    // MARK: - Published Properties
    
    @Published var snake: Snake
    @Published var food: Food
    @Published var gameState: GameState = .ready
    @Published var score: Int = 0
    @Published var highScore: Int = 0
    
    // MARK: - Constants
    
    let gridSize = 20
    let initialSpeed: Double = 0.3
    
    // MARK: - Private Properties
    
    private var gameTimer: Timer?
    private var speed: Double
    private var nextDirection: Direction = .right
    
    // MARK: - Initialization
    
    init() {
        self.snake = Snake(
            body: [CGPoint(x: 5, y: 10), CGPoint(x: 4, y: 10), CGPoint(x: 3, y: 10)],
            direction: .right
        )
        self.food = Food(position: CGPoint(x: 15, y: 10))
        self.speed = 0.3
        self.nextDirection = .right
        
        // 加载最高分
        self.highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    // MARK: - Game Control
    
    /// 开始游戏
    func startGame() {
        print("🎮 游戏开始！")
        resetGame()
        gameState = .playing
        startTimer()
    }
    
    /// 重置游戏
    func resetGame() {
        print("🔄 重置游戏")
        snake = Snake(
            body: [CGPoint(x: 5, y: 10), CGPoint(x: 4, y: 10), CGPoint(x: 3, y: 10)],
            direction: .right
        )
        food = Food(position: randomFoodPosition())
        score = 0
        speed = initialSpeed
        nextDirection = .right
        stopTimer()
    }
    
    /// 暂停/继续游戏
    func togglePause() {
        if gameState == .playing {
            gameState = .paused
            stopTimer()
            print("⏸️ 游戏暂停")
        } else if gameState == .paused {
            gameState = .playing
            startTimer()
            print("▶️ 游戏继续")
        }
    }
    
    /// 结束游戏
    func endGame() {
        print("💀 游戏结束！得分：\(score)")
        gameState = .gameOver
        stopTimer()
        
        // 更新最高分
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScore")
        }
    }
    
    // MARK: - Timer Management
    
    private func startTimer() {
        stopTimer() // 先停止旧的定时器
        
        print("⏱️ 启动定时器，速度：\(speed)秒")
        
        // 使用 RunLoop.main 确保定时器在主线程运行
        gameTimer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { [weak self] timer in
            print("⏰ Timer 触发")
            DispatchQueue.main.async {
                self?.update()
            }
        }
        
        // 确保 Timer 添加到 RunLoop
        RunLoop.main.add(gameTimer!, forMode: .common)
    }
    
    private func stopTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
        print("⏹️ 定时器停止")
    }
    
    // MARK: - Game Loop
    
    /// 更新游戏状态
    private func update() {
        print("🔄 更新游戏状态 - 蛇头位置：\(snake.head)")
        
        // 更新方向
        snake.direction = nextDirection
        
        // 移动蛇
        snake.move()
        
        // 检查碰撞
        if snake.checkWallCollision(gridSize: gridSize) || snake.checkSelfCollision() {
            endGame()
            return
        }
        
        // 检查是否吃到食物
        if snake.head == food.position {
            print("🍎 吃到食物！")
            snake.grow()
            score += 10
            food.position = randomFoodPosition()
            
            // 加速
            if speed > 0.1 {
                speed -= 0.01
                stopTimer()
                startTimer()
            }
        }
    }
    
    // MARK: - Input Handling
    
    /// 改变方向
    func changeDirection(to newDirection: Direction) {
        print("⬅️ 改变方向：\(newDirection)")
        // 不能直接掉头
        if !newDirection.isOpposite(to: snake.direction) {
            nextDirection = newDirection
        }
    }
    
    // MARK: - Helper Methods
    
    /// 生成随机食物位置（不能生成在蛇身上）
    private func randomFoodPosition() -> CGPoint {
        var position: CGPoint
        
        repeat {
            position = CGPoint(
                x: CGFloat(Int.random(in: 0..<gridSize)),
                y: CGFloat(Int.random(in: 0..<gridSize))
            )
        } while snake.contains(position)
        
        return position
    }
    
    /// 检查某个位置是否是蛇身
    func isSnakeBody(at position: CGPoint) -> Bool {
        return snake.contains(position)
    }
    
    /// 检查某个位置是否是蛇头
    func isSnakeHead(at position: CGPoint) -> Bool {
        return snake.head == position
    }
}
