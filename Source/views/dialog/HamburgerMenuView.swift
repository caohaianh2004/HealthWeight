import SwiftUI

struct HamburgerMenuView: View {
    @Binding var showMenu: Bool
    let url = URL(string: "https://www.example.com")!
    
    var body: some View {
        NavigationStack {
        ZStack {
            //                HStack {
            //                    Button(action: {
            //                        withAnimation {
            //                            showMenu.toggle()
            //                        }
            //                    }) {
            //                        Image(systemName: "line.3.horizontal")
            //                            .resizable()
            //                            .frame(width: 24, height: 18)
            //                            .padding()
            //                            .foregroundColor(.black)
            //                    }
            //                    Spacer()
            //                }
            //                Spacer()
            
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
                        Image("group")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 200)
                            .padding(.top, 20)
                        
                        Group {
                            NavigationLink(destination: SelectFunctions()) {
                                Image(systemName: "list.clipboard.fill")
                                Text("Select Functions")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            
                            Divider()
                                .background(Color.black)
                            
                            Button {
                                /*Nhập nội dung*/
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
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    .padding(40)
                    .padding(.horizontal, 20)
                    .frame( maxHeight: .infinity)
                    .frame(width: 300)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .leading))
                }
                
                Spacer()
            }
        }
    }
        .animation(.easeInOut, value: showMenu)
    }
}
