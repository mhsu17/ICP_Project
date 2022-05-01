//
//  SignUpVC.swift
//  icp
//
//  Created by Ese L Bowry on 4/17/22.
//

import SwiftUI

struct SignUpVC: View {
    @State var email = ""
    @State var password = ""
    @State var comfirmPassword = ""
    @State var willMoveToNextScreen = false
    var body: some View {
        VStack{
            Text("Sign Up").font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //Email and Password
            VStack(alignment: .leading, spacing: 8, content: {
                Text("User Name").fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("example@gmail.com", text: $email)
                //Changes Font Size and Text Color
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                Divider()
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Password").fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("abcdef", text: $password)
                //Changes Font Size and Text Color
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                Divider()
            })
            .padding(.top, 20)
            .navigate(to: HomeVC(), when: $willMoveToNextScreen)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Confirm Password").fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("abcdef", text: $comfirmPassword)
                //Changes Font Size and Text Color
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                Divider()
            })
            .padding(.top, 20)

            //Trimming unnecessary HStack and Spacers
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            
            //Next Button
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Circle())
                //shadow
                    .shadow(color: Color("lightBlue").opacity(0.6), radius:
                                5, x: 0, y: 0)
            })
            .frame(maxWidth: .infinity, alignment: . leading)
            .padding(.top, 10)
        }
        .padding()
    }
}

struct SignUpVC_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVC()
    }
}
