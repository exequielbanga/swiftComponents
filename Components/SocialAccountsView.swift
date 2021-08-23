//
//  SocialAccountsView.swift
//  Components
//
//  Created by Exequiel Banga on 23/08/2021.
//

import SwiftUI

enum SocialAccountType: Hashable {
    case instagram(String)
    case facebook(String)
    case twitter(String)
    case tictoc(String)
    case snapchat(String)
    case youtube(String)
    
    func fullUrl() -> String {
            switch self {
            case .instagram(let url):
                return String("http://www.instagram.com\(url)")
            case .facebook(let url):
                return String("http://www.facebook.com\(url)")
            case .twitter(let url):
                return String("http://www.twitter.com\(url)")
            case .tictoc(let url):
                return String("http://www.tiktok.com\(url)")
            case .snapchat(let url):
                return String("http://www.snapchat.com\(url)")
            case .youtube(let url):
                return String("https://www.youtube.com/user\(url)")
            }
    }
    
    func url() -> String {
            switch self {
            case .instagram(let url):
                return url
            case .facebook(let url):
                return url
            case .twitter(let url):
                return url
            case .tictoc(let url):
                return url
            case .snapchat(let url):
                return url
            case .youtube(let url):
                return url
            }
    }
    func image() -> Image {
            switch self {
            case .instagram:
                return Image("instagram")
            case .facebook:
                return Image("facebook")
            case .twitter:
                return Image("twitter")
            case .tictoc:
                return Image("tiktok")
            case .snapchat:
                return Image("snapchat")
            case .youtube:
                return Image("youtube")
            }
    }
}

struct SocialAccountsView: View {
    
    let backgroundColor: Color
    let fontColor: Color
    
    var socialAccounts: [SocialAccountType] = []

    var body: some View {
        VStack(){
            ForEach(self.socialAccounts, id: \.self){ account in

                HStack{
                    HStack{
                        Spacer()
                        account.image()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight:25,alignment:.center)
                            .padding()
                        Spacer()
                    }.frame(maxWidth:50)
                    .padding(.trailing, 5)
                        Link(account.url(), destination: URL(string: account.fullUrl())!)
                        .foregroundColor(self.fontColor)
                            .frame(maxWidth:.infinity,alignment: .leading)

                }
            }.background(self.backgroundColor)
        }
    }
}

struct SocialAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        SocialAccountsView(backgroundColor: .black, fontColor: .white, socialAccounts: [.tictoc("/tiktokURL"),.facebook("/facebookURL"),.twitter("/twitterURL")])
    }
}
