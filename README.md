# 自动布局那些事

Auto Layout是苹果在iOS 6中引进的新技术，这是一种基于约束系统的布局规则，它的出现颠覆了开发人员创建界面的方式，同时我们也发现在较新版本的Android Studio中，很多通过模板创建的应用程序也默认采用了constraint-layout，可见基于约束规则来创建移动软件界面的方式已经被大家普遍认可。

### Autoresizing系统

- 说到Auto Layout，我们有必要先了解一下Autoresizing，所谓Autoresizing，就是当父视图的bounds发生变化时，会根据子视图设置的autoresizing mask自动调整子视图。
- 比如图1是tableView中的某两行，有一个处于右下角的控件

![图1](http://upload-images.jianshu.io/upload_images/10028500-0bd12a3c659e4a91.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

```swift
override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /* 此处略去部分代码*/
        print("width:\(contentViewWidth) height:\(contentViewHeight)")
        //width:320.0 height:44.0
        
        let label = UILabel(frame: CGRect(x: contentViewWidth - lableWidth - margin, y: contentViewHeight - fontsize - margin, width: lableWidth, height: fontsize))
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        contentView.addSubview(label)
}
```

* 如果没有使用Auto Layout，我们需要获取cell的宽度做一些简单的运算确定起始点的位置，为了进一步说明问题，我们在初始化方法中打印了contentView的宽高(320*44)，很明显这个size并不正确，如果根据这个size去布局将会得到一个错误的位置。

* 我们可能会这么做，定义一个全局的屏幕宽度，通过这个常量去计算确实可以保证在竖屏条件下的正确性，但是如果你的页面也出现在iPad中，而且iPad还支持旋转和分屏，那么你的布局依然还是错误的。
* 我们还可能这么做，在以下方法中设置frame，当然这个方法中取到的父视图的大小是正确的。

```swift
override func layoutSubviews() {
        super.layoutSubviews()
        //label.frame = ...
}
```

* 另外一种方法是前面提到的Autoresizing，比如以上的代码中label.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]，表明该控件距离右边的距离保持不变，距离左边的距离跟随父视图变化，距离底部的距离保持不变，距离顶部的距离跟随父视图变化。所以当你使用了Autoresizing，你就可以不在乎cell创建时错误的初始值了，因为它会自动调整，就算是横屏或者分屏，它都表现良好。
* 很明显对于以上的约束，涉及的加加减减虽然不至于太复杂，但也太过繁琐。

* 尽管Auto Layout大有取代Autoresizing之意，但Autoresizing在某些情况下依然不失为一个好的方法，下面的代码用到了自适应的宽高来创建一个安全区域内全屏的tableView，不仅不受导航栏、tabBar影响，而且简洁、明了。

```swift
let tableView = UITableView(frame: view.bounds, style: .plain)
tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
```

### 开始使用Auto Layout
#### 场景

* iPad上有一个广告轮播图(可以同时看到左中右三个广告，广告在滚动过程中宽度一直在变化，当滚动到中间时广告最大)，我们需要在右上角添加一个广告标签以提示用户。很明显，在这个场景里，如果你不选用Auto Layout或是Autoresizing，你很可能需要根据UIScrollViewDelegate的一些方法来实时的调整这个广告标签的位置。
* 多个控件整体居中。不使用自动布局的情况下，你需要计算所有控件宽度的和。
* iPad旋转、分屏适配。
* iPhone X适配。

类似的场景还有很多，如果不使用Auto Layout来布局，你可能需要一些看似不太复杂的计算，而这些计算往往可读性很差，通常会定义若干个常量，而且很难适应各种屏幕。


#### Auto Layout
##### Intrinsic Content Size
> 视图内容的大小通过每个视图的intrinsicContentSize属性表达，它描述了数据未经压缩或裁剪的情况下表达视图全部内容所需的最小空间。

* 使用自动布局，依然需要使用约束来定义视图的位置和大小，然而一些视图会根据所给内容拥有一个固有大小，比如UIKit里的UILabel，UIButton，UISwitch，UITextField，UIImageView等，此时我们可以免去宽高的约束。
* 如果我们想让自定义的视图也拥有这个特性，我们可以在UIView的子类重写intrinsicContentSize，返回一个固有大小
```swift
override var intrinsicContentSize: CGSize {
        return CGSize(width: 44, height: 44)
}

```

##### UILayoutFittingCompressedSize
```swift
@available(iOS 6.0, *)
public let UILayoutFittingCompressedSize: CGSize
```
* 这个常量多在tableViewCell自动计算行高时看到，然而它也可以在普通视图中使用，比如我们通过在自定义的view中添加约束，然后借助UILayoutFittingCompressedSize来实现多控件整体居中这么个需求。
* 图2中**找回密码|紧急冻结|更多选项**整体居中。

![图2](http://upload-images.jianshu.io/upload_images/10028500-fd7520cec595130a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)


* 要完成图2这么一个需求，我们需要定义一个容器，这个容器的宽高根据内部控件的摆放规则自动计算。
* 首先把要添加约束的控件设置translatesAutoresizingMaskIntoConstraints属性为false。

> translatesAutoresizingMaskIntoConstraints : A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.（是否要把autoresizing转成约束）
```swift
    //找回密码按钮
    findPwdButton.translatesAutoresizingMaskIntoConstraints = false
    //紧急冻结按钮
    freezeButton.translatesAutoresizingMaskIntoConstraints = false
    //更多选项按钮
    moreButton.translatesAutoresizingMaskIntoConstraints = false
    //两条分割线
    separatorLine1.translatesAutoresizingMaskIntoConstraints = false
    separatorLine2.translatesAutoresizingMaskIntoConstraints = false
```

* 我们选用VisualFormatLanguage的方式来实现以上的约束,它可以在一行代码中实现多个约束。
```swift
    let viewsDictionary = ["findPwdButton" : findPwdButton, "freezeButton" : freezeButton, "moreButton" : moreButton, "separatorLine1" : separatorLine1, "separatorLine2" : separatorLine2]
    let metric = ["separatorHeight" : 16]
    let constraints = [
        NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[findPwdButton]-[separatorLine1(1)]-[freezeButton]-[separatorLine2(1)]-[moreButton]|",
            options: [.alignAllTop, .alignAllBottom],
            metrics: nil,
            views: viewsDictionary
        ),
        NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[separatorLine1(separatorHeight)]|",
            options: [],
            metrics: metric,
            views: viewsDictionary
        )
    ]
    NSLayoutConstraint.activate(constraints.flatMap{ $0 })
```

##### VisualFormatLanguage 分析
- H:|[findPwdButton]-[separatorLine1(1)]-[freezeButton]-[separatorLine2(1)]-[moreButton]|

- **H:**表明这是一个关于水平方向的约束，这五个控件自左向右依次排开；

- **|**表示父视图的边界，**[]**表示具体控件，而|[findPwdButton]则表明控件[findPwdButton]紧贴父视图的左边界(相当于|-0-[findPwdButton])；
- **-**表示控件间的标准宽度，也可以用具体的数字(比如-10-)来定义控件间的距离。
- "V:|[separatorLine1(separatorHeight)]|"
- **V:**表明这是一个关于竖直方向的约束,该方向只有一个控件。
- 括号内的separatorHeight在metrics里定义，当然也可以直接在括号里面填写数字。
- 参数options表示子控件的摆放规则，[.alignAllTop, .alignAllBottom]意思是这五个控件顶部和底部对齐。正因为有这个约束，当我们指明其中的一个分割线的高度为16时，就意味着其他的几个控件也都是16的高度。至此我们完成了这个容器内所有控件的约束。
##### VisualFormatLanguage小结
- 表示控件的字符串要严格与参数views定义的键值匹配(表示控件宽度或高度的字符串也要严格与参数metrics定义的键值匹配)，以保证约束可以被正确解析。
- 由于button有intrinsicContentSize（根据按钮标题自动计算），我们并没有指明按钮的宽度。
- 选用合适的options可以减少约束的数量。

最后我们选用了上述的intrinsicContentSize属性，同时返回UILayoutFittingCompressedSize，表明视图将根据容器内部的约束(距离上下左右四个方向的约束缺一不可)，选用一个最小的size来刚好包括这几个控件。

```swift
override var intrinsicContentSize: CGSize {
        return UILayoutFittingCompressedSize
    }
```

* 免去了宽高约束，我们很容易就可以让这个控件居中
```swift
override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loginBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            loginBottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loginBottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            NSLayoutConstraint(item: loginBottomView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            view.addConstraint(NSLayoutConstraint(item: loginBottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        }
    }
```

##### NSLayoutAnchor分析
* 以上if内部的自动布局写法从iOS 9开始支持，相比于else内部的那种写法更为简洁、易懂。
* 底部容器控件的水平方向中心等于父视图的水平方向中心。
* 底部容器控件的底部距离屏幕底部10(iOS 11为距离安全区域底部)
* 此处还用到激活(isActive,iOS 8)约束,类似于addConstraint，如果是多个约束的激活，则选用NSLayoutConstraint.activate

##### UINavigationBar的isTranslucent
* iOS 7以后导航栏的isTranslucent属性默认为true，这个最明显的体会是导航栏有半透明的磨砂效果，可以隐约的看到有tableView从顶部穿过，这种方式一般是通过barTintColor的方式去设置的。
* 另外一种则呈现为半透明不带磨砂的效果，这种方式则是通过BackgroundImage的方式去设置背景，如果你的图片是带alpha通道的，或者设置了isTranslucent为true,你都可以很明显的看到tableView穿透导航栏的效果。
```swift
UINavigationBar.appearance().setBackgroundImage(image, for: .default)
UINavigationBar.appearance().barTintColor = UIColor.white
```
* 对于带系统导航栏的页面来讲，如果设置了navigationBar的isTranslucent为true，你的页面布局的起点就从屏幕顶部开始算起，如果设置为false则从导航栏底部开始算起。

* 当然如果你的controller添加了以下这行代码，意味的你的子控件将不自动延伸，你的布局起点就从导航栏底部开始算起。
```swift
self.edgesForExtendedLayout = []
```

* 这么说来，该怎么布局能不受导航栏的isTranslucent的影响呢？


![图3.png](http://upload-images.jianshu.io/upload_images/10028500-961e1a56bf39dd09.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

```swift
override func viewDidLayoutSubviews() {
        topToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            topToolbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            topToolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
            topToolbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            let viewsDictionary = ["topToolbar" : topToolbar, "topLayoutGuide" : topLayoutGuide ] as [String : Any]
            let constraints = [
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[topLayoutGuide][topToolbar(44)]",
                    options: [],
                    metrics: nil,
                    views: viewsDictionary
                ),
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[topToolbar]|",
                    options: [],
                    metrics: nil,
                    views: viewsDictionary
                )
            ]
            NSLayoutConstraint.activate(constraints.flatMap{ $0 })
        }
    }
```

#### topLayoutGuide
- 没错就是topLayoutGuide,在以上的例子中你可以把它当作是导航栏，当然在iOS 11你还可以使用safeAreaLayoutGuide，尽管这两个属性并非UIView子类，但使用起来与UI控件很像。

#### safeAreaLayoutGuide
相信前面的内容已经让你对安全区域有了一定的了解,接下来我们来介绍它。

![图4.png](http://upload-images.jianshu.io/upload_images/10028500-875a079a8934bdea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

* 从上图可以看出扣除刘海、圆角等区域剩下的即为安全区域(图4中青色矩形区域)，如果你的页面还有导航栏、tabBar，安全区域将进一步缩小，由于非安全区域会影响控件的交互，所以适配iPhone X要做的事情就是调整控件的位置，让其处在安全区域内，尽管tableView、collectionView可以在非安全区域活动，但我们总可以通过滚动让其静止在安全区域内。

#### iPhone X底部控件适配

![图5.png](http://upload-images.jianshu.io/upload_images/10028500-3aff6ecdfb9767b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)


```swift
    override func viewDidLayoutSubviews() {
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            bottomToolbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            //底部贴紧安全区域底部
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            //右侧紧贴父视图右侧
            bottomToolbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            //高度为60
            bottomToolbar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint(item: bottomToolbar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        }
    }
```

#### 约束分析
- 以上代码中，我们给了三个方向(左、右、底)的约束和一个高度约束。
- 由于高度约束属于自身的约束，在else内部，toItem我们设置为nil，attribute则为notAnAttribute
- 代码中的bottomToolbar是UIToolbar的子类，仔细看iOS 11的约束我们会发现其实我们并没有让topToolbar紧贴屏幕底部，只是让其紧贴安全区域底部。然而事实是topToolbar自动延伸到底部了。
- 注意：由于iOS 11以后，UIToolbar顶部覆盖一层_UIToolbarContentView会导致添加到UIToolbar的子控件无法响应事件，如果想利用以上自动延伸的特性的同时又能保证子控件可以正常响应事件的话可以如下处理。

```swift
override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
    }
```
- 然而我们面对的更多是普通的UIView子类，我们尝试修改一下继承关系，让上面底部那个控件bottomToolbar直接继承于UIView


![图6.png](http://upload-images.jianshu.io/upload_images/10028500-9379b7bee20cce30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)


- 如果不修改约束，我们获得了图6的效果。现在我们尝试修改约束

```swift
override func viewDidLayoutSubviews() {
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            bottomToolbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            //底部贴紧安全区域底部
//            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            //底部改为贴紧屏幕底部
            bottomToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            //右侧紧贴父视图右侧
            bottomToolbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            //去掉高度为60的约束
            //bottomToolbar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            //改为顶部距离安全区域底部为60
            bottomToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
            
        } else {
            // Fallback on earlier versions
            
        }
    }
```

- 对比以上两个约束，我们去掉了高度约束，添加了顶部约束，同时修改了底部约束。用顶部距离安全区域底部的距离来模拟高度约束，同时底部直接贴紧屏幕底部。

![图7.png](http://upload-images.jianshu.io/upload_images/10028500-d552028cf1d6d336.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

- 上图我们又看到了新的问题，就是底部控件居中的参照物似乎不对。我们需要在那一块不带圆角区域的区域居中，所以这就要求子控件要在安全区域内布局。

```swift
override func layoutSubviews() {
        super.layoutSubviews()
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            button.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12).isActive = true
        } else {
            button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        }
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
```
- 子控件改为在安全区域内布局，我们得到了图5正确的样式。

#### iPhone X简易聊天输入框的适配
- 由于输入框的位置受键盘的影响，这是一个自下而上的动画。
- 下面我们从静态的输入框来逐步实现这个稍微复杂的效果。

![图8.png](http://upload-images.jianshu.io/upload_images/10028500-5781443193d37325.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

- 上图中底部控件暂且称为TextInputToolbar，我们放了两个子视图textField和button，这两个都有intrinsicContentSize，会根据自身的内容(textField根据placeholder，button根据title)计算出自身的高度
- 为了引入自动布局一个新的概念，我们并不打算给它们俩宽度，而是让它们俩自己算。
- 根据前面的内容，我们写出如下代码
```swift
override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["textField" : textField, "button" : button] as [String : Any]

        let constraints = [
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[textField]-[button]-|",
                options: [.alignAllCenterY],
                metrics: nil,
                views: viewsDictionary
            )
        ]
        NSLayoutConstraint.activate(constraints.flatMap{ $0 })
        
        NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 6).isActive = true
        NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -6).isActive = true

    }
```

- 将TextInputToolbar在controller上布局后，我们发现了如下结果。

![图9.png](http://upload-images.jianshu.io/upload_images/10028500-fbee2953089c1767.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

- 由于这两个控件都可以自己算宽度，这就引入一个优先级的问题，很明显，左边的控件似乎先满足。我们尝试把这两个控件的位置对调("H:|-[button]-[textField]-|")

![图10.png](http://upload-images.jianshu.io/upload_images/10028500-a5a75e951ee242d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)
- 很明显除了方向相反以外，其他的似乎是我们要的
#### 内容吸附

> 内容吸附约束限制视图允许自身伸展和填充视图的程度。如果内容吸附优先级较高，则将视图的框架与内在内容相匹配。
- 内容吸附优先级默认为UILayoutPriorityDefaultLow(250)，而且会优先满足左边。
- 回到图9的状态，我们尝试降低一下textField内容吸附的优先级，我们设置一个具体的值249

```swift
textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
```
- 我们得到了图8正确的布局，当然除了让左边控件内容吸附优先级降低外，我们也可以尝试让右边控件内容吸附优先级升高，比如

```swift
button.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
```

#### 压缩阻力
> 压缩阻力约束阻止视图剪切其内容。高压缩阻力优先级可确保显示出视图的完整内在内容。
- 压缩阻力优先级默认值为UILayoutPriorityDefaultHigh(750)
- 当我们尝试往输入框输入文字时，而且文字过长时，我们又看到了异常，发送按钮被挤压直至消失。

![图11.png](http://upload-images.jianshu.io/upload_images/10028500-1de850b4ae029e67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

- 类似于内容吸附优先级的做法，我们尝试提高右边控件的压缩阻力优先级

```swift
button.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
```

- 至此我们完成了输入框自身的布局，接下来我们来看与键盘的交互
- 首先我们先添加监听键盘的一些方法
```swift
NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
```
- 我们把约束设置为当前controller的属性

```swift
var hideConstraint: NSLayoutConstraint?
var showConstraint: NSLayoutConstraint?
```

```swift
//键盘消失时底部贴紧安全区域底部
hideConstraint = textInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
hideConstraint?.isActive = true
            
//键盘出现时底部贴紧屏幕底部，该约束并未激活
showConstraint = textInputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
showConstraint?.isActive = false
```

- 由于键盘的高度从屏幕底部起算，我们添加的底部也是参照屏幕底部做计算
```swift
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        
        adjustTextFieldByKeyboardState(state: true, keyboardInfo: userInfo!)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        let userInfo = notification.userInfo
        adjustTextFieldByKeyboardState(state: false, keyboardInfo: userInfo!)
    }
    
    func adjustTextFieldByKeyboardState(state: Bool, keyboardInfo: [AnyHashable : Any]) {
        
        if state {
            let keyboardFrameVal = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            let keyboardFrame = keyboardFrameVal.cgRectValue
            
            let height = keyboardFrame.size.height
            
            showConstraint?.constant = -height
            hideConstraint?.isActive = false
            showConstraint?.isActive = true
            
        } else {
            hideConstraint?.isActive = true
            showConstraint?.isActive = false
        }
        
        let animationDurationValue = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration = animationDurationValue.doubleValue
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
```

- 我们通过切换两个约束同时改变常量的方式来实现这个动画
- constant是NSLayoutConstraint的属性，通过修改constant的值可以调整一些距离，最后类似于frame的动画，我们只要调用父视图layoutIfNeeded()系统便会帮我们完成动画。
- 最后，我们得到下图的效果

![图12.png](http://upload-images.jianshu.io/upload_images/10028500-94cef69ec77f46fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

#### UIStackView初见
- iOS 9不仅带来了更加简洁的Anchor布局，也带来了UIStackView，这大大方便了我们在垂直或水平方向布局多个子视图，有点类似于Android的线性布局。尽管UIStackView是UIView的一个子类，但它仅作为容器使用，并不会被渲染。
- 下面我们将利用UIStackView来实现一个简易的tabBar

![图13.png](http://upload-images.jianshu.io/upload_images/10028500-aea8ab09cf65517f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

- 对于tabBar的每个item其实是前面提到的多控件居中，只不过这次为竖直方向的居中，在此不再赘述。

```swift
lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
```

- axis：很明显由于我们要堆叠的是水平方向上的5个tab
- distribution：子视图的分布比例，由于tabBar是等分的，此处设置为fillEqually
- alignment：对齐方式
- spacing：间距

- 在看子视图的添加(addArrangedSubview)，我们并不需要为这几个子控件添加约束，一切都是UIStackView帮我们实现的。
```swift
for _ in 1...5 {
            let bottomTabBarItemView = BottomTabBarItemView()
            stackView.addArrangedSubview(bottomTabBarItemView)
}
```






