//
//  BaseView.swift
//  UI-308 (iOS)
//
//  Created by nyannyan0328 on 2021/09/16.
//

import SwiftUI

struct BaseView: View {
    @State var currentTab = "house.fill"
    @State var curveAxis : CGFloat = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing:0){
            
            TabView(selection:$currentTab){
                
                Home()
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                Text("Account")
                    .tag("person.fill")
                
            }
            .clipShape(
            
            CustomBottomCurve(curveAxis: curveAxis)
            
            
            )
            .padding(.bottom,-90)
            
           
            HStack(spacing:0){
                
                TabButton()
                
                
            }
            .frame(height: 50)
            .padding(.horizontal,35)
            .padding(.bottom,getSafeArea().bottom == 0 ? 10 : 0)
            
            
        }
        .background(Color("Brown"))
        .ignoresSafeArea(.container, edges: .top)
        
    }
    @ViewBuilder
    func TabButton()->some View{
        
        ForEach(["house.fill","magnifyingglass","person.fill"],id:\.self){image in
            
            
            GeometryReader{proxy in
                
                Button {
                    withAnimation{
                        
                        currentTab = image
                        curveAxis = proxy.frame(in: .global).midX
                    }
                } label: {
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                      
                       
                        .background(
                        
                        
                                
                                Circle()
                                    .fill(Color("Brown"))
                                
                                
                                
                           
                        
                        )
                        .offset(y:currentTab == image ? -30 : 0)
                    
                    
                        
                }
                .frame(maxWidth: .infinity)
                .onAppear {
                    
                    if curveAxis == 0 && image == "house.fill"{
                        
                        curveAxis = proxy.frame(in: .global).midX
                        
                        
                    }
                    
                }

            }
            .frame(height: 45)
                
            
            
        }
        
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
