# FrameChain
Introducing Blockchain-based Web Browser

Framechain is released under the terms of the MIT license.

[Show license](https://github.com/hupiyingwu/FrameChain/blob/master/LICENSE)

### Language:Visual Basic

## Download

[Click here](https://github.com/hupiyingwu/FrameChain/blob/master/FrameChain(EXE%2BCODE).zip)

## Introduction

[View the White Paper](https://github.com/hupiyingwu/FrameChain/blob/master/WhitePaper.pdf)

[Chinese Introduction](https://github.com/hupiyingwu/FrameChain/blob/master/Chinese.md)

## What is Framechain?

### open source,transparent,decentralized

Framechain is a blockchain-based web browser. Its source code is public.Everyone can publish thier own web pages without a server on Framechain.Each web page is saved in the P2P network of Framechain.Users view pages namally will be rewarded with tokens. 

## Why FrameChain is different?

#### The flow of FrameChain is more real

Users can only be rewarded with tokens if they bring real income to advertisers.They can't get tokens through mechanical reading advertisements.It is not true to read advertisements because of the purpose of tokens.

#### FrameChain is secure

FrameChain is a decentralized system, meaning it is secure P2P web browser operated by a network of users. The code are confirmed by distributed consensus and then immutably recorded on the blockchain. Third-parties do not need to be trusted to keep your websites safe.
    
#### FrameChain is untraceable

The addresses of websites and users are obfuscated by default. Movements on the blockchain cannot be linked to a particular user or real-world identity.

#### FrameChain is useful

Everyone has the ability to publish websites in the FrameChain without any servers.The system will make sure that the websites in FrameChain is safe.When users view a web page, the system recommends other web pages to them.

## Network

(https://hupiyingwu.github.io/FrameChain/image/network.png)

### Trackers

All trackers are a HTTP server.You have to download blockchains from some trackers.

Get the total number of blocks:url/maxinum.txt

Get a list("n" is a natural number):url/block[n].txt

Send a command to a tracker

    url/command=[command]

Users can send commands to the tracker and tip the tracker.The tracker will transmit commands to other nodes of the tracker and other users.Everyone can creat a tracker and take some tips

### Share your tracker:[https://github.com/hupiyingwu/FrameChain/issues/1](https://github.com/hupiyingwu/FrameChain/issues/1)

### Nodes

You may need NAT traversal to connect to other nodes.If you don't want this, you can only be an ordinary node and connect to P2P network through tracker.

## Commands list:

Send tokens to an address:

    command{type=cash;money=[tokens];to=[address];}tip{to=[address];money=[tokens];}

Mining:

    command{type=mining;key=[string];}tip{to=[address];money=[tokens];}

Publish a page:

    command{type=software;money=[tokens];hash=[hash(result)];code=[HTML code];nextaddress=[next address];}tip{to=[address];money=[tokens];}

Sending a request for a web page:

    command{type=app;hash=[hash(publisher's command)];nextaddress=[next address];}tip{to=[address];money=[tokens];}

Send result of a page:

    command{type=get;hash=[hash(publisher's command)];result=[result of a page];nextaddress=[next address];}tip{to=[address];money=[tokens];}

Publish a tracker/seed:

    command{type=[tracker/seed];url=[url];}tip{to=[address];money=[tokens];}
    
## Contributing

Anyone is welcome to contribute to FrameChain's codebase! If you have a fix or code change, feel free to submit it as a pull request directly to the "master" branch. Thank you.

## Supporting the project

[Buy me a coffee](https://www.buymeacoffee.com/IgqiDWONr)

[Mining for me](https://cnhv.co/7710u)

 If you want to join our efforts, the easiest thing you can do is support the project financially. 

## Parts of the Solution are Code Complete

The key code has been written，meaning it’s currently in place.But you have to modify part of the code to work properly.

## Timeline

### 2018/6/29 Fix a bug,added code annotations

### 2018/7/8 Update the function of "rsajia","rsajie","js"

