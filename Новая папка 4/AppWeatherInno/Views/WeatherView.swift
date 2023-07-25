import SwiftUI
struct WeatherView: View {
    var weather: ResponceBody
    private func isDayTime() -> Bool {
            let now = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: now)
            return hour >= 6 && hour < 18
        }
    var backgroundImageName: String {
        let temperature = Int(weather.main.temp.roundDouble())!
        if isDayTime() {
            if temperature < -8 {
                return "day_minus_8"
            } else if temperature >= -8 && temperature < 10 {
                return "day_minus_8_10"
            } else if temperature >= 10 && temperature < 20 {
                return "day_10_20"
            } else if temperature >= 20 && temperature < 26 {
                return "day_20_26"
            } else {
                return "day_26"
            }
        } else {
            if temperature < -8 {
                return "night_minus_8"
            } else if temperature >= -8 && temperature < 10 {
                return "night_minus_8_10"
            } else if temperature >= 10 && temperature < 20 {
                return "night_10_20"
            } else if temperature >= 20 && temperature < 26 {
                return "night_20_26"
            } else {
                return "night_26"
            }
        }
    }
    var body: some View {
        ZStack(alignment: .leading) {
            Image(backgroundImageName) // Add background image here
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name).bold().font(.title).padding(.horizontal)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light).padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack{
                    HStack{
                        Spacer().frame(width: 15)
                        VStack{
                            Image(systemName: "sun.max").font(.system(size:50))
                            Text(weather.weather[0].main).font(.system(size: 30))
                        }
                        Spacer()
                        Text(weather.main.feels_like.roundDouble() + "°").font(.system(size:  50)).fontWeight(.bold).padding(.all)
                        Spacer().frame(width: 10)
                    }
                    Spacer().frame(height: 500)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment:.leading)
            VStack{
                Spacer()
                VStack{
                    VStack(alignment: .leading, spacing: 20 ){
                        Text("Weather now").bold().padding(.horizontal)
                        HStack{
                            WeatherRow(logo: "thermometer", name: "Min temp", value:(weather.main.temp_min.roundDouble() + "°")).padding(.horizontal)
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "Max temp", value:(weather.main.temp_max.roundDouble() + "°")).padding(.horizontal)
                            Spacer()
                            
                        }
                        HStack{
                            WeatherRow(logo: "wind", name: "Wind speed", value:(weather.wind.speed.roundDouble() + "m/s")).padding(.horizontal)
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value:(weather.main.humidity.roundDouble() + "%")).padding(.horizontal)
                            Spacer()
                            
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.bottom,20).foregroundColor(.purple).background(.white).cornerRadius(20, corners: [.topLeft,.topRight])
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

