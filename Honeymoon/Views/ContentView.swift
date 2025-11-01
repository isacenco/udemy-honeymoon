//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ghenadie Isacenco on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @State private var lastCardIndex: Int = 1
    
    @GestureState private var dragState: DragState = .inactive
    
    private let dragArreaThreshold: CGFloat = 65.0
    
    // MARK: - CARD VIEWS
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        
        return views
    }()
    
    // MARK: - MOVE THE CARD
    private func moveCards() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        let newCardView = CardView(honeymoon: honeymoon)
        
        self.cardViews.append(newCardView)
        
    }
    
    // MARK: - TOP CARD
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else { return false }
        
        return index == 0
    }
    
    // MARK: - DRAG STATES
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(translation: let translation):
                return translation
            default:
                return .zero
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        VStack {
            // MARK: - HEADER
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            
            Spacer()
            
            // MARK: - CARDS
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(content: {
                            ZStack {
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width < -dragArreaThreshold && isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width > dragArreaThreshold && isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                    
                            }
                        })
                        .offset(x: isTopCard(cardView: cardView) ? dragState.translation.width : 0, y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && isTopCard(cardView: cardView) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ? Double(dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else { return }
                                    if drag.translation.width < -dragArreaThreshold || drag.translation.width > dragArreaThreshold {
                                        moveCards()
                                    }
                                })
                        )
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - FOOTER
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Wishing a lovely and most precious of the time toghether for the amazing couple."),
                dismissButton: .default(Text("Happy Honeymoon")))
        }
    }
}

#Preview {
    ContentView()
}
