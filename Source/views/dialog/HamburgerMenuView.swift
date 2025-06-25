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
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "text.bubble.fill")
                                    .font(.system(size: 15))
                                
                                Text("Feedback")
                                    .font(.system(size: 16))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "square.grid.2x2.fill")
                                    .font(.system(size: 15))
                                
                                Text("Other Apps")
                                    .font(.system(size: 16))
                            }
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
                            } label: {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 15))
                                
                                Text("Rate App")
                                    .font(.system(size: 16))
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
