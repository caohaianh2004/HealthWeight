import SwiftUI
import StoreKit

struct HamburgerMenuView: View {
    @EnvironmentObject var route: Router
    @Binding var showMenu: Bool
    @Environment(\.requestReview) private var requestReview
    @State var isShowingShareSheet : Bool = false
    
    var body: some View {
        ZStack {
            if showMenu {
                Color.white.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
            }
            
            HStack(spacing: 0) {
                if showMenu {
                    VStack(alignment: .leading, spacing: 20) {
                        Image("Image5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 20)
                        
                        Group {
                            Button {
                                route.navigateTo(.selecfunctions)
                            } label: {
                                Image(systemName: "list.clipboard.fill")
                                    .font(.system(size: 15))
                                
                                Text("Select Functions")
                                    .font(.system(size: 16))
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .font(.system(size: 15))
                            }
                            
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                route.navigateTo(.editProfile)
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 15))
                                
                                Text("Edit Profile")
                                    .font(.system(size: 16))
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .font(.system(size: 15))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                EmailHelper.shared.send(subject: LocalizationSystem.sharedInstance.localizedStringForKey(key:"menu_help_title", comment: ""), body: LocalizationSystem.sharedInstance.localizedStringForKey(key:"menu_help_detail", comment: ""), to: ["phunggtheduy4896@gmail.com"])
                            } label: {
                                Image(systemName: "text.bubble.fill")
                                    .font(.system(size: 15))
                                
                                Text("Feedback")
                                    .font(.system(size: 16))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                if let url = URL(string: "itms-apps://apps.apple.com/developer") {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Image(systemName: "square.grid.2x2.fill")
                                    .font(.system(size: 15))
                                
                                Text("Other Apps")
                                    .font(.system(size: 16))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                requestReview()
                            } label: {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 15))
                                
                                Text("Rate App")
                                    .font(.system(size: 16))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                isShowingShareSheet.toggle()
                            } label: {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .font(.system(size: 15))
                                
                                Text("Share")
                                    .font(.system(size: 16))
                            }
                            .sheet(isPresented: $isShowingShareSheet) {
                                ShareSheet(activityItems: ["English Grammar..."])
                            }
                            
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    .padding(5)
                    .padding(.horizontal, 20)
                    .frame( maxHeight: .infinity)
                    .frame(width: 300)
                    .background(.white)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .leading))
                }
                
                Spacer()
            }
        }
        .animation(.easeInOut, value: showMenu)
    }
}

//#Preview {
//    HamburgerMenuView()
//}
