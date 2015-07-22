title: stylin-study
date: 2015-06-05 07:55:00
tags:
---
文本用闭合标签 `<p>test</p>`
引用内容用自闭合标签 `<img src="song.jpg" />`
ol ordered list
ul unordered list
dl definition list
src source
href hyperlink reference
img 是行内元素
<a> anchor 锚
alt alternative
根据CSS标准，默认情况下，多个空白会被浏览器叠加为一个

行内样式
嵌入样式

    <style type="text/css">
    </style>

链接样式

    <link href="style.css" rel="stylesheet" type="text/css" />
    @import url(css/style.css)

上下文选择符
descendant combinator selector (后代组合式选择符)
标签1 标签2 {声明}
子选择符 >
标签1 > 标签2
标签2必须是标签1的子元素
紧邻同胞选择符 +
标签1 + 标签2
h2 + p {font-variant: small-caps;}
一般同胞选择符 ~
标签1 ~ 标签2
h2 ~ a {color:red;}
通用选择符 *
section * a {font-size: 1.3em;}
ID和类选择符
标签带类选择符
把标签名和类选择符写在一块
p.specialtext {color: red;}
多类选择符
.specialtext.featured {font-size: 120%;}
属性选择符
标签名[属性名]
属性值选择符
标签名[属性名="属性值"] (引号可加可不加)

伪类
UI伪类
链接伪类
a:link
a:visited
a:hover
a:active
css3用双冒号代替单冒号 表示伪类
:focus伪类
:target伪类

结构化伪类
:first-child  :last-child
ol.results li:first-child {color: blue;}
:nth-child
e:nth-child(n)
e表示元素名，n表示一个数值（也可以使用odd或even）

伪元素
伪元素就是你的文档中若有实无的元素
::first-letter
p::first-letter {font-size:300%;}
::first-line
p::first-line {font-variant: small-caps;}
::before ::after
用于在特定元素前面或后面添加特殊内容
p.age::before {content: "Age: ";}

层叠
浏览器默认样式表
用户样式表
作者链接样式表
作者嵌入样式
作者行内样式
层叠规则
1：找到应用给每个元素和属性的所有声明
2：按照顺序和权重排序
3：按特指度排序
计算特指度
I-C-E
1.选择符中有一个ID，就在I的位置上加1
2.选择符中有一个类，就在C的位置上加1
3.选择符中有一个元素（标签）名，就在E的位置上加1
4.得到一个三位数 最大的特指度最高

4.顺序决定权重

定位元素
position display float
简写属性
{margin:5px 10px 12px 8px;}
属性值的顺序是 上 右 下 左 顺时针方向
如果哪个值没有写 那就使用对边的值
{margin:12px 10px 6px;} 在这个例子中，由于没有写最后一个值（左边的值），所以左边就会使用右边的值，即10px。
垂直方向上的外边距会叠加
只有普通文档流中块级元素的垂直空白边才会发生空白边叠加。行内元素，浮动元素或者定位元素之间是不会产生空白边叠加。
元素的顶空白边与前面元素的底空白边发生叠加
元素的顶空白边与父元素的顶空白边发生叠加
元素的顶空白边与底部空白边发生叠加
空元素中已经叠加的空白边与另一个空元素的空白边发生叠加

盒子的width属性设定的只是盒子内容区的宽度，而非盒子要占据的水平宽度

强迫父元素包围其浮动的子元素有三种方式
1.为父元素应用overflow:hidden
2.浮动父元素
3.在父元素内容的末尾添加非浮动元素，可以直接在标记中加，也可以通过给父元素添加clearfix类来加

不能在下拉菜单的顶级元素上应用overflow:hidden,否则作为其子元素的下拉菜单就不会显示了
不能对已经靠自动外边距居中的元素使用“浮动父元素”技术，否则他就不会再居中，而是根据浮动值浮动到左边或右边了。

font and text

font:
font-family
font-size
font-style
font-weight
font-variant
font(简写属性)
    1.必须声明font-size和font-family的值
    2.声明顺序
        1 font-weight, font-style, font-variant不分先后
        2 然后是font-size
        3 最后是font-family
        example p {font: bold italic small-caps .9em helvetica, arial, sans-serif;}
                p {font: 1.2em/1.4 helvetica, arial, sans-serif;}

font collection
    serif(衬线字体), sans-serif(无衬线字体), monospace(等宽字体), cursive(手写体), fantasy
    font family
        Times, Helvetica
        font face
        Times Roman, Times Bold, Helvetica Condensed, bodoni italic

font-size是可以继承的
1em = 16像素
h1 2em h2 1.5em p 1em
修改body元素的字体大小，不会影响页面中以绝对单位控制的元素，但没有设定字体大小的元素则会与body的字体大小成比例变化。

text:
text-indent
letter-spacing
word-spacing
text-decoration
text-align
line-height
text-transform
vertical-align


VSP (Vendor Specific Prefixes) 厂商前缀 自动添加VPS，可以使用prefix-free腻子脚本
