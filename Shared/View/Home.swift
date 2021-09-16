//
//  Home.swift
//  UI-308 (iOS)
//
//  Created by nyannyan0328 on 2021/09/16.
//

import SwiftUI

struct Home: View {
    
    @State var funitures : [Furniture] = [
        
        Furniture(name: "Side Tabel", disription: "Amazing side Table is butifull", price: "$50", image: "sideTable"),
        Furniture(name: "Desktop Table", disription: "Your Study.Always!!!", price: "$300", image: "desktopTable"),
        Furniture(name: "Table Clock", disription: "What time is it now??", price: "$100", image: "clock"),
        
        
    ]
    @State var currentMenu = "Side Tabel"
   
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                
                HStack{
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "gear")
                            .font(.title2.weight(.black))
                        
                           
                            
                    }
                    
                    Spacer()
                    
                    
                    Menu {
                        
                        
                        Button {
                            
                            currentMenu = "Side Tabel"
                            
                        } label: {
                            
                            Text("Side Tabel")
                            
                            
                        }
                        
                        Button {
                            
                            currentMenu = "Desktop Table"
                            
                        } label: {
                            
                            Text("Desktop Table")
                            
                            
                        }
                        
                        Button {
                            
                            currentMenu = "Table Clock"
                            
                        } label: {
                            
                            Text("Table Clock")
                            
                            
                        }

                        
                    } label: {
                        
                        Label {
                            Text(currentMenu)
                        } icon: {
                            Image(systemName: "slider.vertical.3")
                        }
                        .foregroundColor(.white)
                        .padding(.vertical,13)
                        .padding(.horizontal,20)
                        .background(
                        
                        
                            ZStack{
                                
                                Color.black.cornerRadius(20)
                                    .overlay(
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(.red,lineWidth: 3)
                                        
                                
                                        
                                    )
                                    
                                
                                
                            }
                        )

                        
                        
                        
                    }

                    
                    
                    
                    

                }
               .foregroundColor(.black)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(getTitle())
                        .font(.largeTitle.weight(.black))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                    
                    Text("We have range of funinuture")
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.vertical,20)
                
                
                ForEach($funitures){$ftr in
                    
                    
                    
                    CardView(ftr: $ftr)
                    
                }
                
                
                
                
                
                
                
            }
            .padding()
            .padding(.bottom,100)
            
        }
    }
    
    func getTitle()->AttributedString{
        
        var str = AttributedString("Funiture Unique\nStyle")
        
        
        if let range = str.range(of: "Funiture Unique"){
            
            str[range].font = .system(size: 30, weight: .heavy)
        
        }
        if let range = str.range(of: "Style"){
            
            str[range].font = .system(size: 30, weight: .thin)
            str[range].foregroundColor = .green
        
        }
        
        return str
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View{
    @Binding var ftr : Furniture
    
    @State var offset : CGFloat = 0
    @State var lastStoredOffset : CGFloat = 0
    
    @GestureState var gestureOffset : CGFloat = 0
    
    var body: some View{
        
        HStack{
            
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(ftr.name)
                    .font(.title.weight(.bold))
                
                
                Text(ftr.disription)
                    .font(.title3.weight(.light))
                
                
                Text(ftr.price)
                    .font(.largeTitle.bold())
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Image(ftr.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
           
        }
        .padding(.horizontal)
        .padding(.vertical,6)
        .background(
        
            ZStack{
                
                Color.white
                
                Color("Card")
                    .opacity(-offset / 100)
            }
        
        )
        .cornerRadius(16)
        .contentShape(Rectangle())
        .offset(x: offset)
        .background(
        
            ZStack(alignment:.trailing){
                
                Color("Brown")
                
                VStack(spacing:30){
                    
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                    }

                    
                    
                }
                .foregroundColor(.white)
                .padding(.trailing,35)
                
                
                
            }
               
                .cornerRadius(15)
                .padding(.horizontal,4)
            
        
        
        )
        .gesture(
            
            DragGesture().updating($gestureOffset, body: { value, out, _ in
                out = value.translation.width
            })
                .onEnded({ value in
                    
                    let translation = value.translation.width
                    
                    if translation < 0 && -translation > 100{
                        
                        offset = -100
                        
                        
                    }
                    
                    else{
                        
                        offset = 0
                    }
                    
                    lastStoredOffset = offset
                    
                })
        
        
        )
        .animation(.easeInOut, value: gestureOffset == 0)
        .onChange(of: gestureOffset) { newValue in
            
            
            offset = (gestureOffset + lastStoredOffset) > 0 ? 0 : (gestureOffset + lastStoredOffset)
            
        }
        
        
        
        
        
    }
}

extension View{
    
    func getSafeArea()->UIEdgeInsets{
        
        
        guard let screnn = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            
            return .zero
        }
        
        guard let safeArea = screnn.windows.first?.safeAreaInsets else{
            
            return .zero
        }
        
        return safeArea
    }
}

