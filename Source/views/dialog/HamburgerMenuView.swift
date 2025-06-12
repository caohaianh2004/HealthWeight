import SwiftUI

struct HamburgerMenuView: View {
    @EnvironmentObject var route: Router
    @Binding var showMenu: Bool
    let url = URL(string: "https://www.example.com")!
    
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
                            .frame(width: 250, height: 250)
                            .padding(.top, 20)
                        
                        Group {
                            Button {
                                route.navigateTo(.selecfunctions)
                            } label: {
                                Image(systemName: "list.clipboard.fill")
                                Text("Select Functions")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                route.navigateTo(.editProfile)
                            } label: {
                                Image(systemName: "person.crop.circle")
                                Text("Edit Profile")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "text.bubble.fill")
                                Text("Feedback")
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "square.grid.2x2.fill")
                                Text("Other Apps")
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "star.fill")
                                Text("Rate App")
                            }
                            Divider()
                                .background(Color.black)
                            
                            ShareLink(item: "Chia sẻ liên kết: https://www.example.com") {
                                Label("Share", systemImage: "square.and.arrow.up.fill")
                            }
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    .padding(40)
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
