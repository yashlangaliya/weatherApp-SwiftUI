//
//  ContentView.swift
//  weatherApp
//
//  Created by Yash-COGNIWIDE on 08/03/22.
//

import SwiftUI

struct WeatherData {
    var day: String
    var imageName: String
    var temp: Int
}

struct ContentView: View {
    
    @State private var isNight: Bool = false
    
    let weatherDataArray = [
        WeatherData(day: "MON", imageName: "cloud.sun.fill", temp: 70),
        WeatherData(day: "TUE", imageName: "cloud.bolt.rain.fill", temp: 66),
        WeatherData(day: "WED", imageName: "cloud.sun.bolt.fill", temp: 77),
        WeatherData(day: "THU", imageName: "cloud.sun.fill", temp: 66),
        WeatherData(day: "FRI", imageName: "cloud.sun.bolt.fill", temp: 70)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                SimpleTextView(text: "Ahmedabad, GJ", fontSize: 32, weight: .bold)
                    .padding()
                
                MainWeatherView(imageName: isNight ? "cloud.moon.fill" : "cloud.sun.fill", temp: 75)
                
                HStack(spacing: 20) {
                    ForEach(weatherDataArray, id: \.day) { data in
                        DayTempView(day: data.day, imageName: data.imageName, temp: data.temp)
                    }
                }
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    CommonButtonUI(title: "I will amaze you!")
                }
                .padding(.bottom, 40)
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DayTempView: View {
    let day: String
    let imageName: String
    let temp: Int
    var body: some View {
        VStack (spacing: 8) {
            SimpleTextView(text: day, fontSize: 16, weight: .medium, textColor: .white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            SimpleTextView(text: "\(temp)°", fontSize: 28, weight: .medium, textColor: .white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    var body: some View {
        LinearGradient(colors: isNight ? [.black, .gray] : [.blue, Color("LightBlue")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MainWeatherView: View {
    var imageName: String
    var temp: Int
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, alignment: .bottom)
            
            SimpleTextView(text: "\(temp)°", fontSize: 70, weight: .bold, textColor: .white)
        }
        .padding(.bottom, 40)
    }
}

struct CommonButtonUI: View {
    var title: String
    var backgroundColor: Color = .white
    var textColor: Color = .blue
    var body: some View {
        SimpleTextView(text: title, fontSize: 22, weight: .bold, textColor: .blue)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

struct SimpleTextView: View {
    var text: String
    var fontSize: CGFloat
    var weight: Font.Weight = .regular
    var textColor: Color = .white
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .medium, design: .rounded))
            .foregroundColor(textColor)
    }
}
