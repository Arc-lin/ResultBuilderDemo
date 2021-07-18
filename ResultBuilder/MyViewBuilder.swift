//
//  MyViewBuilder.swift
//  ResultBuilder
//
//  Created by Arc Lin on 2021/7/18.
//

import UIKit

protocol ViewBuilder {
    func build() -> UIView
}

@resultBuilder
struct ScrollableViewBuilder {
    static func buildBlock(_ components: ViewBuilder...) -> ViewBuilder {
        return ViewContainer(contents: components)
    }
    static func buildEither(first component: ViewBuilder) -> ViewBuilder {
        return component
    }
    static func buildEither(second component: ViewBuilder) -> ViewBuilder {
        return component
    }
    static func buildOptional(_ component: ViewBuilder?) -> ViewBuilder {
        return component ?? WhiteView()
    }
    static func buildArray(_ components: [ViewBuilder]) -> ViewBuilder {
        return ViewContainer(contents: components)
    }
    
    static func buildFinalResult(_ component: ViewBuilder) -> ViewBuilder {
        return ScrollableContainer(contents: [component])
    }
    
    static func buildExpression(_ expression: ViewBuilder) -> ViewBuilder {
        return expression
    }
    
    static func buildExpression(_ expression: ()) -> ViewBuilder {
        return EmptyBuilder()
    }
}

struct EmptyBuilder : ViewBuilder {
    func build() -> UIView {
        return UIView.init()
    }
}

struct ScrollableContainer : ViewBuilder {
    var contents : [ViewBuilder]
    func build() -> UIView {
        let scrollView = UIScrollView.init(frame: UIScreen.main.bounds)
        _ = contents.reduce(CGFloat(0)) { currentY, builder in
            let view = builder.build()
            view.frame.origin.y = currentY
            scrollView.addSubview(view)
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: scrollView.subviews.last!.frame.maxY)
            return currentY + view.frame.size.height
        }
        return scrollView
    }
}

struct ViewContainer : ViewBuilder {
    var contents : [ViewBuilder]
    func build() -> UIView {
        let container = UIView(frame: UIScreen.main.bounds)
        _ = contents.reduce(CGFloat(0), { currentY, builder in
            let view = builder.build()
            view.frame.origin.y = currentY
            container.addSubview(view)
            container.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: container.subviews.last!.frame.maxY)
            return currentY + view.frame.size.height
        })
        return container
    }
}

struct WhiteView : ViewBuilder {
    func build() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.backgroundColor = .white
        return view
    }
}

struct RedView : ViewBuilder {
    func build() -> UIView {
        let banner = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        banner.backgroundColor = UIColor.red
        return banner
    }
}

struct BlueView : ViewBuilder {
    func build() -> UIView {
        let goodsView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350))
        goodsView.backgroundColor = UIColor.blue
        return goodsView
    }
}

struct GreenView : ViewBuilder {
    func build() -> UIView {
        let dynamicView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        dynamicView.backgroundColor = UIColor.green
        return dynamicView
    }
}


