import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    @Published var weather : WeatherEntity? = nil
    @Published var currentTheme: AppTheme = .sunny
    @Published var isFavorite: Bool = false
    private var cancellables = Set<AnyCancellable>()

    private let weatherUseCase : WeatherUseCaseProtocol
    private var currentCoordinates : Coordinate?
    private var locationUseCase : LocationUseCaseProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol
    init(weatherUseCase :WeatherUseCaseProtocol, locationUseCase: LocationUseCaseProtocol,favoritesRepository: FavoritesRepositoryProtocol){
        self.weatherUseCase = weatherUseCase
        self.locationUseCase = locationUseCase
        self.favoritesRepository = favoritesRepository
        setupLocationListener()
        setupFavoritesListener()
    }
    private func setupLocationListener() {
            locationUseCase.coordinatePublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newCoordinate in
                print("🚀 Location received in WeatherViewModel: \(newCoordinate)")
                self?.fetchWeather(for: newCoordinate)
            }
            .store(in: &cancellables)
        }
    private func setupFavoritesListener() {
            favoritesRepository.favoritesPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self = self, let currentWeather = self.weather else { return }
                    
                    do {
                        self.isFavorite = try self.favoritesRepository.isFavorite(id: Int(currentWeather.id))
                    } catch {
                        print("Error checking favorite status: \(error)")
                    }
                }
                .store(in: &cancellables)
        }
    
    func onAppear(){
        guard weather == nil else { return }
        self.isLoading = true
        locationUseCase.requestDeviceLocation()
        
    }
    
    func fetchWeather(for coordinate : Coordinate){
        currentCoordinates = coordinate
        self.isLoading = true
        self.errorMessage = nil
        Task{
            defer { self.isLoading = false }
            do{
                let fetchedWeather = try await weatherUseCase.execute(coordinate: coordinate)
                self.weather = fetchedWeather
                self.currentTheme = AppTheme.getTheme(conditionCode: fetchedWeather.conditionCode, isDay: fetchedWeather.isDay)
                self.isFavorite = try favoritesRepository.isFavorite(id: Int(fetchedWeather.id))
            }catch{
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
    
    func retry(){
        if let coordinate = currentCoordinates {
            fetchWeather(for: coordinate)
        }
    }
    
    func toggleFavorite() {
            guard let weather else { return }
            
            do {
                if isFavorite {
                    try favoritesRepository.removeFavorite(id: Int(weather.id))
                } else {
                    let newFavorite = FavoriteLocation(
                        id: Int(weather.id),
                        cityName: weather.cityName,
                        region: weather.region,
                        country: weather.country,
                        latitude: weather.coordinate.lat,
                        longitude: weather.coordinate.lon
                    )
                    try favoritesRepository.addFavorite(newFavorite)
                }
                
                
            } catch {
                self.errorMessage = "Failed to update favorites: \(error.localizedDescription)"
            }
        }
}
