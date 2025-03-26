//
//  PlansView.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 22/03/25.
//

import SwiftUI

private enum PlanState {
    case equilibrado
    case ahorro
    case meta
    case prediccion
    case analisis
}

struct PlansView: View {
    
    @State private var planState: PlanState? = nil
    

    
    private let gridColums = [
        GridItem(.flexible(minimum: 170, maximum: 170)),
        GridItem(.flexible(minimum: 170, maximum: 170)),
    ]
    
    private var dynamicTitle: String {
        switch planState {
        case .equilibrado:
            return "Equilibrio segun tus necesidades"
        case .ahorro:
            return "Mas ahorro, mas seguridad"
        case .meta:
            return "Con una meta lista"
        case .prediccion:
            return "Prediccion y correjiendo errores"
        case .analisis:
            return "Analisa y optimiza"
        case .none:
            return ""
        }
    }
    
    private var dynamicColor: Color {
        switch planState {
        case .equilibrado:
            return .orange
        case .ahorro:
            return .green
        case .meta:
            return .mint
        case .prediccion:
            return .pink
        case .analisis:
            return .purple
        case .none:
            return .clear
        }
    }
    
    private var dynamicDescription: String {
        switch planState {
        case .equilibrado:
            return "Regulamos un poco tu presupuesto actual a uno equilibrado para lograr un balance en tus finanzas."
        case .ahorro:
            return "Segun un anilizas a tu presupues te ofrecemos un plan de ahorro maximo mensuales y anuales estricto."
        case .meta:
            return "Analicemos tu presumuesto y  tu ahorro de meta desea con unos parametros para dar el mejor plan."
        case .prediccion:
            return "Segun tu presupuesto actual predicemos tus gastos anuelos y ten una vision a futuro."
        case .analisis:
            return "Analicemos cada parametro de tu presupuesto y te daremos algunos consejos para optimizarlo."
        case .none:
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                HStack {
                    Text("Seleeccione una herramienta de prediccion de su presupuesto usando inteligengia artificial")
                        .font(.custom("Figtree", size: 11))
                        .foregroundStyle(.lightGrayVercel)
                        .frame(width: 280, alignment: .leading)
                    Spacer()
                }
                .padding(.bottom, 8)
                
                LazyVGrid(columns: gridColums, spacing: 10) {
                    
                    VStack {
                        Button {
                            withAnimation(.bouncy(duration: 0.4)) {
                                if planState == .equilibrado { planState = nil }
                                else { planState = .equilibrado }
                            }
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.orange)
                                    .shadow(color: dynamicColor, radius: planState == PlanState.equilibrado ? 3 : 0)

                                Text("Equilabrado")
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 170, height: 200)
                            .shadow(color: dynamicColor, radius: planState == PlanState.equilibrado ? 5 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.borderGray)
                            }
                        }
                        
                        Button {
                            withAnimation(.bouncy(duration: 0.4)) {
                                if planState == .meta { planState = nil }
                                else { planState = .meta }
                            }
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "macbook.gen2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.mint)
                                    .shadow(color: dynamicColor, radius: planState == PlanState.meta ? 3 : 0)
                                Text("Meta de compra")
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 170, height: 100)
                            .shadow(color: dynamicColor, radius: planState == PlanState.meta ? 5 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.borderGray)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100)
                    }
                    
                    VStack {
                        
                        Button {
                            withAnimation(.bouncy(duration: 0.4)) {
                                if planState == .ahorro { planState = nil }
                                else { planState = .ahorro }
                            }
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "leaf.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.green)
                                    .shadow(color: dynamicColor, radius: planState == PlanState.ahorro ? 3 : 0)

                                Text("Maximo Ahorro")
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 170, height: 100)
                            .shadow(color: dynamicColor, radius: planState == PlanState.ahorro ? 5 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.borderGray)
                            }
                        }
                        
                        Button {
                            withAnimation(.bouncy(duration: 0.4)) {
                                if planState == .prediccion { planState = nil }
                                else { planState = .prediccion }
                            }
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "chart.line.text.clipboard")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.pink)
                                    .shadow(color: dynamicColor, radius: planState == PlanState.prediccion ? 3 : 0)
                                Text("Prediccion anual")
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 170, height: 200)
                            .shadow(color: dynamicColor, radius: planState == PlanState.prediccion ? 5 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.borderGray)
                            }
                        }
                    }
                }
                
                Button {
                    withAnimation(.easeInOut) {
                        if planState == .analisis { planState = nil }
                        else { planState = .analisis }
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "cpu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.purple)
                            .shadow(color: dynamicColor, radius: planState == PlanState.analisis ? 3 : 0)

                        Text("Analisis de presupuesto")
                            .fontWeight(.semibold)
                    }
                    .frame(width: 350, height: 100)
                    .shadow(color: dynamicColor, radius: planState == PlanState.analisis ? 5 : 0)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.borderGray)

                    }
                }
                
                VStack(alignment: .leading , spacing: 7) {
                    Text(dynamicTitle)
                        .font(.custom("Figtree", size: 22))
                        .foregroundStyle(dynamicColor)
                    
                    Text(dynamicDescription)
                        .font(.custom("Figtree", size: 13))
                }
                .padding(.vertical, 8)

                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Empezar")
                        .foregroundStyle(.white)
                        .font(.custom("Figtree", size: 22))
                        .frame(width: 300, height: 10, alignment: .center)
                        .opacity(planState != nil ? 1 : 0.2)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.pink, .blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .opacity(planState != nil ? 1 : 0.4)
                                .shadow(color: .blue ,radius: planState != nil ? 7 : 0)
                        }
                }
                .padding(.bottom)
                
            }
            .font(.custom("Figtree", size: 15))
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "leaf")
                            .foregroundStyle(.green)
                        Text("JPlans")
                            .font(.custom("Figtree", size: 22))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.green, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "apple.intelligence")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .pink, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                }
            }
        }
        
    }
}

#Preview {
    PlansView()
}
