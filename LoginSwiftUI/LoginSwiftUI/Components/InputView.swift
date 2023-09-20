//
//  InputView.swift
//  LoginSwiftUI
//
//  Created by Deepak Basavaraj Kamatad on 07/09/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text:String
    let placeholder:String
    var isSecureField: Bool = false
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12){
            if isSecureField{
                HStack{
                    SecureField(placeholder,text:$text)
                        .font(.system(size:14))
                        
                        
                    
                }
            }else{
                TextField(placeholder,text:$text)
                    .font(.system(size:14))
                    
                    
                
            }
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), placeholder: "name@example.com")
    }
}

