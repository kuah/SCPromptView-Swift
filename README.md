# SCPromptView-Swift
# SCPromptView
![](https://upload-images.jianshu.io/upload_images/2170902-41022bef50f9b131.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


[SCPromptView-Swift](https://github.com/Chan4iOS/SCPromptView-Swift): 显示在顶部的提示控件
[SCPromptView-Objective_C](https://github.com/Chan4iOS/SCPromptView)

**你的star是我最大的动力**


![effect.gif](http://upload-images.jianshu.io/upload_images/2170902-85ffe61c9e99f291.gif?imageMogr2/auto-orient/strip)


## 安装
### 手动安装
下载源码，将`SCPromptView `文件夹拖进项目

### CocoaPod
```
pod 'SCPromptView'
```

## 使用
SCPromptView 的用法，与tableView相似
#### 创建view
```
class TestView: SCPromptView {
    var label:UILabel?
    
    override func sc_setUpCustomSubViews() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.init(red:CGFloat(arc4random()%255)*1.0/255, green: CGFloat(arc4random()%255)*1.0/255, blue: CGFloat(arc4random()%255)*1.0/255, alpha:1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        label = UILabel(frame: contentView.bounds)
        label?.textColor = UIColor.white
        label?.textAlignment = NSTextAlignment.center
        contentView.addSubview(label!)
    }
    override func sc_loadParam(param: Any?) {
        if param != nil {
        let text = param as! String
        label?.text = text
        }else{
            label?.text = ""
        }
    }
}
```
重写两个基础方法

#### 注册
```
sc_prompt_register(viewClass:TestView.classForCoder(), showCommand: "test")
```
#### 发送显示命令
```
///随机颜色显示
func clickBtn(){
        let str:String = "\(num)"
        sc_prompt_show(showCommand: "test", param: str)
        num += 1
    }
```

## 其他Api
```
    ///高度
    func sc_height() -> CGFloat {
    }
    ///滑动距离
    func sc_slideDistanse() -> CGFloat {
    }
    ///显示时间
    func sc_showTime() -> TimeInterval {
      
    }
    ///出现动画时间
    func sc_showAnimationDuration() -> TimeInterval {
        
    }
    ///隐藏动画时间
    func sc_hideAnimationDuration() -> TimeInterval {
        
    }
```

### 必须重写的方法

```
 //MARK: load
    ///设置子控件
    func sc_setUpCustomSubViews(){
        
    }
    func sc_loadParam(param:Any?){
        
    }
```



# SCPromptView

[SCPromptView](https://github.com/Chan4iOS/SCPromptView-Swift)  : A prompt view which show in the top of the screen .


**Your star is my biggest motivation.**

![effect.gif](http://upload-images.jianshu.io/upload_images/2170902-85ffe61c9e99f291.gif?imageMogr2/auto-orient/strip)

## Install
### Manually
Download the source code , copy  folder `SCPromptView` into your project.
### CocoaPod
```
pod 'SCPromptView'
```

## Usage
The usage of SCPromptView is similar to the usage of UITableView.
#### Create Custom View
```
class TestView: SCPromptView {
    var label:UILabel?
    
    override func sc_setUpCustomSubViews() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.init(red:CGFloat(arc4random()%255)*1.0/255, green: CGFloat(arc4random()%255)*1.0/255, blue: CGFloat(arc4random()%255)*1.0/255, alpha:1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        label = UILabel(frame: contentView.bounds)
        label?.textColor = UIColor.white
        label?.textAlignment = NSTextAlignment.center
        contentView.addSubview(label!)
    }
    override func sc_loadParam(param: Any?) {
        if param != nil {
        let text = param as! String
        label?.text = text
        }else{
            label?.text = ""
        }
    }
}
```
Override two basic function.

#### Register
```
sc_prompt_register(viewClass:TestView.classForCoder(), showCommand: "test")
```
#### Show
```
///show random color
///随机颜色显示
func clickBtn(){
        let str:String = "\(num)"
        sc_prompt_show(showCommand: "test", param: str)
        num += 1
    }
```
## Other Api
```
   ///高度
    func sc_height() -> CGFloat {
    }
    ///滑动距离
    func sc_slideDistanse() -> CGFloat {
    }
    ///显示时间
    func sc_showTime() -> TimeInterval {
      
    }
    ///出现动画时间
    func sc_showAnimationDuration() -> TimeInterval {
        
    }
    ///隐藏动画时间
    func sc_hideAnimationDuration() -> TimeInterval {
        
    }
```
### MUST OVERRIDE

```
 //MARK: load
    ///设置子控件
    func sc_setUpCustomSubViews(){
        
    }
    func sc_loadParam(param:Any?){
        
    }
```

