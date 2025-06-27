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
        case result(bmr: Double, unit: String)
        case managebmrcalcuator
        case bmrresult(bmr: Double,tdee: Double, unit: String)
        case managrboyfat
        case boyfatresult(bodyFatPercentage: Double, fatMass: Double, leanMass: Double, idealFatPercent: Double, fatToLose: Double, bmiMethodFat: Double, category: String, gender: String, unit: String)
        case manageidealweight
        case idealWeightResult(robinson: Double, miller: Double, devine: Double, hamwi: Double, healthyMin: Double, healthyMax: Double, unit: String)
        case manageleanboy
        case leanbodyresult(boerlean: Double, boerbody: Double, jameslean: Double, jmmesbody: Double, humelean: Double, humebody: Double, unit: String)
        case manageHealthyWeight
        case healthyweightresult(minWeight: Double, maxWeight: Double, unit: String)
        case managearmybodyfat
        case resultarmbody(resultarm: Double)
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
        case let .result(bmr, unit):
            Results(bmr: bmr, unit: unit).navigationBarBackButtonHidden()
        case .managebmrcalcuator :
            ManageBMRCalculator().navigationBarBackButtonHidden()
        case let .bmrresult(bmr,tdee, unit):
            BmrResult(bmr: bmr, tdee: tdee, unit: unit).navigationBarBackButtonHidden()
        case .managrboyfat:
            ManageBodyFat().navigationBarBackButtonHidden()
        case let .boyfatresult(bodyFatPercentage, fatMass, leanMass, idealFatPercent, fatToLose, bmiMethodFat, category, gender, unit):
            BodyFatResult(bodyFatPercentage: bodyFatPercentage, fatMass: fatMass, leanMass: leanMass, idealFatPercent: idealFatPercent, fatToLose: fatToLose, bmiMethodFat: bmiMethodFat, category: category, gender: gender, unit: unit).navigationBarBackButtonHidden()
        case .manageidealweight:
            ManageIdealWeight().navigationBarBackButtonHidden()
        case let .idealWeightResult(robinson, miller, devine, hamwi, healthyMin, healthyMax, unit):
            IdealWeightResult(robinson: robinson, miller: miller, devine: devine, hamwi: hamwi, healthyMin: healthyMin, healthyMax: healthyMax, unit: unit).navigationBarBackButtonHidden()
        case .manageleanboy:
            ManageLeanBody().navigationBarBackButtonHidden()
        case let .leanbodyresult(boerlean, boerbody ,jameslean, jmmesbody, humelean, humebody, unit):
            LeanBodyResult(boerlean: boerlean, boerbody: boerbody, jameslean: jameslean, jmmesbody: jmmesbody, humelean: humelean, humebody: humebody, unit: unit).navigationBarBackButtonHidden()
        case .manageHealthyWeight:
            ManageHealthyWeight().navigationBarBackButtonHidden()
        case let .healthyweightresult(minWeight, maxWeght, unit):
            HealthyWeightResult(minWeight: minWeight, maxWeight: maxWeght,  unit: unit).navigationBarBackButtonHidden()
        case .managearmybodyfat:
            ManageArmyBodyFat().navigationBarBackButtonHidden()
        case let .resultarmbody(resultarm):
            ResultArmBodyFat(resultarm: resultarm).navigationBarBackButtonHidden()
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
