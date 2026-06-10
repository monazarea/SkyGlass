import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    @Published var weather : WeatherEntity? = nil
    @Published var isSaved : Bool = false
    
    @Published var currentTheme: AppTheme = .sunny
    
    private let weatherUseCase : WeatherUseCaseProtocol
    private var currentCoordinates : Coordinate?
    
    init(weatherUseCase :WeatherUseCaseProtocol){
        self.weatherUseCase = weatherUseCase
    }
    
    func onAppear(){
        let defaultCoordinate = Coordinate(lat: 37.7749, lon: -122.4194) // San Francisco as default
        fetchWeather(for: defaultCoordinate)
    }
    
    func fetchWeather(for coordinate : Coordinate){
        currentCoordinates = coordinate
        self.isLoading = true
        self.errorMessage = nil
        
        Task{
            do{
                let fetchedWeather = try await weatherUseCase.execute(coordinate: coordinate)
                self.weather = fetchedWeather
                self.currentTheme = AppTheme.getTheme(conditionCode: fetchedWeather.conditionCode, isDay: fetchedWeather.isDay)
                self.isLoading = false
            }catch{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
    }
    
    func retry(){
        if let coordinate = currentCoordinates {
            fetchWeather(for: coordinate)
        }
    }
    
    func saveCurrentLocation(){
        isSaved.toggle()
        // TODO: Implement saving logic, e.g., save to UserDefaults or a database
    }
}
