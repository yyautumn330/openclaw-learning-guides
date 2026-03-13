//
//  Solar3DView.swift
//  SunTracker
//
//  3D 太阳位置可视化
//

import SwiftUI
#if os(iOS)
import SceneKit
#endif
import CoreLocation

struct Solar3DView: View {
    @EnvironmentObject var locationManager: LocationService
    @State private var solarPosition: SolarPosition?
    @State private var sunEvents: SunEvents?
    @State private var currentTime = Date()
    @State private var selectedDate = Date()
    @State private var timer: Timer?
    @State private var showPath = true
    @State private var autoRotate = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SkyGradientView()
                
                #if os(iOS)
                EnhancedSolarSceneView(
                    solarPosition: solarPosition,
                    currentTime: currentTime,
                    showPath: showPath,
                    autoRotate: autoRotate
                )
                #else
                MacSolarView(solarPosition: solarPosition)
                #endif
                
                SolarOverlayView(solarPosition: solarPosition, currentTime: currentTime)
            }
            .frame(height: 450)
            
            ControlPanelView(
                showPath: $showPath,
                autoRotate: $autoRotate
            )
            
            TimeAndDataPanelView(
                solarPosition: solarPosition,
                sunEvents: sunEvents,
                currentTime: $currentTime
            )
        }
        .navigationTitle("3D 太阳轨迹")
        .onChange(of: currentTime) { _ in
            updateSolarData()
        }
        .onAppear {
            startUpdates()
        }
        .onDisappear {
            stopUpdates()
        }
    }
    
    private func startUpdates() {
        updateSolarData()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date()
            updateSolarData()
        }
    }
    
    private func stopUpdates() {
        timer?.invalidate()
    }
    
    private func updateSolarData() {
        guard let lat = locationManager.latitude,
              let lon = locationManager.longitude else {
            return
        }
        
        // 计算当前滑块时间的太阳位置
        let position = Astronomy.calculateSolarPosition(
            date: currentTime,
            latitude: lat,
            longitude: lon
        )
        
        solarPosition = SolarPosition(
            timestamp: currentTime,
            azimuth: position.azimuth,
            elevation: position.elevation,
            latitude: lat,
            longitude: lon
        )
        
        // 计算选定日期的日出日落（使用 selectedDate 而不是 currentTime）
        let sunTimes = Astronomy.calculateSunTimes(
            date: selectedDate,
            latitude: lat,
            longitude: lon
        )
        
        sunEvents = SunEvents(
            date: currentTime,
            sunrise: sunTimes.sunrise,
            sunset: sunTimes.sunset,
            solarNoon: nil,
            goldenHourMorning: (nil, nil),
            goldenHourEvening: (nil, nil)
        )
    }
}

// MARK: - Sky Gradient

struct SkyGradientView: View {
    var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.3),
                    Color(red: 0.2, green: 0.4, blue: 0.6),
                    Color(red: 0.5, green: 0.7, blue: 0.9),
                    Color(red: 0.9, green: 0.95, blue: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// MARK: - iOS Enhanced 3D Scene

#if os(iOS)
struct EnhancedSolarSceneView: View {
    var solarPosition: SolarPosition?
    var currentTime: Date
    var showPath: Bool
    var autoRotate: Bool
    
    var body: some View {
        GeometryReader { geometry in
            EnhancedSceneKitView(
                solarPosition: solarPosition,
                currentTime: currentTime,
                showPath: showPath,
                autoRotate: autoRotate,
                frameSize: geometry.size
            )
        }
    }
}

struct EnhancedSceneKitView: UIViewRepresentable {
    var solarPosition: SolarPosition?
    var currentTime: Date
    var showPath: Bool
    var autoRotate: Bool
    var frameSize: CGSize
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = createEnhancedScene()
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.backgroundColor = .clear
        scnView.antialiasingMode = .multisampling4X
        return scnView
    }
    
    func updateUIView(_ scnView: SCNView, context: Context) {
        guard let scene = scnView.scene else { return }
        
        if let solarPos = solarPosition {
            updateEnhancedSunNode(in: scene, solarPosition: solarPos)
            updateElevationIndicator(in: scene, elevation: solarPos.elevation)
            
            if showPath {
                updateSolarPath(scene: scene, date: selectedDate, latitude: solarPos.latitude, longitude: solarPos.longitude)
            }
        }
    }
    
    private func createEnhancedScene() -> SCNScene {
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 15)
        cameraNode.look(at: SCNVector3(x: 0, y: 2, z: 0))
        cameraNode.name = "camera"
        scene.rootNode.addChildNode(cameraNode)
        
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light!.type = .ambient
        ambientLight.light!.intensity = 600
        scene.rootNode.addChildNode(ambientLight)
        
        let directionalLight = SCNNode()
        directionalLight.light = SCNLight()
        directionalLight.light!.type = .directional
        directionalLight.light!.intensity = 800
        directionalLight.position = SCNVector3(x: 5, y: 10, z: 5)
        directionalLight.look(at: SCNVector3(x: 0, y: 0, z: 0))
        scene.rootNode.addChildNode(directionalLight)
        
        addHorizonPlane(scene: scene)
        addGroundGrid(scene: scene)
        addDirectionMarkers(scene: scene)
        addElevationMarkers(scene: scene)
        
        return scene
    }
    
    private func addHorizonPlane(scene: SCNScene) {
        let horizon = SCNPlane(width: 20, height: 20)
        let horizonMaterial = SCNMaterial()
        horizonMaterial.diffuse.contents = UIColor(red: 0.3, green: 0.6, blue: 0.9, alpha: 0.2)
        horizonMaterial.transparency = 0.7
        horizon.materials = [horizonMaterial]
        
        let horizonNode = SCNNode(geometry: horizon)
        horizonNode.position = SCNVector3(x: 0, y: 0, z: 0)
        horizonNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: 0)
        horizonNode.name = "horizon"
        scene.rootNode.addChildNode(horizonNode)
        
        let border = SCNBox(width: 20, height: 0.1, length: 20, chamferRadius: 0)
        let borderMaterial = SCNMaterial()
        borderMaterial.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
        border.materials = [borderMaterial]
        
        let borderNode = SCNNode(geometry: border)
        borderNode.position = SCNVector3(x: 0, y: -0.05, z: 0)
        scene.rootNode.addChildNode(borderNode)
    }
    
    private func addGroundGrid(scene: SCNScene) {
        let grid = SCNFloor()
        grid.reflectivity = 0.3
        let gridNode = SCNNode(geometry: grid)
        gridNode.position = SCNVector3(x: 0, y: -3, z: 0)
        scene.rootNode.addChildNode(gridNode)
    }
    
    private func addDirectionMarkers(scene: SCNScene) {
        let directions: [(String, SCNVector3, UIColor)] = [
            ("N", SCNVector3(x: 0, y: 0.5, z: -10), UIColor.red),
            ("S", SCNVector3(x: 0, y: 0.5, z: 10), UIColor.blue),
            ("E", SCNVector3(x: 10, y: 0.5, z: 0), UIColor.green),
            ("W", SCNVector3(x: -10, y: 0.5, z: 0), UIColor.orange)
        ]
        
        for (text, position, color) in directions {
            let sphere = SCNSphere(radius: 0.5)
            sphere.firstMaterial?.diffuse.contents = color
            sphere.firstMaterial?.specular.contents = UIColor.white
            let node = SCNNode(geometry: sphere)
            node.position = position
            scene.rootNode.addChildNode(node)
            
            let labelNode = createTextLabel(text: text)
            labelNode.position = SCNVector3(x: position.x, y: position.y + 1, z: position.z)
            scene.rootNode.addChildNode(labelNode)
        }
    }
    
    private func createTextLabel(text: String) -> SCNNode {
        let plane = SCNPlane(width: 1.5, height: 0.8)
        plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.9)
        let node = SCNNode(geometry: plane)
        node.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -.pi / 2)
        return node
    }
    
    private func addElevationMarkers(scene: SCNScene) {
        let angles: [Float] = [30, 60, 90]
        let radius: Float = 8.0
        
        for angle in angles {
            let rad = angle * .pi / 180.0
            let y = radius * sin(rad)
            let horizontalRadius = radius * cos(rad)
            
            let ring = SCNTorus(ringRadius: horizontalRadius, pipeRadius: 0.1)
            ring.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.3)
            let ringNode = SCNNode(geometry: ring)
            ringNode.position = SCNVector3(x: 0, y: y, z: 0)
            ringNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: 0)
            scene.rootNode.addChildNode(ringNode)
        }
    }
    
    private func updateEnhancedSunNode(in scene: SCNScene, solarPosition: SolarPosition) {
        scene.rootNode.childNode(withName: "sun", recursively: true)?.removeFromParentNode()
        scene.rootNode.childNode(withName: "sunGlow", recursively: true)?.removeFromParentNode()
        scene.rootNode.childNode(withName: "sunRay", recursively: true)?.removeFromParentNode()
        
        let elevationRad = Float(solarPosition.elevation) * .pi / 180.0
        let azimuthRad = Float(solarPosition.azimuth) * .pi / 180.0
        
        let distance: Float = 8.0
        let x = distance * cos(elevationRad) * sin(azimuthRad)
        let y = distance * sin(elevationRad)
        let z = distance * cos(elevationRad) * cos(azimuthRad)
        
        let sunNode = createEnhancedSunNode(elevation: solarPosition.elevation)
        sunNode.name = "sun"
        sunNode.position = SCNVector3(x: x, y: y, z: z)
        scene.rootNode.addChildNode(sunNode)
        
        let glowNode = createEnhancedGlowNode()
        glowNode.name = "sunGlow"
        glowNode.position = SCNVector3(x: x, y: y, z: z)
        scene.rootNode.addChildNode(glowNode)
        
        addSunRay(scene: scene, from: SCNVector3(x: x, y: y, z: z))
    }
    
    private func createEnhancedSunNode(elevation: Double) -> SCNNode {
        let sphere = SCNSphere(radius: elevation > 0 ? 0.6 : 0.4)
        sphere.segmentCount = 64
        
        let material = SCNMaterial()
        
        if elevation > 0 {
            material.diffuse.contents = UIColor(red: 1.0, green: 0.95, blue: 0.0)
            material.emission.contents = UIColor(red: 1.0, green: 0.8, blue: 0.0)
            material.specular.contents = UIColor.white
        } else {
            material.diffuse.contents = UIColor(red: 0.8, green: 0.3, blue: 0.0)
            material.emission.contents = UIColor(red: 0.5, green: 0.2, blue: 0.0)
            material.specular.contents = UIColor.gray
        }
        
        sphere.materials = [material]
        
        return SCNNode(geometry: sphere)
    }
    
    private func createEnhancedGlowNode() -> SCNNode {
        let sphere = SCNSphere(radius: 1.0)
        sphere.segmentCount = 64
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow.withAlphaComponent(0.3)
        material.transparency = 0.6
        material.emission.contents = UIColor.orange.withAlphaComponent(0.2)
        
        sphere.materials = [material]
        
        return SCNNode(geometry: sphere)
    }
    
    private func addSunRay(scene: SCNScene, from position: SCNVector3) {
        let rayLength = max(position.y + 3, 1.0)
        let ray = SCNCylinder(radius: 0.08, height: rayLength)
        ray.firstMaterial?.diffuse.contents = UIColor.yellow.withAlphaComponent(0.15)
        
        let rayNode = SCNNode(geometry: ray)
        rayNode.position = SCNVector3(x: position.x, y: (position.y - 3) / 2, z: position.z)
        scene.rootNode.addChildNode(rayNode)
    }
    
    private func updateElevationIndicator(in scene: SCNScene, elevation: Double) {
        scene.rootNode.childNode(withName: "elevationArrow", recursively: true)?.removeFromParentNode()
        
        if elevation > 0 {
            let arrowHeight = CGFloat(elevation) / 90.0 * 10.0
            let arrow = SCNCylinder(radius: 0.1, height: Float(arrowHeight))
            arrow.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
            
            let arrowNode = SCNNode(geometry: arrow)
            arrowNode.position = SCNVector3(x: 12, y: Float(arrowHeight) / 2, z: 0)
            arrowNode.name = "elevationArrow"
            scene.rootNode.addChildNode(arrowNode)
        }
    }
    
    private func updateSolarPath(scene: SCNScene, date: Date, latitude: Double, longitude: Double) {
        scene.rootNode.childNode(withName: "solarPath", recursively: true)?.removeFromParentNode()
        
        let pathPoints = Astronomy.calculateSolarPath(date: date, latitude: latitude, longitude: longitude)
        let visiblePoints = pathPoints.filter { $0.elevation > -5 }
        
        guard visiblePoints.count > 1 else { return }
        
        // 绘制轨迹线
        for i in 0..<visiblePoints.count - 1 {
            let point1 = visiblePoints[i]
            let point2 = visiblePoints[i + 1]
            
            let elevationRad1 = Float(point1.elevation) * .pi / 180.0
            let azimuthRad1 = Float(point1.azimuth) * .pi / 180.0
            let elevationRad2 = Float(point2.elevation) * .pi / 180.0
            let azimuthRad2 = Float(point2.azimuth) * .pi / 180.0
            
            let distance: Float = 8.0
            
            let x1 = distance * cos(elevationRad1) * sin(azimuthRad1)
            let y1 = distance * sin(elevationRad1)
            let z1 = distance * cos(elevationRad1) * cos(azimuthRad1)
            
            let x2 = distance * cos(elevationRad2) * sin(azimuthRad2)
            let y2 = distance * sin(elevationRad2)
            let z2 = distance * cos(elevationRad2) * cos(azimuthRad2)
            
            let dx = x2 - x1
            let dy = y2 - y1
            let dz = z2 - z1
            let length = sqrt(dx * dx + dy * dy + dz * dz)
            
            if length > 0 {
                let cylinder = SCNCylinder(radius: 0.05, height: length)
                cylinder.firstMaterial?.diffuse.contents = UIColor.orange.withAlphaComponent(0.4)
                
                let cylinderNode = SCNNode(geometry: cylinder)
                cylinderNode.position = SCNVector3(x: x1 + dx/2, y: y1 + dy/2, z: z1 + dz/2)
                
                let midX = (x1 + x2) / 2
                let midY = (y1 + y2) / 2
                let midZ = (z1 + z2) / 2
                let lookAt = SCNVector3(x: midX + dx, y: midY + dy, z: midZ + dz)
                cylinderNode.look(at: lookAt)
                
                cylinderNode.name = "solarPath"
                scene.rootNode.addChildNode(cylinderNode)
            }
        }
        
        // 添加时间刻度标记（每 4 小时）
        for point in visiblePoints {
            if point.hour % 4 == 0 {
                let elevationRad = Float(point.elevation) * .pi / 180.0
                let azimuthRad = Float(point.azimuth) * .pi / 180.0
                
                let distance: Float = 8.0
                let x = distance * cos(elevationRad) * sin(azimuthRad)
                let y = distance * sin(elevationRad)
                let z = distance * cos(elevationRad) * cos(azimuthRad)
                
                // 时间点标记球
                let marker = SCNSphere(radius: 0.3)
                marker.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.8)
                let markerNode = SCNNode(geometry: marker)
                markerNode.position = SCNVector3(x: x, y: y, z: z)
                markerNode.name = "solarPath"
                scene.rootNode.addChildNode(markerNode)
                
                // 时间文字标签
                let timeLabel = String(format: "%02d:00", point.hour)
                let labelNode = createTextLabel(text: timeLabel)
                labelNode.scale = SCNVector3(x: 0.4, y: 0.4, z: 0.4)
                labelNode.position = SCNVector3(x: x + 0.5, y: y, z: z)
                labelNode.name = "solarPath"
                scene.rootNode.addChildNode(labelNode)
            }
        }
    }
}
#endif

// MARK: - macOS Simplified Version

struct MacSolarView: View {
    var solarPosition: SolarPosition?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.3),
                        Color(red: 0.2, green: 0.4, blue: 0.6),
                        Color(red: 0.5, green: 0.7, blue: 0.9),
                        Color(red: 0.9, green: 0.95, blue: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                Rectangle()
                    .fill(Color(red: 0.2, green: 0.5, blue: 0.3).opacity(0.3))
                    .frame(height: geometry.size.height / 2)
                    .offset(y: geometry.size.height / 4)
                
                if let pos = solarPosition {
                    SunIndicator(solarPosition: pos, size: geometry.size)
                }
                
                DirectionMarkers(size: geometry.size)
                ElevationMarkers(size: geometry.size)
            }
        }
    }
}

struct SunIndicator: View {
    var solarPosition: SolarPosition
    var size: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            let elevation = solarPosition.elevation
            let azimuth = solarPosition.azimuth
            
            let centerX = size.width / 2
            let centerY = size.height / 2
            
            let xOffset = cos((azimuth - 90) * .pi / 180) * min(size.width, size.height) * 0.35
            let yOffset = -sin(elevation * .pi / 180) * min(size.width, size.height) * 0.35
            
            let sunX = centerX + xOffset
            let sunY = centerY + yOffset
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: elevation > 0 ? [.yellow, .orange] : [.red, Color(red: 0.5, green: 0.0, blue: 0.0)],
                        center: .center,
                        startRadius: 0,
                        endRadius: elevation > 0 ? 30 : 20
                    )
                )
                .frame(width: elevation > 0 ? 60 : 40, height: elevation > 0 ? 60 : 40)
                .position(x: sunX, y: sunY)
                .shadow(color: elevation > 0 ? .orange.opacity(0.8) : .red.opacity(0.5), radius: elevation > 0 ? 30 : 15)
            
            if elevation > 0 {
                Circle()
                    .stroke(Color.green.opacity(0.3), lineWidth: 2)
                    .frame(width: 70, height: 70)
                    .position(x: sunX, y: sunY)
            }
        }
    }
}

struct DirectionMarkers: View {
    var size: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            let radius = min(geometry.size.width, geometry.size.height) * 0.35
            
            Text("N")
                .font(.title.bold())
                .foregroundColor(.red.opacity(0.8))
                .position(x: centerX, y: centerY - radius)
            
            Text("S")
                .font(.title.bold())
                .foregroundColor(.blue.opacity(0.8))
                .position(x: centerX, y: centerY + radius)
            
            Text("E")
                .font(.title.bold())
                .foregroundColor(.green.opacity(0.8))
                .position(x: centerX + radius, y: centerY)
            
            Text("W")
                .font(.title.bold())
                .foregroundColor(.orange.opacity(0.8))
                .position(x: centerX - radius, y: centerY)
        }
    }
}

struct ElevationMarkers: View {
    var size: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            let radius = min(geometry.size.width, geometry.size.height) * 0.35
            
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                .frame(width: radius, height: radius)
                .position(x: centerX, y: centerY)
            
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                .frame(width: radius * 0.5, height: radius * 0.5)
                .position(x: centerX, y: centerY)
            
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 10, height: 10)
                .position(x: centerX, y: centerY)
        }
    }
}

// MARK: - Overlay and Controls

struct SolarOverlayView: View {
    var solarPosition: SolarPosition?
    var currentTime: Date
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 8) {
                    if let pos = solarPosition {
                        InfoBadgeView(icon: "sun.max.fill", title: "仰角", value: String(format: "%.1f°", pos.elevation))
                        InfoBadgeView(icon: "location.fill", title: "方位角", value: String(format: "%.1f°", pos.azimuth))
                        InfoBadgeView(icon: "clock.fill", title: "时间", value: formatTime(currentTime))
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct InfoBadgeView: View {
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.orange)
            VStack(alignment: .trailing, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                Text(value)
                    .font(.caption.bold())
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct ControlPanelView: View {
    @Binding var showPath: Bool
    @Binding var autoRotate: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Toggle(isOn: $showPath) {
                Label("显示轨迹", systemImage: "line.3.horizontal")
            }
            .toggleStyle(.button)
            
            Toggle(isOn: $autoRotate) {
                Label("自动旋转", systemImage: "arrow.triangle.2.circlepath")
            }
            .toggleStyle(.button)
        }
        .padding()
    }
}

struct TimeAndDataPanelView: View {
    var solarPosition: SolarPosition?
    var sunEvents: SunEvents?
    @Binding var currentTime: Date
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TimeSliderView(currentTime: $currentTime)
                
                if let pos = solarPosition {
                    SolarDataGrid(solarPosition: pos)
                }
                
                if let events = sunEvents {
                    SunEventsRow(sunEvents: events)
                }
                
                UsageTipsView()
            }
            .padding()
        }
    }
}

struct TimeSliderView: View {
    @Binding var currentTime: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("时间")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text(formatTime(currentTime))
                    .font(.caption.bold())
                    .foregroundColor(.orange)
            }
            
            // 使用小时作为滑块单位（0-24 小时）
            let calendar = Calendar.current
            let hour = Float(calendar.component(.hour, from: currentTime))
            
            Slider(
                value: Binding(
                    get: { hour },
                    set: { newHour in
                        var components = calendar.dateComponents([.year, .month, .day], from: currentTime)
                        components.hour = Int(newHour)
                        components.minute = 0
                        components.second = 0
                        if let newDate = calendar.date(from: components) {
                            currentTime = newDate
                        }
                    }
                ),
                in: 0...24,
                step: 0.5  // 每 30 分钟
            )
            
            HStack {
                Text("00:00")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("12:00")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("24:00")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
}

struct SolarDataGrid: View {
    var solarPosition: SolarPosition
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            DataCardMini(icon: "sun.max.fill", title: "仰角", value: solarPosition.elevationString, color: .orange)
            DataCardMini(icon: "location.fill", title: "方位角", value: solarPosition.azimuthString, color: .blue)
            DataCardMini(icon: "eye", title: "可见性", value: solarPosition.isVisible ? "☀️ 可见" : "🌙 不可见", color: .green)
            DataCardMini(icon: "location.north", title: "方向", value: solarPosition.direction, color: .purple)
        }
    }
}

struct DataCardMini: View {
    var icon: String
    var title: String
    var value: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Text(value)
                .font(.title3.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct SunEventsRow: View {
    var sunEvents: SunEvents
    
    var body: some View {
        HStack(spacing: 12) {
            EventCardMini(icon: "sunrise.fill", title: "日出", time: sunEvents.sunriseString, gradient: LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
            EventCardMini(icon: "sunset.fill", title: "日落", time: sunEvents.sunsetString, gradient: LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
        }
    }
}

struct EventCardMini: View {
    var icon: String
    var title: String
    var time: String
    var gradient: LinearGradient
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                Text(time)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .background(gradient)
        .cornerRadius(12)
    }
}

struct UsageTipsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("💡 使用提示")
                .font(.headline)
            #if os(iOS)
            Text("• 单指拖动可以旋转视角")
                .font(.caption)
            Text("• 双指捏合可以缩放")
                .font(.caption)
            Text("• 蓝色半透明平面 = 地平线")
                .font(.caption)
            Text("• 橙色轨迹线 = 太阳全天路径")
                .font(.caption)
            Text("• 白色标记 = 时间点（每 2 小时）")
                .font(.caption)
            Text("• 时间标签 = 本地时间（如 10:00）")
                .font(.caption)
            Text("• 太阳在地平线上 = 黄色发光")
                .font(.caption)
            Text("• 太阳在地平线下 = 暗红色")
                .font(.caption)
            #else
            Text("• 黄色大球 = 太阳（地平线上）")
                .font(.caption)
            Text("• 红色小球 = 太阳（地平线下）")
                .font(.caption)
            Text("• 同心圆环 = 高度刻度（30°/60°/90°）")
                .font(.caption)
            #endif
            Text("• 拖动时间滑块查看不同时刻")
                .font(.caption)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    Solar3DView()
        .environmentObject(LocationService())
        .environmentObject(MotionService())
}
