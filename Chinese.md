﻿# 框架链
基于区块链原理的网页浏览器

在MIT许可条件下发布框架链

[查看MIT许可证](https://github.com/hupiyingwu/FrameChain/blob/master/LICENSE)

### 开发语言:Visual Basic

## 下载

[点击下载](https://hupiyingwu.github.io/FrameChain/FrameChain(EXE%2BCODE).zip)

## 简介

[白皮书](https://github.com/hupiyingwu/FrameChain/blob/master/WhitePaper.pdf)

## 什么是框架链？

### 开源，透明，去中心化

框架链是一个基于区块链原理的网页浏览器。它是开源的。任何人无需拥有服务器就可以在框架链上搭建自己的网站。每一个网页都被保存在点对点网络中。正常浏览网页上广告的用户可以获得代币奖励

## 框架链有什么特别之处?

#### 流量是真实的

用户只有在为广告主带来收入后才能获得代币奖励。但是机械的阅读广告无法获得任何奖励因为出于赚钱的目的去阅读广告不是真实的。

#### 框架链是安全的

框架链是一个去中心化的系统，这意味着它是由用户网络操作的安全P2P网络浏览器。网页代码代码通过分布式一致性确认，然后不可变地记录在块链上，无需第三方信任机构来保护你网站的安全。
    
#### 框架链上的网站是不可追踪的

网站和用户的地址会被混淆加密，但不影响网站正常访问。任何人在框架链上的任何举动都不会暴露出他在真实世界的身份，即使是他自愿的。

#### 框架链很牛逼

每个人都有能力在没有服务器的情况下在框架链上发布网站，而系统负责保护网站的安全。当用户浏览一个网页使，系统会自动向他推荐其他类似的网页。

## 网络

![Network](https://hupiyingwu.github.io/FrameChain/image/network.png)

### Trackers

每一个tracker都相当于一个HTTP服务器，你需要从tracker上下载区块。

获取区块的总数:url/maxinum.txt

下载单个区块("n" 是一个自然数):url/block[n].txt

向tracker发送指令：

    url/command=[command]

用户可以向tracker发送指令但必须支付小费，然后tracker会向其他节点和其他tracker转发指令。每一个人都可以成为tracker然后收取小费。

### 在这分享你的tracker:[https://github.com/hupiyingwu/FrameChain/issues/1](https://github.com/hupiyingwu/FrameChain/issues/1)

### 节点

你可能需要内网穿透才能连接到其他节点。如果你不喜欢这样，你只能成为一个普通的节点通过tracker连接整个网络。

## 指令列表:

向一个地址发送代币:

    command{type=cash;money=[代币数量，可以是小数];to=[对方的收款地址];}tip{to=[tracker的收款地址，用于支付小费];money=[小费];}

挖矿:

    command{type=mining;key=[幸运数字];}tip{to=[tracker收款地址];money=[小费];}

发布一个网页:

    command{type=software;money=[代币奖励];hash=[hash(网页返回结果)];code=[加密后的网页代码];nextaddress=[找零地址];}tip{to=[tracker收款地址];money=[小费];}

发送访问请求:

    command{type=app;hash=[网页的ID];nextaddress=[找零地址];}tip{to=[tracker收款地址];money=[小费];}

发送网页返回结果:

    command{type=get;hash=[hash(publisher's command)];result=[result of a page];nextaddress=[next address];}tip{to=[address];money=[tokens];}

公布一个tracker:

    command{type=[tracker/seed];url=[url];}tip{to=[address];money=[tokens];}
    
## 贡献

欢迎每个人对代码仓库做出贡献! 如果您有修复或代码更改，请将它作为请求提交给“主”分支。万分感谢。

## 支持我的项目


[为我挖矿（需要关闭反挖矿软件）](https://cnhv.co/7710u)

 如果你想加入我们的努力，你能做的最简单的事情就是在经济上支持这个项目。

## 部分代码已经开发完成

关键代码已经开发完成，意味着框架链随时可以就位。你可以适当修改一下框架链的代码。

# 白皮书中文版：

## 摘要：

框架链是一个基于区块链原理的网页浏览器，它的源代码是公开的。任何人无需拥有服务器就可以在框架链上发布自己的网页。每个网页都保存在整个P2P网络中，数字签名技术能保证网页不被篡改，P2P网络能让网站免疫绝大部分网络攻击。网站管理员只需要写好代码，系统会自动宣传站长的网站。正常浏览网页的用户会获得代币奖励。用户获得代币后可以发布他们自己的网页、赞助他们喜欢的网站以及出售多余的代币；同时网站也能获得现金收入。

简介：现在我们只需要在搜索引擎中搜索关键词就可以访问我们喜欢的网页。浏览器会根据我们提供的网址链接到一个服务器，然后从服务器上下载网页文件。绝大部分网站的利润通过我们浏览广告获得，另一小部分则通过在线出售商品获得，但是这仍具有与生俱来的缺陷。

一.人们了解网站的途径

        大部分搜索引擎和网址导航只会展示它希望用户看到的网站。在多数情况下，网站交的钱越多，排名就越靠前。这回导致优秀的网站被埋没在“垃圾”网站中并且用户很难找到他们真正喜欢的网站

二.恶意软件

        很多恶意软件会采用篡改网页内容、屏蔽网址等方式损害网站和用户的利益。甚至部分恶意软件以拦截广告的名义屏蔽网页上的广告，并在原来广告的位置上插入别的广告。

三.攻击者

        通常情况下网站的服务器遭到黑客的攻击会导致网页无法正常访问。攻击者还会散播谣言使用户失去对网站的信任。许多攻击者通过这些方式勒索网站管理员。

四.广告

        如今越来越多的网站为了获得利润在页面上插入大量令人反感的广告，导致用户经常性无视这些广告。全球范围内超过6亿台设备运行防广告插件，并且这个数字还在增长。作为应对，部分网站通过广告自动点击软件骗取广告费。去年恶意机器人造成了7.2亿美元的欺诈。

现在就需要一个基于区块链原理的网页浏览器——框架链。每一个网页都会被记录在区块中，即使没有服务器网页仍然可以正常访问。区块链本身的特点和数字签名技术会保证网页不会被篡改。用户可以自定义排名规则以找到他们喜欢的网站。用户正常浏览网页（没有添加、删除、修改网页内容）会获得代币奖励。框架链通过一种特别的算法加密网页发布者的真实身份。用于保护网站免受谣言的攻击。在这篇文章里，我们将具体说明框架链的工作原理。

## 谁能得到什么：

最初的代币由挖矿产生。网站管理员向系统支付代币发布网页。系统会将网页信息写入区块。用户读取区块就能获得所有网页的信息，也就是说系统会自动宣传所有保存在框架链上的网站。用户只需正常浏览网页就能获得代币奖励，同时用户浏览广告、购买商品也会为网站带来收入。用户获得代币后也可以发布自己的网页，出售代币，以及赞助他们喜欢的网站。

## 网页返回结果：

网页返回结果指网页内容的摘要。网页返回结果可以证明用户是否正常浏览了网页。网站管理员发布网页时必须公布网页返回结果的哈希值，同时向系统支付代币奖励的10%作为押金，因为只要用户没有正常浏览网页（比如网页上的广告被屏蔽）就会导致网页返回结果的哈希值发生改变。当用户发送请求时系统自动从用户的账户里扣除代币奖励的10%作为押金，因此当用户发现网页内容被修改后，绝大部分用户会主动关闭那些恶意软件。用户提交完网页返回结果后系统会自动退还所有用户和网站管理员的押金

## 网络加密传输：

框架链采用RSA非对称加密的方式对网页进行数字签名。在这里，私钥用于签名，公钥用于验证签名，所以每个网站都需要公开它的公钥，而私钥由网站管理员保管。攻击者有可能通过公钥计算出私钥，只不过很困难。但他们绝不可能冒充网站发布信息，因为在框架链中每个网站的地址都是它公钥的哈希值。每个网站一旦发布新的网页原来的地址就会作废。所以即使攻击者使用量子计算机也无法冒充网站发布信息。网站管理员可能会把自己的一部分代币转给下一个地址，另一部分用来赞助其他网站。这样用户就不能确定任意两个网页是否由同一个发布者发布。用户对一个网站的信任仅取决于网站支付了多少押金。

## 网页发布：

每个网页访问一次就作废。如果网站管理员想让更多人浏览自己的网页，需要生成一些网页返回结果各不相同的网页，以防止某一个用户只浏览了一次网页就获得了所以代币奖励。绝大部分用户会优先浏览代币奖励最多的网页，但并不是拥有越多代币的网站访问量就越高。假设A发布了奖励为10代币的网页，B因为浏览了A的网页获得了10代币，然后B发布了自己的网页。后来C同时发现了A和B的网页。由于A的代币已经支付给了B，浏览A的网页就不会有任何奖励了。为了获得代币，C会选择浏览B的网页。为了防止网站大量发布毫无意义的网页（例如乱码），站长必须额外向系统支付20代币。

## 结论：

我们提出了一种基于区块链原理的网页浏览器。它通过区块链技术保护网站安全并鼓励用户浏览网页。
