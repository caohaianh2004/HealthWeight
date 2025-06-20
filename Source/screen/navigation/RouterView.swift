//
//  RouterView.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//


import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @StateObject var viewModelData: DatabasePeople = DatabasePeople()
    @StateObject var viewModelPeople: DatabasePeople = DatabasePeople()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
        .environmentObject(viewModelData)
        .environmentObject(viewModelPeople)
    }
}

class Router: ObservableObject {
    enum Route: Hashable {
        case home
        case onboard
        case standbyscreen
        case selecfunctions
        case editProfile
        case add
        case managebmicalcuator
        case bmiresult(bmi: Double, healthWeightRange: String)
        case caloriecalculator
        case calorieresult(bmr: Double, tdee: Double, unit: String)
        case result(bmr: Double,tdee: Double, unit: String)
    }
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .home:
            HealthWeight().navigationBarBackButtonHidden()
        case .onboard:
            OnBoandingScreen().navigationBarBackButtonHidden()
        case .standbyscreen:
            StandbyScreen().navigationBarBackButtonHidden()
        case .selecfunctions:
            SelectFunctions().navigationBarBackButtonHidden()
        case .editProfile:
            ManaEditProfileScreen().navigationBarBackButtonHidden()
        case .add:
            AddWeight().navigationBarBackButtonHidden()
        case .managebmicalcuator:
            ManageBMICalculator().navigationBarBackButtonHidden()
        case let .bmiresult(bmi, healthWeightRange):
            BmiResult(bmi: bmi, healthyWeightRange: healthWeightRange).navigationBarBackButtonHidden()
        case .caloriecalculator:
            ManageCalorieCalculator().navigationBarBackButtonHidden()
        case let .calorieresult(bmr, tdee, unit):
            CalorieResult(bmr: bmr, tdee: tdee, unit: unit).navigationBarBackButtonHidden()
        case let .result(bmr,tdee, unit):
            Results(bmr: bmr, unit: unit, tdee: 0).navigationBarBackButtonHidden()
        }
    }
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct Inspiration: Equatable {
    var title : String
    var index: Int
    
    init(title: String, index: Int) {
        self.title = title
        self.index = index
    }
}
