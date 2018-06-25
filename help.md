Language:Visual Basic

Please share your noods and trackers on https://github.com/hupiyingwu/FrameChain/issues

## Command list:

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

## Download data from the P2P network of Framechain


### All nodes are a HTTP server.All the data are recorded in the files.

Get the total number of blocks:url/maxinum.txt

Get a list("n" is a natural number):url/block[n].txt

### Send a command to a node

    url/command=[command]
