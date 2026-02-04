import SwiftUI
import Combine

struct SplashScreenView: View {
    @Binding var isFinished: Bool
    
    @State private var progress: CGFloat = 0.0
    @State private var isLoaded = false
    @State private var cloudOffset1 = -20.0
    @State private var cloudOffset2 = 20.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.95, green: 0.98, blue: 1.0)
                    .ignoresSafeArea()
                
                // --- BACKGROUND LAYER ---
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 200, height: 200)
                    .blur(radius: 40)
                    .opacity(0.5)
                    .offset(y: (geometry.size.height * 0.4) - (progress * 2.5))
                
                Image(systemName: "cloud.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .opacity(0.4)
                    .offset(x: -geometry.size.width * 0.3, y: -geometry.size.height * 0.25 + cloudOffset1)
                
                Image(systemName: "cloud.fill")
                    .font(.system(size: 90))
                    .foregroundColor(.white)
                    .opacity(0.3)
                    .offset(x: geometry.size.width * 0.25, y: -geometry.size.height * 0.15 + cloudOffset2)
                
                VStack {
                    Spacer()
                    VesuviusShape()
                        .fill(Color(red: 0.1, green: 0.15, blue: 0.2))
                        .frame(height: geometry.size.height * 0.35)
                }
                .ignoresSafeArea()
                
                // --- FOREGROUND CONTENT ---
                VStack(spacing: 0) {
                    Spacer(minLength: geometry.safeAreaInsets.top > 20 ? 40 : 20)
                    
                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.2))
                            .frame(width: 160, height: 160)
                            .blur(radius: 25)
                        
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color.white)
                            .frame(width: 130, height: 130)
                            .shadow(color: Color.black.opacity(0.08), radius: 20)
                            .overlay(
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 55))
                                    .foregroundColor(.red)
                                    .offset(y: isLoaded ? -5 : 5)
                            )
                            .rotationEffect(.degrees(-2))
                        
                        if isLoaded {
                            Image(systemName: "sparkles")
                                .font(.title)
                                .foregroundColor(.yellow)
                                .offset(x: 60, y: -60)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.bottom, 30)
                    
                    VStack(spacing: 8) {
                        Text("Benvenuti")
                            .font(.system(size: 40, weight: .black))
                        Text("a Napoli!")
                            .font(.system(size: 48, weight: .black))
                            .foregroundStyle(
                                LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing)
                            )
                    }
                    .opacity(progress > 5 ? 1 : 0)
                    
                    Spacer()
                    
                    VStack(spacing: 40) {
                        ZStack {
                            GeometryReader { pathGeo in
                                let w = pathGeo.size.width
                                let h = pathGeo.size.height
                                let start = CGPoint(x: 0, y: h/2)
                                let end = CGPoint(x: w, y: h/2)
                                let control = CGPoint(x: w/2, y: h/2 - 40)
                                
                                Path { path in
                                    path.move(to: start)
                                    path.addQuadCurve(to: end, control: control)
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [4, 6]))
                                .foregroundColor(.gray.opacity(0.3))
                                
                                let tWalker = min(progress / 100, 0.88)
                                let walkerX = pow(1-tWalker, 2) * start.x + 2 * (1-tWalker) * tWalker * control.x + pow(tWalker, 2) * end.x
                                let walkerY = pow(1-tWalker, 2) * start.y + 2 * (1-tWalker) * tWalker * control.y + pow(tWalker, 2) * end.y
                                
                                Image(systemName: "graduationcap.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(isLoaded ? .green : .gray.opacity(0.4))
                                    .position(x: end.x, y: end.y - 16)
                                
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundColor(.red)
                                    .position(x: walkerX, y: walkerY - 17)
                            }
                            .frame(height: 80)
                        }
                        .frame(width: 280)
                        
                        Text(isLoaded ? "BENVENUTO ALL'UNIVERSITÀ!" : "PREPARING YOUR ARRIVAL...")
                            .font(.system(size: 12, weight: .black))
                            .kerning(1.5)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, geometry.size.height * 0.15)
                    
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in
            if progress < 100 {
                // Use withAnimation here for internal splash movements
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                    progress += CGFloat.random(in: 1...3)
                }
                
                if progress >= 100 {
                    progress = 100
                    isLoaded = true
                    
                    // The "Pro" Transition Trigger
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                            isFinished = true
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                cloudOffset1 = 20
            }
            withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                cloudOffset2 = -20
            }
        }
    }
}

struct VesuviusShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * 0.35, y: rect.height * 0.5))
        path.addLine(to: CGPoint(x: rect.width * 0.45, y: rect.height * 0.75))
        path.addLine(to: CGPoint(x: rect.width * 0.65, y: rect.height * 0.3))
        path.addLine(to: CGPoint(x: rect.width * 0.85, y: rect.height * 0.85))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.6))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SplashScreenView(isFinished: .constant(false))
}
