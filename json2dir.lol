HAI 1.4
BTW json2dir evaluator in LOLCODE (lci). Reads input.json from the current directory,
BTW checks UTF-8, parses and validates the JSON document and VISIBLEs a shell script.
BTW On any error it writes a message to stderr and stops without the end marker.
CAN HAS STDIO?
CAN HAS STRING?

I HAS A G ITZ A BUKKIT
G HAS A n ITZ 0
G HAS A pos ITZ 0
I HAS A IN ITZ A BUKKIT
I HAS A ORD ITZ A BUKKIT
I HAS A CHR ITZ A BUKKIT

HOW IZ I die YR msg
  INVISIBLE SMOOSH "json2dir:: " AN msg MKAY
  BTW lci stops with a non-zero exit status on an unknown variable
  VISIBLE J2D_STOP_HERE
IF U SAY SO

HOW IZ I lt YR a AN YR b
  FOUND YR DIFFRINT a AN BIGGR OF a AN b
IF U SAY SO

HOW IZ I between YR v AN YR lo AN YR hi
  FOUND YR BOTH OF BOTH SAEM v AN BIGGR OF v AN lo AN BOTH SAEM v AN SMALLR OF v AN hi
IF U SAY SO

BTW ---- byte tables: ORD maps a one-byte string to its value, CHR the other way ----
HOW IZ I addbyte YR ch AN YR v
  ORD HAS A SRS SMOOSH "c" AN ch MKAY ITZ v
  CHR HAS A SRS v ITZ ch
IF U SAY SO

HOW IZ I addtable YR s AN YR start AN YR step AN YR first
  I HAS A len ITZ I IZ STRING'Z LEN YR s MKAY
  I HAS A i ITZ start
  I HAS A v ITZ first
  IM IN YR lp
    I IZ lt YR i AN YR len MKAY, O RLY?
      YA RLY
      NO WAI, GTFO
    OIC
    I IZ addbyte YR I IZ STRING'Z AT YR s AN YR i MKAY AN YR v MKAY
    i R SUM OF i AN step
    v R SUM OF v AN 1
  IM OUTTA YR lp
IF U SAY SO

I IZ addtable YR ":(01):(02):(03):(04):(05):(06):(07):(08):(09):(0A):(0B):(0C):(0D):(0E):(0F):(10):(11):(12):(13):(14):(15):(16):(17):(18):(19):(1A):(1B):(1C):(1D):(1E):(1F) !:"#$%&'()*+,-./0123456789::;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~:(7F)" AN YR 0 AN YR 1 AN YR 1 MKAY
BTW continuation bytes 80..BF: second byte of U+0080..U+00BF
I IZ addtable YR ":(80):(81):(82):(83):(84):(85):(86):(87):(88):(89):(8A):(8B):(8C):(8D):(8E):(8F):(90):(91):(92):(93):(94):(95):(96):(97):(98):(99):(9A):(9B):(9C):(9D):(9E):(9F):(A0):(A1):(A2):(A3):(A4):(A5):(A6):(A7):(A8):(A9):(AA):(AB):(AC):(AD):(AE):(AF):(B0):(B1):(B2):(B3):(B4):(B5):(B6):(B7):(B8):(B9):(BA):(BB):(BC):(BD):(BE):(BF)" AN YR 1 AN YR 2 AN YR 128 MKAY
BTW lead bytes C2..DF, E0..EF, F0..F4: first byte of suitable code points
BTW (lci encodes :(100)..:(7FF) wrongly, so most two-byte characters are written as is)
I IZ addtable YR ":(80)ÀĀŀƀǀȀɀʀˀ̀̀΀πЀрҀӀԀՀր׀؀ـڀۀ܀݀ހ߀" AN YR 0 AN YR 2 AN YR 194 MKAY
I IZ addtable YR ":(800):(1000):(2000):(3000):(4000):(5000):(6000):(7000):(8000):(9000):(A000):(B000):(C000):(D000):(E000):(F000)" AN YR 0 AN YR 3 AN YR 224 MKAY
I IZ addtable YR ":(10000):(40000):(80000):(C0000):(100000)" AN YR 0 AN YR 4 AN YR 240 MKAY

BTW Bytes C0, C1 and F5..FF never occur in UTF-8 and are not in ORD:
BTW looking one up stops lci with an error, which rejects the input.
HOW IZ I ord YR ch
  FOUND YR ORD'Z SRS SMOOSH "c" AN ch MKAY
IF U SAY SO

BTW ---- reading the input ----
BTW LUK returns "" both at end of file and for a NUL byte. After the first "",
BTW append a byte to the file and look at the same position again: if it is
BTW still "", the input had a NUL there (never valid JSON, RFC section 10).
HOW IZ I readinput
  I HAS A path ITZ "input.json"
  I HAS A f ITZ I IZ STDIO'Z OPEN YR path AN YR "r" MKAY
  I IZ STDIO'Z DIAF YR f MKAY, O RLY?
    YA RLY, I IZ die YR "couldn't read the input" MKAY
  OIC
  I HAS A n ITZ 0
  IM IN YR lp
    I HAS A c ITZ I IZ STDIO'Z LUK YR f AN YR 1 MKAY
    BOTH SAEM c AN "", O RLY?
      YA RLY, GTFO
    OIC
    IN HAS A SRS n ITZ c
    n R SUM OF n AN 1
  IM OUTTA YR lp
  I IZ STDIO'Z CLOSE YR f MKAY
  f R I IZ STDIO'Z OPEN YR path AN YR "a" MKAY
  I IZ STDIO'Z SCRIBBEL YR f AN YR "x" MKAY
  I IZ STDIO'Z CLOSE YR f MKAY
  f R I IZ STDIO'Z OPEN YR path AN YR "r" MKAY
  DIFFRINT n AN 0, O RLY?
    YA RLY, I IZ STDIO'Z LUK YR f AN YR n MKAY
  OIC
  I HAS A c ITZ I IZ STDIO'Z LUK YR f AN YR 1 MKAY
  I IZ STDIO'Z CLOSE YR f MKAY
  BOTH SAEM c AN "", O RLY?
    YA RLY, I IZ die YR "the input contains a NUL byte" MKAY
  OIC
  G'Z n R n
IF U SAY SO

HOW IZ I byteat YR i
  FOUND YR I IZ ord YR IN'Z SRS i MKAY
IF U SAY SO

HOW IZ I iscont YR i
  I IZ lt YR i AN YR G'Z n MKAY, O RLY?
    YA RLY
    NO WAI, FOUND YR FAIL
  OIC
  FOUND YR I IZ between YR I IZ byteat YR i MKAY AN YR 128 AN YR 191 MKAY
IF U SAY SO

BTW strict UTF-8 (RFC 3629): no overlongs, no surrogates, nothing above U+10FFFF
HOW IZ I checkutf8
  I HAS A i ITZ 0
  I HAS A n ITZ G'Z n
  IM IN YR lp
    I IZ lt YR i AN YR n MKAY, O RLY?
      YA RLY
      NO WAI, GTFO
    OIC
    I HAS A b ITZ I IZ byteat YR i MKAY
    I HAS A more ITZ 0
    I HAS A lo ITZ 128
    I HAS A hi ITZ 191
    I IZ lt YR b AN YR 128 MKAY, O RLY?
      YA RLY, more R 0
      MEBBE I IZ between YR b AN YR 194 AN YR 223 MKAY
        more R 1
      MEBBE BOTH SAEM b AN 224
        more R 2, lo R 160
      MEBBE BOTH SAEM b AN 237
        more R 2, hi R 159
      MEBBE I IZ between YR b AN YR 225 AN YR 239 MKAY
        more R 2
      MEBBE BOTH SAEM b AN 240
        more R 3, lo R 144
      MEBBE BOTH SAEM b AN 244
        more R 3, hi R 143
      MEBBE I IZ between YR b AN YR 241 AN YR 243 MKAY
        more R 3
      NO WAI
        I IZ die YR "the input is not valid UTF-8" MKAY
    OIC
    DIFFRINT more AN 0, O RLY?
      YA RLY
        I HAS A ok ITZ FAIL
        I IZ lt YR SUM OF i AN 1 AN YR n MKAY, O RLY?
          YA RLY, ok R I IZ between YR I IZ byteat YR SUM OF i AN 1 MKAY AN YR lo AN YR hi MKAY
        OIC
        NOT ok, O RLY?
          YA RLY, I IZ die YR "the input is not valid UTF-8" MKAY
        OIC
        I HAS A k ITZ 2
        IM IN YR cl
          I IZ lt YR more AN YR k MKAY, O RLY?
            YA RLY, GTFO
          OIC
          NOT I IZ iscont YR SUM OF i AN k MKAY, O RLY?
            YA RLY, I IZ die YR "the input is not valid UTF-8" MKAY
          OIC
          k R SUM OF k AN 1
        IM OUTTA YR cl
    OIC
    i R SUM OF i AN SUM OF more AN 1
  IM OUTTA YR lp
IF U SAY SO

BTW ---- JSON parser ----
HOW IZ I peek
  I IZ lt YR G'Z pos AN YR G'Z n MKAY, O RLY?
    YA RLY, FOUND YR IN'Z SRS G'Z pos
  OIC
  FOUND YR ""
IF U SAY SO

HOW IZ I next
  I HAS A c ITZ I IZ peek MKAY
  G'Z pos R SUM OF G'Z pos AN 1
  FOUND YR c
IF U SAY SO

HOW IZ I skipws
  IM IN YR lp
    I HAS A c ITZ I IZ peek MKAY
    ANY OF BOTH SAEM c AN " " AN BOTH SAEM c AN ":>" AN BOTH SAEM c AN ":)" AN BOTH SAEM c AN CHR'Z SRS 13 MKAY, O RLY?
      YA RLY, G'Z pos R SUM OF G'Z pos AN 1
      NO WAI, GTFO
    OIC
  IM OUTTA YR lp
IF U SAY SO

HOW IZ I expect YR want
  DIFFRINT I IZ next MKAY AN want, O RLY?
    YA RLY, I IZ die YR SMOOSH "invalid JSON:: expected " AN want MKAY MKAY
  OIC
IF U SAY SO

HOW IZ I hexval
  I HAS A c ITZ I IZ next MKAY
  BOTH SAEM c AN "", O RLY?
    YA RLY, I IZ die YR "invalid JSON:: bad \u escape" MKAY
  OIC
  I HAS A b ITZ I IZ ord YR c MKAY
  I IZ between YR b AN YR 48 AN YR 57 MKAY, O RLY?
    YA RLY, FOUND YR DIFF OF b AN 48
  OIC
  I IZ between YR b AN YR 65 AN YR 70 MKAY, O RLY?
    YA RLY, FOUND YR DIFF OF b AN 55
  OIC
  I IZ between YR b AN YR 97 AN YR 102 MKAY, O RLY?
    YA RLY, FOUND YR DIFF OF b AN 87
  OIC
  I IZ die YR "invalid JSON:: bad \u escape" MKAY
IF U SAY SO

HOW IZ I hex4
  I HAS A v ITZ 0
  IM IN YR lp UPPIN YR k TIL BOTH SAEM k AN 4
    v R SUM OF PRODUKT OF v AN 16 AN I IZ hexval MKAY
  IM OUTTA YR lp
  FOUND YR v
IF U SAY SO

HOW IZ I utf8 YR cp
  I IZ lt YR cp AN YR 128 MKAY, O RLY?
    YA RLY, FOUND YR CHR'Z SRS cp
  OIC
  I IZ lt YR cp AN YR 2048 MKAY, O RLY?
    YA RLY, FOUND YR SMOOSH CHR'Z SRS SUM OF 192 AN QUOSHUNT OF cp AN 64 AN CHR'Z SRS SUM OF 128 AN MOD OF cp AN 64 MKAY
  OIC
  I IZ lt YR cp AN YR 65536 MKAY, O RLY?
    YA RLY, FOUND YR SMOOSH CHR'Z SRS SUM OF 224 AN QUOSHUNT OF cp AN 4096 AN CHR'Z SRS SUM OF 128 AN MOD OF QUOSHUNT OF cp AN 64 AN 64 AN CHR'Z SRS SUM OF 128 AN MOD OF cp AN 64 MKAY
  OIC
  FOUND YR SMOOSH CHR'Z SRS SUM OF 240 AN QUOSHUNT OF cp AN 262144 AN CHR'Z SRS SUM OF 128 AN MOD OF QUOSHUNT OF cp AN 4096 AN 64 AN CHR'Z SRS SUM OF 128 AN MOD OF QUOSHUNT OF cp AN 64 AN 64 AN CHR'Z SRS SUM OF 128 AN MOD OF cp AN 64 MKAY
IF U SAY SO

BTW A string node holds its text already escaped for a single-quoted shell word,
BTW split at NUL characters into parts p0, p1, ... (np of them).
HOW IZ I newnode YR t
  I HAS A node ITZ A BUKKIT
  node HAS A t ITZ t
  node HAS A n ITZ 0
  FOUND YR node
IF U SAY SO

HOW IZ I parsestring
  I HAS A node ITZ I IZ newnode YR "s" MKAY
  node HAS A slash ITZ FAIL
  I HAS A cur ITZ ""
  BTW characters go into a short chunk first, so long strings are not copied per character
  I HAS A chunk ITZ ""
  I HAS A cn ITZ 0
  IM IN YR lp
    I HAS A c ITZ I IZ next MKAY
    BOTH SAEM c AN "", O RLY?
      YA RLY, I IZ die YR "invalid JSON:: unterminated string" MKAY
    OIC
    BOTH SAEM c AN ":"", O RLY?
      YA RLY, GTFO
    OIC
    BOTH SAEM c AN "\", O RLY?
      YA RLY
        I HAS A e ITZ I IZ next MKAY
        BOTH SAEM e AN ":"", O RLY?
          YA RLY, c R ":""
          MEBBE BOTH SAEM e AN "\"
            c R "\"
          MEBBE BOTH SAEM e AN "/"
            c R "/"
          MEBBE BOTH SAEM e AN "b"
            c R CHR'Z SRS 8
          MEBBE BOTH SAEM e AN "f"
            c R CHR'Z SRS 12
          MEBBE BOTH SAEM e AN "n"
            c R ":)"
          MEBBE BOTH SAEM e AN "r"
            c R CHR'Z SRS 13
          MEBBE BOTH SAEM e AN "t"
            c R ":>"
          MEBBE BOTH SAEM e AN "u"
            I HAS A cp ITZ I IZ hex4 MKAY
            I IZ between YR cp AN YR 56320 AN YR 57343 MKAY, O RLY?
              YA RLY, I IZ die YR "invalid JSON:: unpaired surrogate" MKAY
            OIC
            I IZ between YR cp AN YR 55296 AN YR 56319 MKAY, O RLY?
              YA RLY
                BOTH OF BOTH SAEM I IZ next MKAY AN "\" AN BOTH SAEM I IZ next MKAY AN "u", O RLY?
                  YA RLY
                  NO WAI, I IZ die YR "invalid JSON:: unpaired surrogate" MKAY
                OIC
                I HAS A lo ITZ I IZ hex4 MKAY
                NOT I IZ between YR lo AN YR 56320 AN YR 57343 MKAY, O RLY?
                  YA RLY, I IZ die YR "invalid JSON:: unpaired surrogate" MKAY
                OIC
                cp R SUM OF 65536 AN SUM OF PRODUKT OF DIFF OF cp AN 55296 AN 1024 AN DIFF OF lo AN 56320
            OIC
            BOTH SAEM cp AN 0, O RLY?
              YA RLY
                node HAS A SRS SMOOSH "p" AN node'Z n MKAY ITZ SMOOSH cur AN chunk MKAY
                chunk R "", cn R 0
                node'Z n R SUM OF node'Z n AN 1
                cur R ""
                c R ""
              NO WAI
                c R I IZ utf8 YR cp MKAY
            OIC
          NO WAI
            I IZ die YR "invalid JSON:: bad escape in string" MKAY
        OIC
      NO WAI
        I IZ lt YR I IZ ord YR c MKAY AN YR 32 MKAY, O RLY?
          YA RLY, I IZ die YR "invalid JSON:: control character in string" MKAY
        OIC
    OIC
    BOTH SAEM c AN "/", O RLY?
      YA RLY, node'Z slash R WIN
    OIC
    BOTH SAEM c AN "'", O RLY?
      YA RLY, c R "'\''"
    OIC
    chunk R SMOOSH chunk AN c MKAY
    cn R SUM OF cn AN 1
    BOTH SAEM cn AN 1000, O RLY?
      YA RLY, cur R SMOOSH cur AN chunk MKAY, chunk R "", cn R 0
    OIC
  IM OUTTA YR lp
  node HAS A SRS SMOOSH "p" AN node'Z n MKAY ITZ SMOOSH cur AN chunk MKAY
  node'Z n R SUM OF node'Z n AN 1
  FOUND YR node
IF U SAY SO

BTW compare two names by their bytes: -1, 0 or 1
HOW IZ I cmp YR a AN YR b
  I HAS A la ITZ I IZ STRING'Z LEN YR a MKAY
  I HAS A lb ITZ I IZ STRING'Z LEN YR b MKAY
  I HAS A i ITZ 0
  IM IN YR lp
    BOTH SAEM i AN la, O RLY?
      YA RLY
        BOTH SAEM i AN lb, O RLY?
          YA RLY, FOUND YR 0
        OIC
        FOUND YR -1
    OIC
    BOTH SAEM i AN lb, O RLY?
      YA RLY, FOUND YR 1
    OIC
    I HAS A ca ITZ I IZ ord YR I IZ STRING'Z AT YR a AN YR i MKAY MKAY
    I HAS A cb ITZ I IZ ord YR I IZ STRING'Z AT YR b AN YR i MKAY MKAY
    I IZ lt YR ca AN YR cb MKAY, O RLY?
      YA RLY, FOUND YR -1
    OIC
    I IZ lt YR cb AN YR ca MKAY, O RLY?
      YA RLY, FOUND YR 1
    OIC
    i R SUM OF i AN 1
  IM OUTTA YR lp
IF U SAY SO

BTW members kept sorted by name bytes; a duplicate name keeps the last value
HOW IZ I addmember YR obj AN YR name AN YR val
  I HAS A n ITZ obj'Z n
  I HAS A j ITZ n
  IM IN YR lp UPPIN YR i TIL BOTH SAEM i AN n
    I HAS A r ITZ I IZ cmp YR name AN YR obj'Z SRS SMOOSH "k" AN i MKAY MKAY
    BOTH SAEM r AN 0, O RLY?
      YA RLY
        obj'Z SRS SMOOSH "v" AN i MKAY R val
        FOUND YR obj
    OIC
    BOTH SAEM r AN -1, O RLY?
      YA RLY, j R i, GTFO
    OIC
  IM OUTTA YR lp
  obj HAS A SRS SMOOSH "k" AN n MKAY ITZ ""
  obj HAS A SRS SMOOSH "v" AN n MKAY ITZ ""
  I HAS A m ITZ n
  IM IN YR sh
    I IZ lt YR j AN YR m MKAY, O RLY?
      YA RLY
      NO WAI, GTFO
    OIC
    obj'Z SRS SMOOSH "k" AN m MKAY R obj'Z SRS SMOOSH "k" AN DIFF OF m AN 1 MKAY
    obj'Z SRS SMOOSH "v" AN m MKAY R obj'Z SRS SMOOSH "v" AN DIFF OF m AN 1 MKAY
    m R DIFF OF m AN 1
  IM OUTTA YR sh
  obj'Z SRS SMOOSH "k" AN j MKAY R name
  obj'Z SRS SMOOSH "v" AN j MKAY R val
  obj'Z n R SUM OF n AN 1
  FOUND YR obj
IF U SAY SO

HOW IZ I parseobject
  I HAS A obj ITZ I IZ newnode YR "o" MKAY
  I IZ skipws MKAY
  BOTH SAEM I IZ peek MKAY AN "}", O RLY?
    YA RLY
      G'Z pos R SUM OF G'Z pos AN 1
      FOUND YR obj
  OIC
  IM IN YR lp
    I IZ skipws MKAY
    I IZ expect YR ":"" MKAY
    I HAS A key ITZ I IZ parsestring MKAY
    I IZ skipws MKAY
    I IZ expect YR "::" MKAY
    I HAS A val ITZ I IZ parsevalue MKAY
    I HAS A name ITZ key'Z SRS "p0"
    ANY OF DIFFRINT key'Z n AN 1 AN key'Z slash AN BOTH SAEM name AN "" AN BOTH SAEM name AN "." AN BOTH SAEM name AN ".." MKAY, O RLY?
      YA RLY, I IZ die YR SMOOSH "invalid name:: '" AN name AN "'" MKAY MKAY
    OIC
    BOTH SAEM val'Z t AN "o", O RLY?
      YA RLY
      NO WAI
        BOTH SAEM val'Z t AN "s", O RLY?
          YA RLY
          NO WAI
            BOTH SAEM val'Z t AN "a", O RLY?
              YA RLY
              NO WAI, I IZ die YR SMOOSH "invalid value at '" AN name AN "'" MKAY MKAY
            OIC
        OIC
    OIC
    I IZ addmember YR obj AN YR name AN YR val MKAY
    I IZ skipws MKAY
    I HAS A c ITZ I IZ next MKAY
    BOTH SAEM c AN "}", O RLY?
      YA RLY, GTFO
    OIC
    DIFFRINT c AN ",", O RLY?
      YA RLY, I IZ die YR "invalid JSON:: expected , or }" MKAY
    OIC
  IM OUTTA YR lp
  FOUND YR obj
IF U SAY SO

BTW only ["link", target] and ["script", content] are allowed
HOW IZ I parsearray
  I HAS A arr ITZ I IZ newnode YR "a" MKAY
  I IZ skipws MKAY
  BOTH SAEM I IZ peek MKAY AN "]", O RLY?
    YA RLY, I IZ die YR "invalid array:: expected [kind, payload]" MKAY
  OIC
  IM IN YR lp
    I HAS A v ITZ I IZ parsevalue MKAY
    arr HAS A SRS SMOOSH "e" AN arr'Z n MKAY ITZ v
    arr'Z n R SUM OF arr'Z n AN 1
    I IZ skipws MKAY
    I HAS A c ITZ I IZ next MKAY
    BOTH SAEM c AN "]", O RLY?
      YA RLY, GTFO
    OIC
    DIFFRINT c AN ",", O RLY?
      YA RLY, I IZ die YR "invalid JSON:: expected , or ]" MKAY
    OIC
  IM OUTTA YR lp
  I HAS A ok ITZ BOTH SAEM arr'Z n AN 2
  ok, O RLY?
    YA RLY, ok R BOTH OF BOTH SAEM arr'Z e0'Z t AN "s" AN BOTH SAEM arr'Z e1'Z t AN "s"
  OIC
  ok, O RLY?
    YA RLY, ok R BOTH SAEM arr'Z e0'Z n AN 1
  OIC
  ok, O RLY?
    YA RLY
      I HAS A kind ITZ arr'Z e0'Z p0
      arr HAS A kind ITZ kind
      EITHER OF BOTH SAEM kind AN "link" AN BOTH SAEM kind AN "script", O RLY?
        YA RLY
        NO WAI, ok R FAIL
      OIC
  OIC
  NOT ok, O RLY?
    YA RLY, I IZ die YR "invalid array:: expected [:"link:" or :"script:", string]" MKAY
  OIC
  BOTH OF BOTH SAEM arr'Z kind AN "link" AN DIFFRINT arr'Z e1'Z n AN 1, O RLY?
    YA RLY, I IZ die YR "a link target cannot contain NUL" MKAY
  OIC
  FOUND YR arr
IF U SAY SO

HOW IZ I parsevalue
  I IZ skipws MKAY
  I HAS A c ITZ I IZ next MKAY
  BOTH SAEM c AN "{", O RLY?
    YA RLY, FOUND YR I IZ parseobject MKAY
  OIC
  BOTH SAEM c AN "[", O RLY?
    YA RLY, FOUND YR I IZ parsearray MKAY
  OIC
  BOTH SAEM c AN ":"", O RLY?
    YA RLY, FOUND YR I IZ parsestring MKAY
  OIC
  I IZ die YR "invalid JSON or a value that is not an object, string or array" MKAY
IF U SAY SO

BTW ---- shell script output ----
HOW IZ I words YR node
  I HAS A s ITZ ""
  IM IN YR lp UPPIN YR i TIL BOTH SAEM i AN node'Z n
    s R SMOOSH s AN " '" AN node'Z SRS SMOOSH "p" AN i MKAY AN "'" MKAY
  IM OUTTA YR lp
  FOUND YR s
IF U SAY SO

HOW IZ I emit YR obj AN YR dir
  IM IN YR lp UPPIN YR i TIL BOTH SAEM i AN obj'Z n
    I HAS A path ITZ SMOOSH dir AN "/" AN obj'Z SRS SMOOSH "k" AN i MKAY MKAY
    I HAS A v ITZ obj'Z SRS SMOOSH "v" AN i MKAY
    BOTH SAEM v'Z t AN "o", O RLY?
      YA RLY
        VISIBLE "_j2d_dir '" AN path AN "'"
        I IZ emit YR v AN YR path MKAY
      MEBBE BOTH SAEM v'Z t AN "s"
        VISIBLE "_j2d_file '" AN path AN "'" AN I IZ words YR v MKAY
      MEBBE BOTH SAEM v'Z kind AN "script"
        VISIBLE "_j2d_script '" AN path AN "'" AN I IZ words YR v'Z e1 MKAY
      NO WAI
        VISIBLE "_j2d_link '" AN path AN "'" AN I IZ words YR v'Z e1 MKAY
    OIC
  IM OUTTA YR lp
IF U SAY SO

I IZ readinput MKAY
I IZ checkutf8 MKAY
I IZ skipws MKAY
DIFFRINT I IZ next MKAY AN "{", O RLY?
  YA RLY, I IZ die YR "the root of the document must be an object" MKAY
OIC
I HAS A root ITZ I IZ parseobject MKAY
I IZ skipws MKAY
I IZ lt YR G'Z pos AN YR G'Z n MKAY, O RLY?
  YA RLY, I IZ die YR "invalid JSON:: trailing data after the document" MKAY
OIC

VISIBLE "set -eu"
VISIBLE "_j2d_fail() { printf 'json2dir:: cannot create %s\n' :"$1:" >&2; exit 1; }"
VISIBLE "# Remove an existing non-directory (a symlink itself, never its target);"
VISIBLE "# a real directory in the way of a non-object is an error."
VISIBLE "_j2d_clear() {"
VISIBLE "  if [ -L :"$1:" ]; then rm -f -- :"$1:" || _j2d_fail :"$1:""
VISIBLE "  elif [ -d :"$1:" ]; then printf 'json2dir:: a directory is in the way:: %s\n' :"$1:" >&2; exit 1"
VISIBLE "  elif [ -e :"$1:" ]; then rm -f -- :"$1:" || _j2d_fail :"$1:""
VISIBLE "  fi"
VISIBLE "}"
VISIBLE "_j2d_dir() {"
VISIBLE "  if [ -L :"$1:" ] || { [ -e :"$1:" ] && [ ! -d :"$1:" ]; }; then rm -f -- :"$1:" || _j2d_fail :"$1:"; fi"
VISIBLE "  if [ ! -d :"$1:" ]; then mkdir -- :"$1:" || _j2d_fail :"$1:"; fi"
VISIBLE "}"
VISIBLE "# _j2d_file path part...:: the content is the parts joined by NUL bytes."
VISIBLE "_j2d_file() {"
VISIBLE "  _j2d_clear :"$1:""
VISIBLE "  _j2d_path=$1; shift"
VISIBLE "  {"
VISIBLE "    printf '%s' :"$1:"; shift"
VISIBLE "    for _j2d_part in :"$@:"; do printf '\000%s' :"$_j2d_part:"; done"
VISIBLE "  } > :"$_j2d_path:" || _j2d_fail :"$_j2d_path:""
VISIBLE "}"
VISIBLE "_j2d_script() { _j2d_file :"$@:"; chmod a+x -- :"$1:" || _j2d_fail :"$1:"; }"
VISIBLE "_j2d_link() { _j2d_clear :"$1:"; ln -s -- :"$2:" :"$1:" || _j2d_fail :"$1:"; }"
I IZ emit YR root AN YR "." MKAY
VISIBLE "# json2dir:: end"
KTHXBYE
