//
//  LoginView.swift
//  LoginSwiftUI
//
//  Created by Deepak Basavaraj Kamatad on 07/09/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var userName:String=""
    @State private var password:String=""
    @State private var isPasswordVisible: Bool = false
    @State private var navigateToProfileView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Sign In")
                    .frame(alignment: .center)
                    .padding(.bottom)
                    .padding(.top)
                    .font(.system(size:28))
                    
                
                VStack(spacing: 24){
                    NavigationLink(destination: LoginSuccessfull(), isActive: $navigateToProfileView){
                        EmptyView()
                    }
                    InputView(text: $userName, placeholder: "Username")
                    .autocapitalization(.none)
                    
                    .padding(.horizontal)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(Color.gray), alignment: .bottom)
                    
                    HStack{
                        InputView(text: $password, placeholder: "Password",isSecureField: !isPasswordVisible)
                            
                        Button(action: {
                            isPasswordVisible.toggle()
                            
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                        .overlay(Rectangle().frame(height: 1).foregroundColor(Color.gray), alignment: .bottom)
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                
                
                Button{
                    viewModel.getToken(username: userName, password: password){
                        success in
                        if success{
                            navigateToProfileView = true
                            print(userName)
                            print(password)
                        } else {
                            print("Authentication Failed...!")
                        }
                    }
                    
                } label: {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 200,height: 55)
                    
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 :0.5)
                .cornerRadius(10)
                .padding(.top,40)
                .padding(.bottom,60)
            
                
                NavigationLink{
                    ForgotPasswordView()
                    
                } label:{
                    Text("Forgot Password?")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
            }
            .background(Image("background"))
        }
        
    }
}
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !userName.isEmpty
        && !password.isEmpty
        && password.count>5
        
    }
}
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

struct UnderlineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return path
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
