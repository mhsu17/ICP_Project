//
//  HomeViewController.swift
//  icp
//
//  Created by Ese L Bowry on 4/10/22.
//

import SwiftUI

struct HomeVC: View {
    @State var email = ""
    @State var password = ""
    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSignUp = false
    
    var body: some View {
        ZStack {
            if showSignUp{
                SignUpVC()
                    .transition(.move(edge: .trailing))
            } else if showSignUp == false {
                LoginVC()
                    .transition(.move(edge: .trailing))
            } else {
                
            }
        }
        .padding(.top, maxCircleHeight / 1.6)
        .frame(maxHeight: .infinity, alignment: .top)
        
        .overlay{
            HStack(alignment: .bottom) {
                Text(showSignUp ? "New Member" : "Already Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation {
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "Sign In" : "Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightBlue"))
                })
            }
            
        }
        
    }
}

struct HomeVC_Previews: PreviewProvider {
    static var previews: some View {
        HomeVC()
    }
    
    
    
}


extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    //Getting Safe Area...
    func getSafeArea()->UIEdgeInsets{
        return (UIApplication.shared.windows.first?.safeAreaInsets)!; UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
