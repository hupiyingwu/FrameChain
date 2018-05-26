VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3030
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3030
   ScaleWidth      =   4560
   StartUpPosition =   3  '窗口缺省
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const BITS_TO_A_BYTE = 8
Private Const BYTES_TO_A_WORD = 4
Private Const BITS_TO_A_WORD = 32
 Const a As Byte = 20 '密钥
Const b As Byte = 40 '密钥
Private m_lOnBits(30)
Private m_l2Power(30)
Private Function StrJiaMi(ByVal strSource As String, ByVal Key1 As Byte, _
ByVal Key2 As Integer) As String
Dim bLowData As Byte
Dim bHigData As Byte
Dim i As Integer
Dim strEncrypt As String
Dim strChar As String
For i = 1 To Len(strSource)
'从待加（解）密字符串中取出一个字符
strChar = Mid(strSource, i, 1)
'取字符的低字节和Key1进行异或运算
bLowData = AscB(MidB(strChar, 1, 1)) Xor Key1
'取字符的高字节和K2进行异或运算
bHigData = AscB(MidB(strChar, 2, 1)) Xor Key2
'将运算后的数据合成新的字符
If Len(Hex(bLowData)) = 1 Then
strEncrypt = strEncrypt & "0" & Hex(bLowData)
Else
strEncrypt = strEncrypt & Hex(bLowData)
End If
If Len(Hex(bHigData)) = 1 Then
strEncrypt = strEncrypt & "0" & Hex(bHigData)
Else
strEncrypt = strEncrypt & Hex(bHigData)
End If
Next
StrJiaMi = strEncrypt
End Function

Private Function StrJiMi(ByVal strSource As String, ByVal Key1 As Byte, _
ByVal Key2 As Integer) As String
Dim bLowData As Byte
Dim bHigData As Byte
Dim i As Integer
Dim strEncrypt As String
Dim strChar As String
For i = 1 To Len(strSource) Step 4
'从待加（解）密字符串中取出一个字符
strChar = Mid(strSource, i, 4)
'取字符的低字节和Key1进行异或运算
bLowData = "&H" & Mid(strChar, 1, 2)
bLowData = bLowData Xor Key1
'取字符的高字节和K2进行异或运算
bHigData = "&H" & Mid(strChar, 3, 2)
bHigData = bHigData Xor Key2
'将运算后的数据合成新的字符
strEncrypt = strEncrypt & ChrB(bLowData) & ChrB(bHigData)
Next
StrJiMi = strEncrypt
End Function

 Function getnum(base As String, code As String) As Long
Dim lngA As Long
Dim lngB As Long
Dim lngC As Long
lngA = Len(base)
lngB = Len(code)
lngC = Len(Replace(base, code, ""))
getnum = (lngA - lngC) / lngB
End Function
Private Function LShift(lValue, iShiftBits)
If iShiftBits = 0 Then
LShift = lValue
Exit Function
ElseIf iShiftBits = 31 Then
If lValue And 1 Then
LShift = &H80000000
Else
LShift = 0
End If
Exit Function
ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
Err.Raise 6
End If
 
If (lValue And m_l2Power(31 - iShiftBits)) Then
LShift = ((lValue And m_lOnBits(31 - (iShiftBits + 1))) * m_l2Power(iShiftBits)) Or &H80000000
Else
LShift = ((lValue And m_lOnBits(31 - iShiftBits)) * m_l2Power(iShiftBits))
End If
End Function
 
Private Function RShift(lValue, iShiftBits)
If iShiftBits = 0 Then
RShift = lValue
Exit Function
ElseIf iShiftBits = 31 Then
If lValue And &H80000000 Then
RShift = 1
Else
RShift = 0
End If
Exit Function
ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
Err.Raise 6
End If
 
RShift = (lValue And &H7FFFFFFE) \ m_l2Power(iShiftBits)
 
If (lValue And &H80000000) Then
RShift = (RShift Or (&H40000000 \ m_l2Power(iShiftBits - 1)))
End If
End Function
 
Private Function RotateLeft(lValue, iShiftBits)
RotateLeft = LShift(lValue, iShiftBits) Or RShift(lValue, (32 - iShiftBits))
End Function
 
Private Function AddUnsigned(lX, lY)
Dim lX4
Dim lY4
Dim lX8
Dim lY8
Dim lResult
 
lX8 = lX And &H80000000
lY8 = lY And &H80000000
lX4 = lX And &H40000000
lY4 = lY And &H40000000
 
lResult = (lX And &H3FFFFFFF) + (lY And &H3FFFFFFF)
 
If lX4 And lY4 Then
lResult = lResult Xor &H80000000 Xor lX8 Xor lY8
ElseIf lX4 Or lY4 Then
If lResult And &H40000000 Then
lResult = lResult Xor &HC0000000 Xor lX8 Xor lY8
Else
lResult = lResult Xor &H40000000 Xor lX8 Xor lY8
End If
Else
lResult = lResult Xor lX8 Xor lY8
End If
 
AddUnsigned = lResult
End Function
 
Private Function md5_F(x, y, z)
md5_F = (x And y) Or ((Not x) And z)
End Function
 
Private Function md5_G(x, y, z)
md5_G = (x And z) Or (y And (Not z))
End Function
 
Private Function md5_H(x, y, z)
md5_H = (x Xor y Xor z)
End Function
 
Private Function md5_I(x, y, z)
md5_I = (y Xor (x Or (Not z)))
End Function
 
Private Sub md5_FF(a, b, c, d, x, s, ac)
a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_F(b, c, d), x), ac))
a = RotateLeft(a, s)
a = AddUnsigned(a, b)
End Sub
 
Private Sub md5_GG(a, b, c, d, x, s, ac)
a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_G(b, c, d), x), ac))
a = RotateLeft(a, s)
a = AddUnsigned(a, b)
End Sub
 
Private Sub md5_HH(a, b, c, d, x, s, ac)
a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_H(b, c, d), x), ac))
a = RotateLeft(a, s)
a = AddUnsigned(a, b)
End Sub
 
Private Sub md5_II(a, b, c, d, x, s, ac)
a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_I(b, c, d), x), ac))
a = RotateLeft(a, s)
a = AddUnsigned(a, b)
End Sub
 
Private Function ConvertToWordArray(sMessage)
Dim lMessageLength
Dim lNumberOfWords
Dim lWordArray()
Dim lBytePosition
Dim lByteCount
Dim lWordCount
 
Const MODULUS_BITS = 512
Const CONGRUENT_BITS = 448
 
lMessageLength = Len(sMessage)
 
lNumberOfWords = (((lMessageLength + ((MODULUS_BITS - CONGRUENT_BITS) \ BITS_TO_A_BYTE)) \ (MODULUS_BITS \ BITS_TO_A_BYTE)) + 1) * (MODULUS_BITS \ BITS_TO_A_WORD)
ReDim lWordArray(lNumberOfWords - 1)
 
lBytePosition = 0
lByteCount = 0
Do Until lByteCount >= lMessageLength
lWordCount = lByteCount \ BYTES_TO_A_WORD
lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE
lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(Asc(Mid(sMessage, lByteCount + 1, 1)), lBytePosition)
lByteCount = lByteCount + 1
Loop
 
lWordCount = lByteCount \ BYTES_TO_A_WORD
lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE
 
lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(&H80, lBytePosition)
 
lWordArray(lNumberOfWords - 2) = LShift(lMessageLength, 3)
lWordArray(lNumberOfWords - 1) = RShift(lMessageLength, 29)
 
ConvertToWordArray = lWordArray
End Function
 
Private Function WordToHex(lValue)
Dim lByte
Dim lCount
 
For lCount = 0 To 3
lByte = RShift(lValue, lCount * BITS_TO_A_BYTE) And m_lOnBits(BITS_TO_A_BYTE - 1)
WordToHex = WordToHex & Right("0" & Hex(lByte), 2)
Next
End Function
 
Public Function MD5(sMessage, stype)
m_lOnBits(0) = CLng(1)
m_lOnBits(1) = CLng(3)
m_lOnBits(2) = CLng(7)
m_lOnBits(3) = CLng(15)
m_lOnBits(4) = CLng(31)
m_lOnBits(5) = CLng(63)
m_lOnBits(6) = CLng(127)
m_lOnBits(7) = CLng(255)
m_lOnBits(8) = CLng(511)
m_lOnBits(9) = CLng(1023)
m_lOnBits(10) = CLng(2047)
m_lOnBits(11) = CLng(4095)
m_lOnBits(12) = CLng(8191)
m_lOnBits(13) = CLng(16383)
m_lOnBits(14) = CLng(32767)
m_lOnBits(15) = CLng(65535)
m_lOnBits(16) = CLng(131071)
m_lOnBits(17) = CLng(262143)
m_lOnBits(18) = CLng(524287)
m_lOnBits(19) = CLng(1048575)
m_lOnBits(20) = CLng(2097151)
m_lOnBits(21) = CLng(4194303)
m_lOnBits(22) = CLng(8388607)
m_lOnBits(23) = CLng(16777215)
m_lOnBits(24) = CLng(33554431)
m_lOnBits(25) = CLng(67108863)
m_lOnBits(26) = CLng(134217727)
m_lOnBits(27) = CLng(268435455)
m_lOnBits(28) = CLng(536870911)
m_lOnBits(29) = CLng(1073741823)
m_lOnBits(30) = CLng(2147483647)
 
m_l2Power(0) = CLng(1)
m_l2Power(1) = CLng(2)
m_l2Power(2) = CLng(4)
m_l2Power(3) = CLng(8)
m_l2Power(4) = CLng(16)
m_l2Power(5) = CLng(32)
m_l2Power(6) = CLng(64)
m_l2Power(7) = CLng(128)
m_l2Power(8) = CLng(256)
m_l2Power(9) = CLng(512)
m_l2Power(10) = CLng(1024)
m_l2Power(11) = CLng(2048)
m_l2Power(12) = CLng(4096)
m_l2Power(13) = CLng(8192)
m_l2Power(14) = CLng(16384)
m_l2Power(15) = CLng(32768)
m_l2Power(16) = CLng(65536)
m_l2Power(17) = CLng(131072)
m_l2Power(18) = CLng(262144)
m_l2Power(19) = CLng(524288)
m_l2Power(20) = CLng(1048576)
m_l2Power(21) = CLng(2097152)
m_l2Power(22) = CLng(4194304)
m_l2Power(23) = CLng(8388608)
m_l2Power(24) = CLng(16777216)
m_l2Power(25) = CLng(33554432)
m_l2Power(26) = CLng(67108864)
m_l2Power(27) = CLng(134217728)
m_l2Power(28) = CLng(268435456)
m_l2Power(29) = CLng(536870912)
m_l2Power(30) = CLng(1073741824)
 
 
Dim x
Dim k
Dim AA
Dim BB
Dim CC
Dim DD
Dim a
Dim b
Dim c
Dim d
 
Const S11 = 7
Const S12 = 12
Const S13 = 17
Const S14 = 22
Const S21 = 5
Const S22 = 9
Const S23 = 14
Const S24 = 20
Const S31 = 4
Const S32 = 11
Const S33 = 16
Const S34 = 23
Const S41 = 6
Const S42 = 10
Const S43 = 15
Const S44 = 21
 
x = ConvertToWordArray(sMessage)
 
a = &H67452301
b = &HEFCDAB89
c = &H98BADCFE
d = &H10325476
 
For k = 0 To UBound(x) Step 16
AA = a
BB = b
CC = c
DD = d
 
md5_FF a, b, c, d, x(k + 0), S11, &HD76AA478
md5_FF d, a, b, c, x(k + 1), S12, &HE8C7B756
md5_FF c, d, a, b, x(k + 2), S13, &H242070DB
md5_FF b, c, d, a, x(k + 3), S14, &HC1BDCEEE
md5_FF a, b, c, d, x(k + 4), S11, &HF57C0FAF
md5_FF d, a, b, c, x(k + 5), S12, &H4787C62A
md5_FF c, d, a, b, x(k + 6), S13, &HA8304613
md5_FF b, c, d, a, x(k + 7), S14, &HFD469501
md5_FF a, b, c, d, x(k + 8), S11, &H698098D8
md5_FF d, a, b, c, x(k + 9), S12, &H8B44F7AF
md5_FF c, d, a, b, x(k + 10), S13, &HFFFF5BB1
md5_FF b, c, d, a, x(k + 11), S14, &H895CD7BE
md5_FF a, b, c, d, x(k + 12), S11, &H6B901122
md5_FF d, a, b, c, x(k + 13), S12, &HFD987193
md5_FF c, d, a, b, x(k + 14), S13, &HA679438E
md5_FF b, c, d, a, x(k + 15), S14, &H49B40821
 
md5_GG a, b, c, d, x(k + 1), S21, &HF61E2562
md5_GG d, a, b, c, x(k + 6), S22, &HC040B340
md5_GG c, d, a, b, x(k + 11), S23, &H265E5A51
md5_GG b, c, d, a, x(k + 0), S24, &HE9B6C7AA
md5_GG a, b, c, d, x(k + 5), S21, &HD62F105D
md5_GG d, a, b, c, x(k + 10), S22, &H2441453
md5_GG c, d, a, b, x(k + 15), S23, &HD8A1E681
md5_GG b, c, d, a, x(k + 4), S24, &HE7D3FBC8
md5_GG a, b, c, d, x(k + 9), S21, &H21E1CDE6
md5_GG d, a, b, c, x(k + 14), S22, &HC33707D6
md5_GG c, d, a, b, x(k + 3), S23, &HF4D50D87
md5_GG b, c, d, a, x(k + 8), S24, &H455A14ED
md5_GG a, b, c, d, x(k + 13), S21, &HA9E3E905
md5_GG d, a, b, c, x(k + 2), S22, &HFCEFA3F8
md5_GG c, d, a, b, x(k + 7), S23, &H676F02D9
md5_GG b, c, d, a, x(k + 12), S24, &H8D2A4C8A
 
md5_HH a, b, c, d, x(k + 5), S31, &HFFFA3942
md5_HH d, a, b, c, x(k + 8), S32, &H8771F681
md5_HH c, d, a, b, x(k + 11), S33, &H6D9D6122
md5_HH b, c, d, a, x(k + 14), S34, &HFDE5380C
md5_HH a, b, c, d, x(k + 1), S31, &HA4BEEA44
md5_HH d, a, b, c, x(k + 4), S32, &H4BDECFA9
md5_HH c, d, a, b, x(k + 7), S33, &HF6BB4B60
md5_HH b, c, d, a, x(k + 10), S34, &HBEBFBC70
md5_HH a, b, c, d, x(k + 13), S31, &H289B7EC6
md5_HH d, a, b, c, x(k + 0), S32, &HEAA127FA
md5_HH c, d, a, b, x(k + 3), S33, &HD4EF3085
md5_HH b, c, d, a, x(k + 6), S34, &H4881D05
md5_HH a, b, c, d, x(k + 9), S31, &HD9D4D039
md5_HH d, a, b, c, x(k + 12), S32, &HE6DB99E5
md5_HH c, d, a, b, x(k + 15), S33, &H1FA27CF8
md5_HH b, c, d, a, x(k + 2), S34, &HC4AC5665
 
md5_II a, b, c, d, x(k + 0), S41, &HF4292244
md5_II d, a, b, c, x(k + 7), S42, &H432AFF97
md5_II c, d, a, b, x(k + 14), S43, &HAB9423A7
md5_II b, c, d, a, x(k + 5), S44, &HFC93A039
md5_II a, b, c, d, x(k + 12), S41, &H655B59C3
md5_II d, a, b, c, x(k + 3), S42, &H8F0CCC92
md5_II c, d, a, b, x(k + 10), S43, &HFFEFF47D
md5_II b, c, d, a, x(k + 1), S44, &H85845DD1
md5_II a, b, c, d, x(k + 8), S41, &H6FA87E4F
md5_II d, a, b, c, x(k + 15), S42, &HFE2CE6E0
md5_II c, d, a, b, x(k + 6), S43, &HA3014314
md5_II b, c, d, a, x(k + 13), S44, &H4E0811A1
md5_II a, b, c, d, x(k + 4), S41, &HF7537E82
md5_II d, a, b, c, x(k + 11), S42, &HBD3AF235
md5_II c, d, a, b, x(k + 2), S43, &H2AD7D2BB
md5_II b, c, d, a, x(k + 9), S44, &HEB86D391
 
a = AddUnsigned(a, AA)
b = AddUnsigned(b, BB)
c = AddUnsigned(c, CC)
d = AddUnsigned(d, DD)
Next
 
If stype = 32 Then
MD5 = LCase(WordToHex(a) & WordToHex(b) & WordToHex(c) & WordToHex(d))
Else
MD5 = LCase(WordToHex(b) & WordToHex(c))
End If
End Function
'-------------------------------------------------------------------------------------------------------------------
Private Function hash(code As String) As String
    hash = MD5(code, 32)
End Function
'2个长整数的加减法运算(最大长度无限)
Function js(num1 As String, num2 As String, mType As Integer) As String
Dim a1 As String, a2 As String
Dim s1() As String, S2() As String, Resu() As String
Dim i As Integer, j As Integer, k As Integer, Tmp As String
Dim t1 As Integer, t2 As Integer, Jw As Integer, Fh As String
If Not IsNumeric(num1) Or Not IsNumeric(num2) Then
   MsgBox "参于运算的只能是数字，不能含有其他字符", vbCritical, "错误提示"
   End
   Exit Function
End If
If Len(num1) < Len(num2) Or (Len(num1) = Len(num2) And Left(num1, 1) < Left(num2, 1)) Then
   a1 = num2
   a2 = num1
   Fh = IIf(mType = 1, "-", "") '减法运算出现负数的情况
Else
   a1 = num1
   a2 = num2
End If
i = Len(a1)
j = Len(a2)
ReDim s1(i - 1), S2(j - 1)
ReDim Resu(IIf(mType = 0, i, i - 1))
For k = Len(a1) To 1 Step -1 '把数a1逐个放入数组s1
 s1(i - k) = Mid(a1, k, 1)
Next
For k = Len(a2) To 1 Step -1 '把数a2逐个放入数组s2
 S2(j - k) = Mid(a2, k, 1)
Next
Jw = 0
For k = 0 To UBound(Resu) '从个位数开始相加减，结果入入数组resu
  If k > UBound(s1) Then
    t1 = 0
  Else
    t1 = Val(s1(k))
  End If
  If k > UBound(S2) Then
    t2 = 0
  Else
    t2 = Val(S2(k))
  End If
  Select Case mType
  Case 0  '加法运算
    Tmp = t1 + t2 + Jw
    If Len(Tmp) > 1 Then
      Jw = Val(Left(Tmp, Len(Tmp) - 1))
    Else
      Jw = 0
    End If
    Tmp = Right(Tmp, 1)
  Case 1 '减法运算
    i = t1 + Jw - t2
    If i < 0 Then
      Tmp = i + 10
      Jw = -1
    Else
      Tmp = i
      Jw = 0
    End If
  End Select
  Resu(k) = Tmp
Next
j = UBound(Resu)
For i = 0 To j '合并数组resu，结果输出到js1
  js = js & Resu(j - i)
Next
For i = 1 To Len(js) '去掉前面的0
  If Mid(js, i, 1) > "0" Then Exit For
Next
js = Fh & Mid(js, i)
  
End Function


Private Function cheng(num1 As String, num2 As String) As String
    Dim newnum As String
    newnum = num1
    While Val(num2) > 1
        num2 = js(Val(num2), "1", 1)
        newnum = js(Val(newnum), Val(num1), 0)
    Wend
    cheng = newnum
End Function
Private Function cifang(di As String, zhi As String) As String
    Dim newnum As String, di2 As String
    di2 = di
    newnum = di
    
    While Val(zhi) > 1
        
        zhi = js(Val(zhi), 1, 1)
        'MsgBox newnum + "x" + di + "="
        If di = 1 Then MsgBox "error"
        newnum = cheng(newnum, di)
        di = di2
        'MsgBox newnum
    Wend
    cifang = newnum
End Function
Private Function mode(num1 As String, num2 As String) As String
    While Val(num1) > Val(num2)
        'MsgBox num1 + ">" + num2
        'MsgBox num1 + "-" + num2 + "="
        num1 = js(num1, num2, 1)
        'MsgBox num1
    Wend
    mode = num1
End Function
Private Function bstr(code As String, str1 As String, str2 As String)
    'On Error GoTo e
    bstr = Split(Split(code, str1)(1), str2)(0)
    Exit Function
e:
    
    bstr = "null"
End Function
Private Function creatdata(basename As String, data As String) As String
    creatdata = basename + "=" + data + ";"
End Function
Private Function readata(basename As String, base As String)
    'On Error GoTo e
    readata = bstr(base, basename + "=", ";")
    Exit Function
e:
    readata = "null"
End Function
Private Function rsajia(p As Integer, q As Integer, key As String, x As String) As String
    Dim n As String
    n = cheng(p, q)
    rsajia = mode(cifang(x, key), n)
    
End Function
Private Function rsajie(p As Integer, q As Integer, key As String, y As String) As String
    Dim n As String
    n = cheng(p, q)
    rsajie = mode(cifang(y, key), n)
End Function
Private Function readfile(filename As String)
Open filename For Input As #1
Dim b As String

   Do While Not EOF(1)
       Input #1, b
       readfile = readfile + b
   Loop
   Close #1
End Function
Public Sub writefile(filename As String, data As String)
    Open filename For Output As #1
        Print #2, data
        Print #2, chain
    Close #2
        
End Sub
Private Function openURL(url As String)
Dim xmlHTTP1
Set xmlHTTP1 = CreateObject("Microsoft.XMLHTTP")
xmlHTTP1.Open "get", url, True
xmlHTTP1.send
While xmlHTTP1.readyState <> 4
DoEvents
Wend
openURL = xmlHTTP1.responseText
Set xmlHTTP1 = Nothing
End Function
Private Function changedata(basename As String, newdata As String, base As String) As String
    Dim oldstr As String, newstr As String
    'On Error GoTo e
    oldstr = creatdata(basename, readata(basename, base))
    newstr = creatdata(basename, newdata)
    'On Error GoTo e
    changedata = Replace(base, oldstr, newstr)
    Exit Function
e:
    changedata = base
    
End Function
Private Function killdata(basename As String, base As String) As String
    'On Error GoTo e
    killdata = Replace(base, basename + "=" + readata(basename, base) + ";", "")
    Exit Function
e:
    killdata = base
    
End Function
Public Sub addseed(url As String)

End Sub
Public Sub addtracker(url As String)
    
End Sub
Private Function addcommand(code As String) As String  '返回最长链的信息
    Dim blocknum As Long, i As Long, chain(1) As String, errorlist2 As String
    errorlist2 = "null"
    blocknum = Val(readfile("maxinum.txt")) + 1
    writefile "maxinum.txt", blocknum
    writefile "block" & blocknum & ".txt", code
strart:
    blocknum = Val(readfile("maxinum.txt"))
    For i = 1 To blocknum
        Dim block As String, lasthash As String
        block = readfile("block" & i & ".txt")
        lasthash = readata("lasthash", block)
        If lasthash = "framechain" Then
            Dim chainum As Long, chain2() As String, k As Long
            chainum = chainum + 1
            If chainum = 1 Then
                chain(1) = creatdata("lasthash", lasthash) + creatdata("blocknum", 1)
            Else:
                For k = 1 To chainum - 1
                    chain2(k) = chain(k)
                Next
                ReDim chain(1 To chainum) As String
                For k = 1 To chainum - 1
                    chain(k) = chain2(k)
                Next
                chain(chainum) = creatdata("lasthash", lasthash + creatdata("blocknum", 1))
            End If
        Else:
            Dim j As Long
            For j = 1 To chainum
                If readata("lasthash", chain(j)) = lasthash Then
                    Dim ch As String
                    ch = check(chain(j), blocj)
                    If Len(ch) > 0 Then
                        chainum = chainum + 1
                        For k = 1 To chainum - 1
                             chain2(k) = chain(k)
                        Next
                        ReDim chain(1 To chainum) As String
                        For k = 1 To chainum - 1
                            chain(k) = chain2(k)
                        Next
                        chain(chainum) = ch
                    Else:
                        Kill "block" & i & ".txt"
                        For k = 1 To blocknum - 1
                            FileCopy "block" & (k + 1) & ".txt", block & k & ".txt"
                        Next
                        Kill "block" & blocknum & ".txt"
                        blocknum = blocknum - 1
                        writefile "maxinum.txt", blocknum
                    End If
                Else:
                    Dim errorlist As String
                    errorlist = errorlist & j & ";"
                End If
            Next
        End If
    Next
    If errorlist2 = "null" Then
        If Len(errorlist) > 0 Then
           errorlist2 = errorlist
           GoTo start
        End If
    Else:
        If errorlist <> errorlist2 Then GoTo start
    End If
    Dim best As String
    best = reatdata("blocknum", 0)
    For i = 1 To chainum
        If Val(readata("blocknum", chain(i))) > Val(readata("blocknum", bset)) Then best = chain(i)
    Next
    addcommand = best
                
            
End Function
Private Function check(bar As String, code As String) As String
    Dim address As String, command As String, tip As String, lasthash As String, aut As String
    Dim p As Integer, q As Integer, key As Integer
    address = readata("address", code)
    p = Val(Split(address, ",")(0))
    q = Val(Split(address, ",")(1))
    key = Split(address, ",")(2)
    aut = readata("aut", code)
    command = bstr(code, "command{", "}")
    tip = bstr(code, "tip{", "}")
    lasthash = readata("lasthash", code)
    If rsajie(p, q, key, aut) <> Val(hash(command + tip + lasthash)) Then
        chexk = ""
        Exit Function
    End If
    '如果不存在该用户直接创建一个
Dim chaintmp As String
chaintmp = bar
If Not InStr(chaintmp, address) Then chaintmp = chaintmp + creatdata(address, 0)
'判断并读取区块
Dim blocknum As Long, lasthash As String, applist As String
If Not InStr(chaintmp, "blocknum") Then chaintmp = chaintmp + creatdata("blocknum", 1) + creatdata("lasthash", "framechain") + creatdata("applist", "")
Dim t As String, money As Single, m As Single, ty As String, y As Single

t = readata("to", tip)
money = Val(readata("money", tip))
m = Val(readata(address, chaintmp)) - money
y = Val(readata(t, chaintmp)) + money
If m >= 0 Then
    chaintmp = changedata(address, m, chaintmp)
    chaintmp = changedata(t, y, chaintmp)
Else:
    check = ""
    Exit Function
End If
ty = readata("type", command)
If ty = "cash" Then
    money = Val(readata("money", command))
    t = readata("to", command)
    m = Val(readata(address, chaintmp)) - money
    y = Val(readata(t, chaintmp)) + money
    If m >= 0 Then
        chaintmp = changedata(address, m, chaintmp)
        chaintmp = changedata(t, y, chaintmp)
    Else:
        check = ""
        Exit Function
    End If
End If
blocknum = Val(readata("blocknum", caintmp))
lasthash = readata("lasthash", chaintmp)
applist = readata("applist", chaintmp)
If ty = "mining" Then
    Dim mining As String
    mining = readata("key", command)
    If mode(hash(chaintmp + mining), 5000 * blocknum) = 1 Then
        m = Val(readata(address, chaintmp)) + 50
        blocknum = blocknum + 1
    Else:
        check = ""
        Exit Function
    End If
End If
If ty = "software" Then
    Dim code As String, h As String
    code = readata("code", command)
    h = readata("hash", command)
    money = Val(readata("money", command))
    m = Val(readata(address, chaintmp)) - money * 1.1 - 20
    If m >= 0 Then
        chaintmp = changedata(address, m, chaintmp) + creatdata(hash(command) + "hash", h) + creatdata(hash(command) + "code", code) + creatdata(hash(command) + "money", money) + creatdata(hash(command) + "user", "null") + creatdata(hash(command) + "author", address)
        applist = applist + hash(command) + ","
    Else:
        check = ""
        Exit Function
    End If
End If
If ty = "app" Then
    h = readata("hash", command)
    If readata(h + "user") <> "null" Then
        m = Val(readata(address, chaintmp)) - Val(readata(h + "money", chaintmp)) * 0.1
        If m >= 0 Then
            chaintmp = changedata(h + "user", address, chaintmp)
            chaintmp = changedata(address, m, chaintmp)
        Else:
            check = ""
            Exit Function
        End If
    Else:
        check = ""
        Exit Function
    End If
End If
If ty = "get" Then
    Dim result As String
    result = hash(readata("result", command)) + ","
    h = readata("hash", command)
    If InStr(readata(h + "hash", chaintmp), result) And readata(h + "user", chaintmp) = address Then
        money = Val(readata(h + "money", chaintmp))
        m = Val(readata(address, chintmp)) + money * 1.1
        Dim author As String
        author = readata(h + "author", chaintmp)
        y = Val(readata(author, chaintmp)) + money * 0.1
        chaintmp = changedata(address, m, chaintmp)
        chaintmp = changedata(author, y, chaintmp)
        chaintmp = killdata(h + "hash", chaintmp)
        chaintmp = killdata(h + "code", chaintmp)
        chaintmp = killdata(h + "money", chaintmp)
        chaintmp = killdata(h + "user", chaintmp)
        chaintmp = killdata(h + "author", chaintmp)
        applist = Replace(applist, h, "")
    Else:
        check = ""
        Exit Function
    End If
End If
If ty = "hongbao" Then
    money = Val(readata("money", command))
    h = readata("hash", command)
    m = Val(readata(address, chaintmp)) - money
    If m >= 0 Then
        chaintmp = changedata(address, m, chaintmp) + creatdata(address + h, money)
    Else:
        check = ""
        Exit Function
    End If
End If
If ty = "rsv" Then
    Dim user As String
    user = readata("user", command)
    result = readata("result", command)
    m = Val(readata(address, chaintmp)) + Val(readata(user + hash(result), chaintmp))
    chaintmp = changedata(address, m, chaintmp)
End If
lasthash = hash(chaintmp)
chaintmp = changedata("blocknum", blocknum, chaintmp)
chaintmp = changedata("lasthash", lasthash, chaintmp)
chaintmp = changedata("applist", applist, chaintmp)
check = chaintmp
End Function
Private Sub Form_Load()

MsgBox getnum("abca", "a")

End Sub
