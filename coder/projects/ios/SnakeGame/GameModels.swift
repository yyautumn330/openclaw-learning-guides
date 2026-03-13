//
//  GameModels.swift
//  SnakeGame
//
//  游戏核心数据模型
//

import Foundation
import CoreGraphics

/// 方向枚举
enum Direction {
    case up, down, left, right
    
    /// 获取下一个位置
    func next(from position: CGPoint, gridSize: Int) -> CGPoint {
        switch self {
        case .up:
            return CGPoint(x: position.x, y: position.y - 1)
        case .down:
            return CGPoint(x: position.x, y: position.y + 1)
        case .left:
            return CGPoint(x: position.x - 1, y: position.y)
        case .right:
            return CGPoint(x: position.x + 1, y: position.y)
        }
    }
    
    /// 判断是否是相反方向
    func isOpposite(to other: Direction) -> Bool {
        switch (self, other) {
        case (.up, .down), (.down, .up):
            return true
        case (.left, .right), (.right, .left):
            return true
        default:
            return false
        }
    }
}

/// 游戏状态
enum GameState {
    case ready      // 准备开始
    case playing    // 游戏中
    case paused     // 暂停
    case gameOver   // 游戏结束
}

/// 蛇的数据结构
struct Snake {
    var body: [CGPoint]      // 蛇身，第一个元素是头部
    var direction: Direction // 当前方向
    
    /// 头部位置
    var head: CGPoint {
        body.first ?? CGPoint(x: 5, y: 5)
    }
    
    /// 移动蛇
    mutating func move() {
        let newHead = direction.next(from: head, gridSize: 20)
        body.insert(newHead, at: 0)
        body.removeLast()
    }
    
    /// 增长蛇（吃食物时）
    mutating func grow() {
        let tail = body.last ?? CGPoint(x: 5, y: 5)
        body.append(tail)
    }
    
    /// 检查是否撞到自己
    func checkSelfCollision() -> Bool {
        let head = self.head
        return body.dropFirst().contains { point in
            point.x == head.x && point.y == head.y
        }
    }
    
    /// 检查是否撞墙
    func checkWallCollision(gridSize: Int) -> Bool {
        let head = self.head
        return head.x < 0 || head.x >= CGFloat(gridSize) || head.y < 0 || head.y >= CGFloat(gridSize)
    }
    
    /// 检查位置是否在蛇身上
    func contains(_ position: CGPoint) -> Bool {
        return body.contains { point in
            point.x == position.x && point.y == position.y
        }
    }
}

/// 食物
struct Food {
    var position: CGPoint
}
