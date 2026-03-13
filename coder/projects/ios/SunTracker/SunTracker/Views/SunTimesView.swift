//
//  SunTimesView.swift
//  SunTracker
//
//  日出日落时间视图
//

import SwiftUI
import CoreLocation

struct SunTimesView: View {
    @EnvironmentObject var locationManager: LocationService
    @State private var sunEvents: SunEvents?
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 日期选择器
                DatePickerView(selectedDate: $selectedDate, showDatePicker: $showDatePicker)
                
                // 日出日落卡片
                if let events = sunEvents {
                    SunEventsCardsView(events: events)
                    
                    // 黄金时刻
                    GoldenHourView(events: events)
                    
                    // 白天时长进度条
                    DaylightProgressView(events: events)
                } else {
                    VStack {
                        ProgressView()
                        Text("计算中...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                }
                
                // 未来几天预览
                WeekPreviewView(baseDate: selectedDate)
            }
            .padding()
        }
        .navigationTitle("日出日落")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear {
            updateSunEvents()
        }
        .onChange(of: selectedDate) { _ in
            updateSunEvents()
        }
        .onChange(of: locationManager.currentLocation) { _ in
            updateSunEvents()
        }
    }
    
    private func updateSunEvents() {
        guard let lat = locationManager.latitude,
              let lon = locationManager.longitude else {
            return
        }
        
        let sunTimes = Astronomy.calculateSunTimes(
            date: selectedDate,
            latitude: lat,
            longitude: lon
        )
        
        let goldenHour = Astronomy.calculateGoldenHour(
            date: selectedDate,
            latitude: lat,
            longitude: lon
        )
        
        // 计算太阳正午
        var noonComponents = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        noonComponents.hour = 12
        let solarNoon = Calendar.current.date(from: noonComponents)
        
        sunEvents = SunEvents(
            date: selectedDate,
            sunrise: sunTimes.sunrise,
            sunset: sunTimes.sunset,
            solarNoon: solarNoon,
            goldenHourMorning: (goldenHour.morningStart, goldenHour.morningEnd),
            goldenHourEvening: (goldenHour.eveningStart, goldenHour.eveningEnd)
        )
    }
}

// MARK: - 日期选择器视图

struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: { showDatePicker.toggle() }) {
                HStack {
                    Image(systemName: "calendar")
                    Text(dateFormatter.string(from: selectedDate))
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            
            if showDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: ...Date().addingTimeInterval(365 * 24 * 3600),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        return formatter
    }
}

// MARK: - 日出日落卡片

struct SunEventsCardsView: View {
    let events: SunEvents
    
    var body: some View {
        HStack(spacing: 16) {
            // 日出卡片
            EventCardView(
                title: "日出",
                time: events.sunriseString,
                icon: "sunrise.fill",
                gradient: LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            // 日落卡片
            EventCardView(
                title: "日落",
                time: events.sunsetString,
                icon: "sunset.fill",
                gradient: LinearGradient(
                    colors: [.orange, .red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        
        // 白天时长
        HStack {
            Image(systemName: "clock.fill")
                .foregroundColor(.blue)
            Text("白天时长：\(events.daylightDuration)")
                .font(.caption)
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

struct EventCardView: View {
    let title: String
    let time: String
    let icon: String
    let gradient: LinearGradient
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))
            
            Text(time)
                .font(.title2.bold())
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(gradient)
        .cornerRadius(16)
    }
}

// MARK: - 黄金时刻视图

struct GoldenHourView: View {
    let events: SunEvents
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📸 黄金时刻")
                .font(.headline)
            
            HStack(spacing: 16) {
                GoldenHourPeriodView(
                    title: "早晨",
                    start: events.goldenHourMorning.start,
                    end: events.goldenHourMorning.end,
                    icon: "sunrise"
                )
                
                GoldenHourPeriodView(
                    title: "傍晚",
                    start: events.goldenHourEvening.start,
                    end: events.goldenHourEvening.end,
                    icon: "sunset"
                )
            }
            
            Text("黄金时刻是摄影的最佳光线时间")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

struct GoldenHourPeriodView: View {
    let title: String
    let start: Date?
    let end: Date?
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
            
            Text(title)
                .font(.caption)
            
            if let start = start, let end = end {
                Text("\(formatTime(start)) - \(formatTime(end))")
                    .font(.caption.bold())
            } else {
                Text("—")
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - 白天进度条

struct DaylightProgressView: View {
    let events: SunEvents
    @State private var currentTime: Date = Date()
    @State private var timer: Timer?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("今天")
                    .font(.caption)
                Spacer()
                Text(currentTimeString)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // 背景
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 12)
                    
                    // 进度
                    RoundedRectangle(cornerRadius: 8)
                        .fill(daylightGradient)
                        .frame(width: progressWidth(geometry: geometry), height: 12)
                    
                    // 当前时间标记
                    if let sunrise = events.sunrise,
                       let sunset = events.sunset,
                       currentTime >= sunrise && currentTime <= sunset {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                            .shadow(radius: 2)
                            .offset(x: progressWidth(geometry: geometry) - 8)
                    }
                }
            }
            .frame(height: 12)
            
            HStack {
                Text("日出")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("日落")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                currentTime = Date()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var currentTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: currentTime)
    }
    
    private var daylightGradient: LinearGradient {
        LinearGradient(
            colors: [.yellow, .orange, .red],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private func progressWidth(geometry: GeometryProxy) -> CGFloat {
        guard let sunrise = events.sunrise,
              let sunset = events.sunset else {
            return 0
        }
        
        let totalDuration = sunset.timeIntervalSince(sunrise)
        
        // 避免除以零
        guard totalDuration > 0 else {
            return 0
        }
        
        let elapsed = currentTime.timeIntervalSince(sunrise)
        
        // 计算进度比例 (0.0 - 1.0)
        let progress = elapsed / totalDuration
        
        // 限制进度在有效范围内
        let clampedProgress = min(max(progress, 0.0), 1.0)
        
        // 计算宽度，确保在有效范围内
        let maxWidth = max(geometry.size.width, 0)
        let width = clampedProgress * maxWidth
        
        // 确保宽度在 0 到 maxWidth 之间
        return min(max(width, 0), maxWidth)
    }
}

// MARK: - 周预览视图

struct WeekPreviewView: View {
    let baseDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("未来几天")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<7) { day in
                        if let date = Calendar.current.date(byAdding: .day, value: day + 1, to: baseDate) {
                            DayPreviewCard(date: date)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct DayPreviewCard: View {
    let date: Date
    @EnvironmentObject var locationManager: LocationService
    
    private var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayName)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(dateString)
                .font(.headline)
            
            // 这里可以添加简化的日出日落时间
            VStack(spacing: 4) {
                HStack {
                    Image(systemName: "sunrise.fill")
                        .font(.caption)
                    Text("06:30")
                        .font(.caption2)
                }
                
                HStack {
                    Image(systemName: "sunset.fill")
                        .font(.caption)
                    Text("18:00")
                        .font(.caption2)
                }
            }
            .foregroundColor(.secondary)
        }
        .frame(width: 80, height: 100)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
