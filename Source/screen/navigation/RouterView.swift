//
//  RouterView.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//


import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @StateObject var viewModelData: Databasedata = Databasedata()
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
