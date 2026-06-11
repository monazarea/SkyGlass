import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    @Published var weather : WeatherEntity? = nil
    @Published var isSaved : Bool = false
    @Published var currentTheme: AppTheme = .sunny
    
    private var cancellables = Set<AnyCancellable>()

    private let weatherUseCase : WeatherUseCaseProtocol
    private var currentCoordinates : Coordinate?
    private var locationService : LocationServiceProtocol
    init(weatherUseCase :WeatherUseCaseProtocol, locationService: LocationServiceProtocol){
        self.weatherUseCase = weatherUseCase
        self.locationService = locationService
        setupLocationListener()
    }
    private func setupLocationListener() {
            locationService.coordinatePublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] newCoordinate in
                    self?.fetchWeather(for: newCoordinate)
                }
                .store(in: &cancellables)
        }
    
    func onAppear(){
        self.isLoading = true
        locationService.requestDeviceLocation()
        
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
